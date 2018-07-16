use 5.010001;
use ExtUtils::MakeMaker;
use File::Spec;
use File::ShareDir::Install;
use File::Find qw(find);

install_share 'share';

# Find all grammars that we ship so we can generate the
# parser code using make
my %grammars;
find({
    wanted => sub {
        return if not /\.yp$/;
        my $infile = $_;
        my ($vol, $dir, $file) = File::Spec->splitpath($infile);
        my @dirs = grep $_ ne '', File::Spec->splitdir($dir);
        shift @dirs;
        my $basename = $file;
        $basename =~ s/\.yp$//;
        my $classname = "Math::ToMath::" . join('::', @dirs, $basename);
        my $outdir    = File::Spec->catdir(qw(blib lib Math ToMath), @dirs);
        my $outfile   = File::Spec->catfile($outdir, $basename.".pm");
        $grammars{$infile} = {
            outdir    => $outdir,
            infile    => $infile,
            outfile   => $outfile,
            classname => $classname,
            basename  => $basename,
        };
    },
    no_chdir => 1,
}, 'grammars');
#use Data::Dumper;
#warn Dumper \%grammars;

# Find all printers (needed for generating the PAR archive)
my @printer_classes;
{
    my $dir_hdl;
    opendir($dir_hdl,File::Spec->catdir(qw(lib Math ToMath Printer)))
	or die "Failed to opendir ",
	File::Spec->catdir(qw(lib Math ToMath Printer))
	,": $!";
    @printer_classes = grep {s/\.pm$//} readdir $dir_hdl;
    closedir $dir_hdl;
    map {$_="Math::ToMath::Printer::$_"} @printer_classes;
}
# use Data::Dump;
# dd @printer_classes;

sub MY::postamble {
    my $self = shift;
    # this will make sure share/ gets installed
    my @sharedircode = File::ShareDir::Install::postamble( $self );

    my $make_code = join("\n", @sharedircode, <<"HERE");
pure_all :: parser

.PHONY: parser

parser: pm_to_blib
HERE
    foreach my $grammar_spec (values %grammars) {
        my $infile = $grammar_spec->{infile};
        say "Found grammar '$infile'...";
	
        my $action = <<ACTION;
	\$(MKPATH) $grammar_spec->{outdir}
	yapp -o $grammar_spec->{outfile} $grammar_spec->{infile}
	\$(PERLRUN) -i -pe \"s/package\\s+$grammar_spec->{basename}\\s*;/package $grammar_spec->{classname};/\" $grammar_spec->{outfile}
ACTION
       $make_code .= $action;
    }

    #target for par archive
    $make_code .= << "PAR_CODE";

mathtomath: pure_all
\tpp -o mathtomath bin/mathtomath \\
PAR_CODE
    
    my @parser_classes = map { $grammars{$_}->{classname} } (keys %grammars);
    $make_code .= 
	join " " => (map {"-M \"$_\""} (@parser_classes,@printer_classes));
    
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
        'File::Find'              => '0',
    },
    PREREQ_PM         => {
      'Data::Dump'        => '0',
      'Getopt::Long'      => '0',
      'IO::Interactive'   => '0',
      'Module::Pluggable' => '0',
      'Parse::Yapp'       => '0',
      'File::Spec'        => '0',
      'File::ShareDir'    => '0',
      'Pod::Usage'        => '0',
      'Math::BigFloat'    => '0',
      'File::HomeDir'     => '0',
      'parent'            => '0',
    }, # e.g., Module::Name => 1.1
    'EXE_FILES'   => [qw( bin/mathtomath )],
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Math/ToMath.pm', # retrieve abstract from module
       AUTHOR         => 'Andreas Maier <email@address>') : ()),
);


