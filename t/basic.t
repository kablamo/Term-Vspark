use Test::Most;

use Term::Vspark qw/show_graph/;
use utf8;

my $expected;
my $graph;

$expected = <<EOF;

▏
▎
▍
▌
▋
▋
▊
▉
█
█
████
EOF

$graph = show_graph(
    values => [0, .1, .2, .3, .4, .5, .6, .7, .8, .9, 1, 4],
);

is $graph, $expected, "no labels, 1x scaling, decimals";

$expected = <<EOF;
 0 
 1 █
 2 ██
 3 ███
 4 ████
 5 █████
EOF

$graph = show_graph(
    values  => [0, 1, 2, 3, 4, 5],
    labels  => [0, 1, 2, 3, 4, 5],
    max     => 5,
    columns => 3 + 5,
);

is $graph, $expected, "1x scaling";

$expected = <<EOF;
 0 
 1 ████
 2 ████████
 3 ████████████
 4 ████████████████
 5 ████████████████████
EOF

$graph = show_graph(
    values  => [0, 1, 2, 3, 4, 5],
    labels  => [0, 1, 2, 3, 4, 5],
    max     => 5,
    columns => 3 + 5 * 4,
);

is $graph, $expected, "4x scaling";

done_testing;
