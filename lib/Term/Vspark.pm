package Term::Vspark;

use strict;
use warnings;
use Carp qw{ croak };
use utf8;

use Exporter::Shiny qw/show_bar show_graph/;

our $VERSION = 0.31;

sub show_bar {
    my (%args) = @_;

    my $value   = $args{value};
    my $max     = $args{max};
    my $columns = $args{columns};
    my $char    = $args{char};

    my @char_list = $char
        ? ($char)
        : (qw{ ▏ ▎ ▍ ▌ ▋ ▊ ▉ █});

    my $length = $value * $columns / $max; # length of the bar
    my $bar = '';

    # build integer portion of the bar
    my $integer = int $length;
    $bar .= $char_list[-1] x $integer;

    # build decimal portion of the bar
    my $decimal = $length - $integer;
    if ($decimal > 0) {
        my $index = int scalar @char_list * $decimal;
        $bar .= $char_list[$index];
    }

    return $bar;
}

sub show_graph {
    my %args = @_;

    croak 'values is not an ArrayRef'
        if ref $args{'values'} ne 'ARRAY';

    croak 'labels is not an ArrayRef'
        if $args{'labels'} && ref $args{'labels'} ne 'ARRAY';

    my $max     = $args{max}       || 1;
    my $columns = $args{columns}   || 3;
    my @labels  = @{ $args{labels} || [] };
    my @values  = @{ $args{values} };
    my $char    = $args{char};

    croak 'the number of labels and values must be equal'
        if $args{labels} && scalar @labels != scalar @values;

    my $label_width = max_label_width(@labels);
    my $bar_width   = $columns - $label_width - 2;
    my $graph       = q{};

    for my $value (@values) {
        my $label = shift @labels;
        my $bar   = show_bar(
            value   => $value, 
            max     => $max, 
            columns => $bar_width, 
            char    => $char,
        );

        $graph .= sprintf(' %' . $label_width . "s ", $label) if defined $label;
        $graph .= $bar . "\n";
    }

    return $graph;
}

sub max_label_width {
    my @labels = @_;

    return 0 if scalar @labels == 0;

    my @lengths = sort map { length $_ } @labels;
    return $lengths[-1];
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

=head2 show_graph(%params)

show_graph() returns a string.

The 'values' parameter should be an ArrayRef of numbers.   This is required.

The 'labels' parameter should be an ArrayRef of strings.  This is optional.
Each label will be used with the corresponding value.

The 'max' parameter is the maximum value of the graph.  Without this parameter
you cannot compare graphs because the scaling will change depending on the
data.  This parameter is optional.

The 'columns' parameter is the maximum width of the graph.

=head1 AUTHOR

Gil Gonçalves <lurst@cpan.org>

=head1 SEE ALSO

L<Term::Spark>

