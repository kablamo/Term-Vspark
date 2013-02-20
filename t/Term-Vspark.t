# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl Term-Vspark.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 1;

BEGIN { use_ok('Term::Vspark') };

chomp( @ARGV = <STDIN> ) unless @ARGV;

my @list = sort { $a <=> $b } @ARGV;
 my $columns = qx{tput cols};

Term::Vspark::show_graph(
    'max'     => $list[-1],
    'columns' => $columns,
    'values'  => \@ARGV,
);
