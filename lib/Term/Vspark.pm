package Term::Vspark;

use strict;
use warnings;
use POSIX;
use Carp qw{ croak };

use Sub::Exporter -setup => {
    'exports' => [ 'show_bar', 'show_graph', 'show_labeled_graph', ],
};

our @ISA = qw();

# VERSION

sub show_bar {
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

    my $max     = $args{'max'}     || 1;
    my $columns = $args{'columns'} || 1;
    my $values  = $args{'values'}  || [];

    my $str = q{};
    for my $i ( @{ $values } ) {
        $str .= sprintf( "%s\n", show_bar($i, $max, $columns) );
    }

    return $str;
}

# Helper method
sub show_labeled_graph {
    my %args     = @_;

    my $max      = $args{'max'}     || 1;
    my $columns  = $args{'columns'} || 1;

    if ( ref $args{'k_values'} ne q{HASH} ) {
        croak 'k_values is not an HASH';
    }
    my %k_values = %{ $args{'k_values'} };

    my $label_width = max_label_width( keys %k_values );
    my $bar_width   = $columns - $label_width - 2;
    my $str         = q{};

    my $bar = q{};
    for my $i ( keys %k_values ) {
        $bar = show_bar($k_values{$i}, $max, $bar_width);
        $str .= sprintf( '%' . $label_width . "s %s\n", $i, $bar );
    }

    return $str;
}

sub max_label_width {
    my $max_width = (sort { $a <=> $b } map { length($_) } @_)[-1];
    return $max_width + 1;
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

    Term::Vspark::show_bar($value_for_this_bar, $max_value, $number_of_columns_to_display);

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

