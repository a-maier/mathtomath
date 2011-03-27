package Math::ToMath::Parser;
use strict;
use warnings;

use constant Parser => __PACKAGE__;

# Export the 'Parser' constant
use parent 'Exporter';
our @EXPORT_OK = qw(Parser);

# automatically load all contained parsers
# and return a list of them using the "" class method
use Module::Pluggable (
    search_path => 'Math::ToMath::Parser',
    sub_name    => '_get_parsers',
    'require'   => 1,
    inner       => 0,
);

# This wrapper makes sure that Generic comes first in the list
sub get_parsers {
    my $class = shift;
    my @parsers = $class->_get_parsers(@_);
    my $generic = __PACKAGE__ . "::Generic";
    my @nongeneric = grep $_ ne $generic, @parsers;
    if (@nongeneric == @parsers) {
        return @parsers;
    }
    else {
        return($generic, @nongeneric);
    }
}

sub get_parser {
    my $class = shift;
    my $name = shift;
    my @matching = grep /::\Q$name\E$/, $class->get_parsers;
    return $matching[0];
}

1;

