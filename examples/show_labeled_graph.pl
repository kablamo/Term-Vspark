use strict;
use warnings;

use Term::Vspark qw[ show_labeled_graph ];

# VERSION
# PODNAME: show_labeled_graph

binmode STDOUT, ':encoding(UTF-8)';

chomp( @ARGV = <STDIN> ) unless @ARGV;
my %k_values = @ARGV;

my @list = sort { $a <=> $b } values %k_values;
my $columns = qx{tput cols};

print show_labeled_graph(
    'max'      => $list[-1],
    'columns'  => $columns,
    'k_values' => \%k_values,
);
