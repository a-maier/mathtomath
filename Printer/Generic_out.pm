package Generic_out;
#define the output in generic format

use 5.10.1;
use strict;
use Data::Dump;
use Operator;
#----------------------------------------------------------------------------------------------------
use base 'Printer';

# sub init{
#     my $self=shift;
#     $self->SUPER::init;
#     #custom symbols for this format
#     %{$self->{symbols}}=reverse($self->get_config('Symbols/Generic.dat'));
# }

1;
