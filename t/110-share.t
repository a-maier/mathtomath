use strict;
use warnings;
use Test::More;
use Math::ToMath qw(:all);

my @parsers = Parser->get_parsers();
plan tests => (2*@parsers+1);
ok(@parsers > 0, "Found parsers");

for my $parser_class (@parsers){
    my $parser_name = ($parser_class =~ /::(\w+)$/);
    my $symbols_file = Symbols->get_symbol_file_for_class($parser_class);
    ok(defined($symbols_file), "Found a symbols file for $parser_name");
    ok(-e $symbols_file, "Symbols file for $parser_name parser exists");
};



