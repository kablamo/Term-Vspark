use Term::Vspark qw[ show_labeled_graph ];

chomp( @ARGV = <STDIN> ) unless @ARGV;
my %k_values = @ARGV;

my @list = sort { $a <=> $b } values %k_values;
my $columns = qx{tput cols};

print show_labeled_graph(
    'max'      => $list[-1],
    'columns'  => $columns,
    'k_values' => \%k_values,
);
