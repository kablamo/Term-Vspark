# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl Term-Vspark.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 1;

BEGIN { use_ok('Term::Vspark') };

## Example for show_graph
#chomp( @ARGV = <STDIN> ) unless @ARGV;
#
#my @list = sort { $a <=> $b } @ARGV;
#my $columns = qx{tput cols};
#
#print Term::Vspark::show_graph(
#    'max'     => $list[-1],
#    'columns' => $columns - 1,
#    'values'  => \@ARGV,
#);

## Example for show_labeled_graph
#chomp( @ARGV = <STDIN> ) unless @ARGV;
#my %k_values = @ARGV;
#
#my @list = sort { $a <=> $b } values %k_values;
#
#print Term::Vspark::show_labeled_graph(
#    'max'      => $list[-1],
#    'columns'  => 10,
#    'k_values' => \%k_values,
#);
