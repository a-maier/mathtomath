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
    sub_name    => 'get_parsers',
    'require'   => 1,
    inner       => 0,
);

sub get_parser {
    my $class = shift;
    my $name = shift;
    my @matching = grep /::\Q$name\E$/, $class->get_parsers;
    return $matching[0];
}

1;

