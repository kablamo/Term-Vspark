use Term::Vspark qw{ show_graph };

# VERSION
# PODNAME: show_graph

chomp( @ARGV = <STDIN> ) unless @ARGV;

my @list = sort { $a <=> $b } @ARGV;
my $columns = qx{tput cols};

print show_graph(
    'max'     => $list[-1],
    'columns' => $columns - 1,
    'values'  => \@ARGV,
);
