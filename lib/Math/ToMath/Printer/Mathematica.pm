package Math::ToMath::Printer::Mathematica;

=head1 NAME

Math::ToMath::Printer::Generic - Convert expressions to strings in Mathematica format

=cut

use 5.10.1;
use strict;
use warnings;
no warnings qw(recursion);
use Data::Dump;
use Math::ToMath::Operator qw(Operator);
use Math::ToMath::Symbols qw(Symbols);

use parent 'Math::ToMath::Printer';

=head1 SYNOPSIS

 use Math::ToMath::Printer::Mathematica;

 #create a new object
 my $printer=Math::ToMath::Printer::Mathematica->new();

 #get format
 my $format=$printer->format();

 #convert an expression to a string
 my $expr_str=$printer->convert($expression_tree);

 #set/get conversion options
 my $printer_options = $printer->options(
    line_length => 42
 );

 #set/get local transformation rules
 my $local_printer_rules = $printer->local_rules(
    '^=$' => ':='
 );

 #set/get global transformation rules
 my $global_printer_rules = $printer->global_rules(
    "\(6\*7\)" => 42
 );


=head1 DESCRIPTION

Printer objects of this class can be used to convert 
L<Math::ToMath::Expression> objects into strings that can be fed into the
computer algebra system Mathematica.

=over 2

=item B<new>

Create a new printer object.

=item B<convert>

Converts an expression object into a string compatible to Mathematica.

=item B<options>

Set options for the conversion to strings. At the moment the only supported
option is I<line_length>, which specifies the maximum length of lines in the
output. The length is measured in characters. Longer lines are wrapped by
inserting a continuation character and a line break. If this option is not set
(or set to 0) lines can have arbitrary length.

=item B<local_rules>

Set local transformation rules. Transformation rules have the form LHS => RHS
and act like regular expression substitution, i.e. s/LHS/RHS/. Local rules 
are applied separately to each subexpression. This allows a limited form of
"semantic" replacements as shown in the example.

=item B<global_rules>

Set global transformation rules. Transformation rules have the form LHS => RHS
and act like regular expression substitution, i.e. s/LHS/RHS/. Global rules are
applied by the B<convert> method to the whole resulting string. If the 
I<line_length> option is set line breaks will be inserted B<after> global 
rules are applied.

=back

=cut

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
# e.g. for Latex we are supposed to put '**log**' => '\log' herea
    %{$self->{symbols}}=reverse $self->get_config(Symbols->get_symbol_file_for_class($self->{format}));
    %{$self->{greek_symbols}}=$self->get_config(Symbols->get_named_symbol_file("Greek"));
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
    my $_=$self->replace_local($_[0]);
    #greek letters
    if(/^\*\*(.*)\*\*$/ and $self->{greek_symbols}->{$1}){
	s/^\*\*|\*\*$//g;
	$_="Capital".$_ if /^[A-Z]/;
	$_='\['.(ucfirst).']';
	return $self->replace_local($_);
    }
    return $_ if(/^(([[:alpha:]]|\$)([[:alnum:]]|\$)*|##?\d*)$/);
    #the symbol contains illegal tokens, we transform it into a string
    # we can't really handle quotes - if they appear, escape them
    s/(^|[^\\])\"/$1\\"/g;
    return $self->string_to_string($_);
}


1;

=head1 SEE ALSO

L<mathtomath>

L<The Mathematica home page|http://www.wolfram.com/products/mathematica/>

L<Math::ToMath::Parser::Mathematica> - the corresponding parser

L<Math::ToMath::Expression>

other Math::ToMath::Printer::* modules

=head1 AUTHOR

Andreas Maier, E<lt>email@addressE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010-2011 by Andreas Maier

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.

=cut
