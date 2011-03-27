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

1;

