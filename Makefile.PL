use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  VERSION   => '0.01',
  PREREQ_PM => {'Mojolicious' => '3.31',
                'Lingua::ZH::CCDICT' => '0.05'},
  test      => {TESTS => 't/*.t'}
);
