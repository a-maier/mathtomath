package Latex_out;
#define the output in LaTeX format

use 5.10.1;
use strict;
use Data::Dump;
use Operator;
#----------------------------------------------------------------------------------------------------
use base 'Printer';
#minimal size of brackets around fraction
#if the option bracket_scaling=incremental is set
my $frac_bracket_size=2;
my @bracket_size_modifier=('','\big','\Big','\bigg','\Bigg');

sub init{
    my $self=shift;
    $self->SUPER::init;
    %{$self->{specials}}=(
	'/' => \&ratio_as_frac,
	'*' => \&product,
	'^' => \&power
	);
}

sub number_to_string{
    return $_[0]->replace_local($_[1]);
}
sub symbol_to_string{
    return $_[0]->replace_local($_[1]);
}
sub string_to_string{
    return $_[0]->replace_local($_[1]);
}

sub bracket_to_string{
    my $self=shift;
    my $brackets=shift;
    my $args=shift;
    my %tree_info=@_;
    my $string_fun='';
    my %tree_info_fun=();
    my $string_arg;
    my $string;
    if(scalar @$args > 1){
	my $function=shift @$args;
        #special latex functions
	given($function->name){
	    when ('**subscript**'){return $self->subscript($args,%tree_info)}
	    when ('**sqrt**'){return $self->sqrt($args,%tree_info)}
	}
	($string_fun,%tree_info_fun)=$self->to_string($function,%tree_info);
    }
    ($string_arg,%tree_info)=$self->to_string($$args[0],%tree_info);
    
    #treat bracket scaling
    if(defined $self->{options}->{bracket_scaling}){
	given($self->{options}->{bracket_scaling}){
	    when(/^auto/){$$brackets[0]='\left'.$$brackets[0];$$brackets[1]='\right'.$$brackets[1]}
	    #incremental bracket scaling: 
	    # make this bracket one unit larger than the largest bracket in the argument
	    when(/^inc/){
		if(defined $tree_info{last_bracket_size}){
		    #there are brackets in the argument
		    ++$tree_info{last_bracket_size};
		    map {$_=$self->bracket_size($tree_info{last_bracket_size},$_)} @$brackets;
		}
		else{
		    #no previous bracket
		    $tree_info{last_bracket_size}=0;
		}
	    }
	}
    }
    $string=$string_fun.$self->replace_local($$brackets[0]).$string_arg.$self->replace_local($$brackets[1]);
    %tree_info=$self->merge_info(\%tree_info_fun,\%tree_info);
    return ($string,%tree_info);
}


#format ratios as \frac{}{}
sub ratio_as_frac{
    my $self=shift;
    shift;
    my $args=shift;
    my %tree_info=@_;
    my (%tree_info_num,%tree_info_den);
    my ($num,$den);
    ($num,%tree_info_num)=$self->to_string($self->fall_through_bracket($$args[0]));
    ($den,%tree_info_den)=$self->to_string($self->fall_through_bracket($$args[1]));
    %tree_info=$self->merge_info(\%tree_info_num,\%tree_info_den);
    if(!defined $tree_info{last_bracket_size} or $tree_info{last_bracket_size}<$frac_bracket_size){
	$tree_info{last_bracket_size}=$frac_bracket_size
    }
    my $string=$self->replace_local('\frac')."{$num}{$den}";
    return ($string,%tree_info);
}

#format products
sub product{
    my $self=shift;
    shift;
    my %tree_info=@_;
    my $args=shift;
    my $string;
    my ($string_left,$string_right);
    my (%tree_info_left,%tree_info_right);
    ($string_left,%tree_info_left)=$self->to_string($$args[0],%tree_info);
    ($string_right,%tree_info_right)=$self->to_string($$args[1],%tree_info);
    %tree_info=$self->merge_info(\%tree_info_left,\%tree_info_right);
    
    #TODO: it would be wise to use operator_to_string here, but first these operators have to be defined
    #TODO: the following check is not sufficient
    $string=$string_left
	.(
	($$args[0]->is eq 'number' and $$args[1]->is eq 'number')
	?$self->replace_local('\cdot')
	:$self->replace_local('\*')
	)
	.$string_right
	;
    return ($string,%tree_info)
}

#format power (= remove superfluous brackets)
#atm ignore brackets in the exponent for incremental bracket size
sub power{
    my $self=shift;
    my $op=shift;
    my $args=shift;
    my %tree_info=@_;
    #dd $$args[0];
    my $real_args=$self->fall_through_bracket($$args[1]);
    my $arg_str=$self->to_string($real_args,%tree_info);
    my $base_str;
    ($base_str,%tree_info)=$self->to_string($$args[0],%tree_info);
    my $string= 
	$base_str
	.$self->replace_local('^')
	.((length $arg_str==1)?$arg_str:"{$arg_str}")
	;
    return ($string,%tree_info);
}


#format subscripts
#atm ignore brackets in the subscript for incremental bracket size
sub subscript{
    my $self=shift;
    my $args=shift;
    my %tree_info=@_;
    # $args is a sequence, we have to go one level deeper
    my $real_args=$$args[0]->args;
    my $subscript=$self->to_string($$real_args[1],%tree_info);
    my $string;
    ($string,%tree_info)=$self->to_string($$real_args[0],%tree_info);
    $string.=
	$self->replace_local('_')
	.((length $subscript ==1)?"$subscript":"{$subscript}")
	;
    return ($string,%tree_info)
}

#format roots
sub sqrt{
    my $self=shift;
    my $args=shift;
    my %tree_info=@_;
    my $string;
    ($string,%tree_info)=$self->to_string($$args[0],%tree_info);
    die "Don't know how to format **sqrt** with more than one argument in Latex format" if scalar @$args >1;
    #TODO: roots with sequence as argument
    return ($self->replace_local('\sqrt').'{'.$string.'}',%tree_info);
}

#remove unneeded bracket -> if $_[1] is a bracket (), return its argument
sub fall_through_bracket{
    my $self=shift;
    my $object=shift;
        if(
	 ($object->is eq 'bracket')
	 and ($object->name->[0] eq '(')
	 and ($object->name->[1] eq ')')
	and (scalar @{$object->args} !=2)	
	){
	# we have an unneeded bracket, let's jump one level deeper
	return $object->args->[0];
    }
   return $object
}

#give correct size modifier for size $_[0] of bracket $[1]
sub bracket_size{
    my $self=shift;
    my $size=shift;
    my $bracket=shift;
    return 
	(($size<scalar @bracket_size_modifier)
	  ?$bracket_size_modifier[$size]
	  :$bracket_size_modifier[-1]
	)
	.$bracket
	;
}

#merge information from processing different branches of the tree
#only the size of the last bracket is interesting for our purposes
sub merge_info{
    my @tree_infos=@_;
    my $last_bracket_size=-1;
    foreach (@tree_infos){
	if(defined $_->{last_bracket_size} and $_->{last_bracket_size}>$last_bracket_size){
	    $last_bracket_size=$_->{last_bracket_size}
	}
    }
    return ($last_bracket_size>-1)?(last_bracket_size => $last_bracket_size):()
	 
}

1;
