use 5.016002;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Term::Vspark',
    VERSION_FROM      => 'lib/Term/Vspark.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Term/Vspark.pm', # retrieve abstract from module
       AUTHOR         => 'Gil Gonçalves <lurst@gmail.com>') : ()),
);
