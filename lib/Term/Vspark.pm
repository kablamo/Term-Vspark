package Term::Vspark;

use strict;
use warnings;
use POSIX;
use Carp qw{ croak };

our @ISA = qw();

# VERSION

sub show_single_bar {
    my $num     = shift || 0;
    my $max     = shift || 0;
    my $columns = shift || 0;

    my @graph = qw{ ▏ ▎ ▍ ▌ ▋ ▊ ▉ █ };
    my $bar_num = ceil( $num * ( scalar(@graph) * $columns ) ) / $max;

    my $str = $graph[-1] x ( int($bar_num / scalar(@graph) ) );
    $str   .= $graph[ ceil($bar_num % (scalar(@graph) ) ) ];

    return $str;
}

# Helper method
sub show_graph {
    my %args    = @_;
    my $max     = $args{'max'};
    my $columns = $args{'columns'};
    my @values  = @{ $args{'values'} };

    my $str = q{};
    for my $i ( @values ) {
        $str .= sprintf( "%s\n", show_single_bar($i, $max, $columns) );
    }

    return $str;
}

# Helper method
sub show_labeled_graph {
    my %args     = @_;
    my $max      = $args{'max'};
    my $columns  = $args{'columns'};

    if ( ref $args{'k_values'} ne q{HASH} ) {
        croak 'k_values is not an HASH';
    }
    my %k_values = %{ $args{'k_values'} };

    my $str = q{};
    for my $i ( keys %k_values ) {
        $str .= sprintf( "%10s %s\n", $i, show_single_bar($k_values{$i}, $max, $columns) );
    }

    return $str;
}

1;
__END__
=encoding utf-8

=head1 NAME

Term::Vspark - Perl extension for dispaying bars in the terminal

=head1 SYNOPSIS

Displays beautiful graphs to use in the terminal

=head1 DESCRIPTION

=head2 METHODS

Returns a string with a single utf8 bar according to the values

    Term::Vspark::show_single_bar($value_for_this_bar, $max_value, $number_of_columns_to_display);

Returns a string with a various utf8 bars according to the values

    Term::Vspark::show_graph('values' => \@values_for_this_graph, 'max' => $max_value, 'columns' => $number_of_columns_to_display);

Example:

    use Term::Vspark;
    use Term::Size;

    chomp( @ARGV = <STDIN> ) unless @ARGV;

    my @list = sort { $a <=> $b } @ARGV;
    my ($columns, $rows) = Term::Size::chars *STDOUT{IO};

    print Term::Vspark::show_graph(
        'max'     => $list[-1],
        'columns' => $columns,
        'values'  => \@ARGV,
    );

Example 2:

    chomp( @ARGV = <STDIN> ) unless @ARGV;
    my %k_values = @ARGV;

    my @list = sort { $a <=> $b } values %k_values;

    print Term::Vspark::show_labeled_graph(
        'max'      => $list[-1],
        'columns'  => 10,
        'k_values' => \%k_values,
    );

This will receive numbers from ARGV or STDIN and print out beutiful graph based on that data.

=head1 SEE ALSO

Original repo: https://github.com/LuRsT/vspark

