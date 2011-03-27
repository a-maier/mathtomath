package Mathematica;
#define the output in Mathematica format

use 5.10.1;
use strict;
use Data::Dump;
use Math::ToMath::Operator qw(Operator);
#----------------------------------------------------------------------------------------------------
use parent 'Math::ToMath::Printer';

sub init{
    my $self=shift;
    $self->SUPER::init(@_);

#operator properties:
# which operators exist, which token(s) are to be used for output, precedence, pre/in/postfix...
# brackets should also be included here to indicate that they are legal
    %{$self->{operators}}=(
	';'	=> Operator->new(name => ';',prec => 0,assoc =>'right',pos => 'postfix'),
	'\`'	=> Operator->new(name => '\`',prec => 0,assoc =>'right',pos => 'postfix'),
	'>>'	=> Operator->new(name => '>>',prec => 100,assoc =>'left'),
	'>>>'	=> Operator->new(name => '>>>',prec => 100,assoc =>'left'),
	','	=> Operator->new(name => ',',prec => 100,assoc =>'left'),
	'='	=> Operator->new(name => '=',prec => 200,assoc =>'right'),
	':='	=> Operator->new(name => '=',prec => 200,assoc =>'right'),
	'^='	=> Operator->new(name => '=',prec => 200,assoc =>'right'),
	'^:='	=> Operator->new(name => '=',prec => 200,assoc =>'right'),
	'=.'	=> Operator->new(name => '=',prec => 200,assoc =>'right'),
	':'     => Operator->new(name => ':',prec => 300,assoc =>'left'),
	'&'     => Operator->new(name => '&',prec => 400),
	'/='    => Operator->new(name => '/=',prec => 500,assoc => 'right'),
	'*='    => Operator->new(name => '*=',prec => 500,assoc => 'right'),
	'-='    => Operator->new(name => '-=',prec => 500,assoc => 'right'),
	'+='    => Operator->new(name => '+=',prec => 500,assoc => 'right'),
	'/.'    => Operator->new(name => '/.',prec => 600,assoc => 'left'),
	'//.'    => Operator->new(name => '/.',prec => 600,assoc => 'left'),
	':>'    => Operator->new(name => ':>',prec => 700,assoc => 'right'),
	'->'    => Operator->new(name => '->',prec => 700,assoc => 'right'),
	'/;'    => Operator->new(name => '/;',prec => 800,assoc => 'left'),
	'~~'    => Operator->new(name => '~~',prec => 900,assoc => 'left'),
	'|'    => Operator->new(name => '|',prec => 1000,assoc => 'left'),
	'..'    => Operator->new(name => '..',prec => 1100),
	'...'    => Operator->new(name => '..',prec => 1100),
	'||'    => Operator->new(name => '||',prec => 1200,assoc => 'left'),
	'&&'    => Operator->new(name => '&&',prec => 1300,assoc => 'left'),
#	'!'    => Operator->new(name => '!',prec => 1400,assoc => 'right',pos => 'prefix'),
	'==='	=> Operator->new(name => '===',prec => 1500,assoc =>'left'),
	'=!='	=> Operator->new(name => '=!=',prec => 1500,assoc =>'left'),
	'<='	=> Operator->new(name => '<=',prec => 1600,assoc =>'left'),
	'>='	=> Operator->new(name => '>=',prec => 1600,assoc =>'left'),
	'<'	=> Operator->new(name => '<',prec => 1600,assoc =>'left'),
	'>'	=> Operator->new(name => '>',prec => 1600,assoc =>'left'),
	'!='	=> Operator->new(name => '!=',prec => 1600,assoc =>'left'),
	'=='	=> Operator->new(name => '==',prec => 1600,assoc =>'left'),
	';;'	=> Operator->new(name => ';;',prec => 1700,assoc =>'left'),
	'+'	=> Operator->new(name => '+',prec => 1800,assoc =>'left'),
	'-'	=> Operator->new(name => '-',prec => 1800,assoc =>'left'),
	'*'	=> Operator->new(name => '*',prec => 1900,assoc =>'left'),
	'\\'	=> Operator->new(name => '\\',prec => 2000,assoc =>'left'),
	'/'	=> Operator->new(name => '/',prec => 2100,assoc =>'left'),
	'u-'	=> Operator->new(name => '-',prec => 2150,pos => 'prefix'),
	'.'	=> Operator->new(name => '.',prec => 2200,assoc =>'left'),
	'**'	=> Operator->new(name => '**',prec => 2300,assoc =>'left'),
	'^'	=> Operator->new(name => '^',prec => 2400,assoc =>'right'),
	'<>'	=> Operator->new(name => '<>',prec => 2500,assoc =>'right'),
	'\''	=> Operator->new(name => '\'',prec => 2600,assoc =>'left'),
	'!'	=> Operator->new(name => '!',prec => 2700,assoc =>'nonassoc',pos => 'postfix'),
	'!!'	=> Operator->new(name => '!!',prec => 2700,assoc =>'nonassoc',pos => 'postfix'),
	'@@'	=> Operator->new(name => '@@',prec => 2800,assoc =>'right',pos => 'prefix'),
	'@@@'	=> Operator->new(name => '@@@',prec => 2800,assoc =>'right',pos => 'prefix'),
	'/@'	=> Operator->new(name => '/@',prec => 2800,assoc =>'right',pos => 'prefix'),
	'/@@'	=> Operator->new(name => '/@@',prec => 2800,assoc =>'right',pos => 'prefix'),
	'++'	=> Operator->new(name => '++',prec => 2900,assoc =>'right',pos => 'prefix'),
	'--'	=> Operator->new(name => '--',prec => 2900,assoc =>'right',pos => 'prefix'),
	'<<'	=> Operator->new(name => '<<',prec => 3000),
	'::'	=> Operator->new(name => '::',prec => 3100),
	'´'	=> Operator->new(name => '´',prec => 3200),
	#''	=> Operator->new(name => '´',prec => 3200),
	#'´'	=> Operator->new(name => '´',prec => 3200),
	'?'	=> Operator->new(name => '_',prec => 3300,pos => 'postfix'),
	'??'	=> Operator->new(name => '___',prec => 3300,pos => 'postfix'),
	'???'	=> Operator->new(name => '__',prec => 3300,pos => 'postfix'),
	'['	=> Operator->new(name => '[['),
	']'	=> Operator->new(name => ']]'),
	'('	=> Operator->new(name => '('),
	')'	=> Operator->new(name => ')'),
	'{'	=> Operator->new(name => '{'),
	'}'	=> Operator->new(name => '}'),
	#sometimes we need a comparison with the last operator
	# when there is no such operator, we use 0
	0       => Operator->new(name => '',prec => 0),
	);
#special output for certain functions
# e.g. for Latex we are supposed to put '**log**' => '\log' here
    %{$self->{symbols}}=reverse $self->get_config("Symbols/$self->{format}.dat");
    %{$self->{greek_symbols}}=$self->get_config("Symbols/Greek.dat");;
#special output functions for single objects
    %{$self->{specials}}=();
}

sub bracket_to_string{
    my $self=shift;
    my $brackets=shift;
    my $args=shift;
    if(scalar @$args==1){
	#for usual brackets use the default
	return $self->SUPER::bracket_to_string($brackets,$args)
    }
    elsif(scalar @$args==2){
	#for functions use square brackets
	if($$brackets[0] eq '(' && $$brackets[1] eq ')'){
	    return $self->to_string($args->[0])
		.$self->replace_local('[')
		.$self->to_string($args->[1])
		.$self->replace_local(']')
	}
	return $self->SUPER::bracket_to_string($brackets,$args)
    }
    else{
	die "Too many arguments for bracket"
    }
}


#format a symbol as a string, either falling back to interpreting the symbol as string
# TODO: or dying on error
sub symbol_to_string{
    my $self=shift;
    my $_=$_[0];
    #greek letters
    if(/^\*\*(.*)\*\*$/ and $self->{greek_symbols}->{$1}){
	s/^\*\*|\*\*$//g;
	$_="Capital".$_ if /^[A-Z]/;
	$_='\['.(ucfirst).']';
	return $self->replace_local($_);
    }
    #if it contains illegal tokens, we transform it into a string
    return $self->string_to_string($_[0]) unless /^(([[:alpha:]]|\$)([[:alnum:]]|\$)*)$/;
    return $self->replace_local($_);
}


1;
