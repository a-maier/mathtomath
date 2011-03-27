use 5.010001;
use ExtUtils::MakeMaker;
use File::Spec;
use File::ShareDir::Install;

install_share 'share';

# Find all grammars that we ship so we can generate the
# parser code using make
opendir my $dh, 'grammars'
    or die "Cannot open directory with grammars: $!";
my @grammars = grep /\.yp$/, readdir($dh);
closedir $dh;

sub MY::postamble {
    my $self = shift;
    # this will make sure share/ gets installed
    my @sharedircode = File::ShareDir::Install::postamble( $self );

    my $outdir = File::Spec->catdir(qw(blib lib Math ToMath Parser));
    my $make_code = join("\n", @sharedircode, <<"HERE");
pure_all :: parser

.PHONY: parser

parser: pm_to_blib
	\$(MKPATH) $outdir
HERE
    foreach my $grammar_file (@grammars) {
        say "Found grammar '$grammar_file'...";
        my $infile  = File::Spec->catfile(qw(grammars), $grammar_file);
        my $classname = $grammar_file;
        $classname =~ s/\.yp$//;
        my $pmfile = $classname . ".pm";
        my $outfile = File::Spec->catfile($outdir, $pmfile);
        my $action = <<ACTION;
	yapp -o $outfile $infile
	\$(PERLRUN) -i -pe \"s/package $classname;/package Math::ToMath::Parser::$classname;/\" $outfile
ACTION
        $make_code .= $action;
    }
    $make_code . "\n";
    return $make_code;
}

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Math::ToMath',
    VERSION_FROM      => 'lib/Math/ToMath.pm', # finds $VERSION
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker'     => '0',
        'File::Spec'              => '0',
        'File::ShareDir::Install' => '0',
    },
    PREREQ_PM         => {
      'Data::Dump'        => '0',
      'Getopt::Long'      => '0',
      'Module::Pluggable' => '0',
      'Parse::Yapp'       => '0',
      'File::Spec'        => '0',
      'File::ShareDir'    => '0',
    }, # e.g., Module::Name => 1.1
    'EXE_FILES'   => [qw( bin/mathtomath )],
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Math/ToMath.pm', # retrieve abstract from module
       AUTHOR         => 'Andreas Maier <email@address>') : ()),
);


