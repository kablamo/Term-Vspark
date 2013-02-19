# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl Term-Vspark.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;
use Term::Vspark;

use Test::More tests => 1;
BEGIN { use_ok('Term::Vspark') };

#chomp( @ARGV = <STDIN> ) unless @ARGV;
#
#my @list = sort { $a <=> $b } @ARGV;
#
#for my $i ( @ARGV ) {
#    printf( "%s\n", Term::Vspark::show($i, $list[-1]) );
#}

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

