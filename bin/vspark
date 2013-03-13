#!/usr/bin/env perl

use strict;
use warnings;

use Term::Vspark qw{ show_graph };

# VERSION
# PODNAME: vspark

binmode STDOUT, ':encoding(UTF-8)';

chomp( @ARGV = <STDIN> ) unless @ARGV;

my @list = sort { $a <=> $b } @ARGV;
my $columns = qx{tput cols};

print show_graph(
    'max'     => $list[-1],
    'columns' => $columns - 1,
    'values'  => \@ARGV,
);
