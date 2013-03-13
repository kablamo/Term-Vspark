package Term::Vspark;

use strict;
use warnings;
use POSIX;
use Carp qw{ croak };
use utf8;

use Sub::Exporter -setup => {
    'exports' => [ 'show_bar', 'show_graph', ],
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

sub show_graph {
    my %args = @_;

    croak 'values is not an ArrayRef' 
        unless ref $args{'values'} eq 'ARRAY';
    croak 'labels is not an ArrayRef' 
        if $args{'labels'} && ref $args{'labels'} ne 'ARRAY';

    my $max     = $args{'max'}     || 1;
    my $columns = $args{'columns'} || 1;
    my @labels  = @{ $args{'labels'} || [] };
    my @values  = @{ $args{'values'} };

    croak 'the number of labels and values must be equal' 
        if $args{'labels'} && scalar @labels != scalar @values;

    my $label_width = max_label_width( @labels );
    my $bar_width   = $columns - $label_width - 2;
    my $str         = q{};

    for my $value (@values) {
        my $label = shift @labels;
        my $bar   = show_bar($value, $max, $bar_width);

        $str .= sprintf('%' . $label_width . "s ", $label) if defined $label;
        $str .= $bar . "\n";
    }

    return $str;
}

sub max_label_width {
    my @labels = @_;
    return 0 if scalar @labels == 0;

    my $max_width = (sort { $a <=> $b } map { length($_) } @labels)[-1];
    return $max_width + 1;
}

1;
__END__
=encoding utf-8

=head1 NAME

Term::Vspark - Displays a graph in the terminal

=head1 SYNOPSIS

    use Term::Vspark qw/show_graph/;
    binmode STDOUT, ':encoding(UTF-8)'; 
    print show_graph(
        values  => [0,1,2,3,4,5],
        labels  => [0,1,2,3,4,5], # optional
        max     => 7,             # optional
        columns => 80,            # optional
    );

    # The output looks like this:
    # 0 ▏
    # 1 ██████████▉
    # 2 █████████████████████▊
    # 3 ████████████████████████████████▋
    # 4 ███████████████████████████████████████████▌
    # 5 ██████████████████████████████████████████████████████▍


=head1 DESCRIPTION

This module displays beautiful graphs in the terminal.  It is a companion to
Term::Spark but instead of displaying normal sparklines it displays "vertical"
sparklines.

Note that because the graph is built from utf8 characters, users must setup
UTF-8 encoding for STDOUT if they wish to print the output.  

=head1 METHODS

=head2 show_graph( values => \@values, labels => \@labels, max => $max, columns => $columns )

show_graph returns a string.  

The 'values' parameter should be an ArrayRef of numbers.   This is required.

The 'labels' parameter should be an ArrayRef of strings.  This is optional.
Each label will be used with the corresponding value.

The 'max' parameter is the maximum value of the graph.  Without this parameter
you cannot compare graphs because the scaling will change depending on the
data.  This parameter is optional.

The 'columns' parameter is the maximum width of the graph.


=head1 SEE ALSO

L<Term::Spark>

Original repo: L<https://github.com/LuRsT/vspark>

