package Term::Vspark;

use strict;
use warnings;
use POSIX;

our @ISA = qw();

# VERSION

sub show_single_bar {
    my $num     = shift;
    my $max     = shift;
    my $columns = shift;

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
        $str .= printf( "%s\n", show_single_bar($i, $max, $columns) );
    }

    return $str;
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Term::Vspark - Perl extension for dispaying bars in the terminal

=head1 SYNOPSIS

Displays beautiful graphs to use in the terminal

=head1 DESCRIPTION

=head2 Methods

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

    Term::Vspark::show_graph(
        'max'     => $list[-1],
        'columns' => $columns,
        'values'  => \@ARGV,
    );

This will receive numbers from ARGV or STDIN and print out beutiful graph based on that data.

=head1 SEE ALSO

Original repo: https://github.com/LuRsT/vspark

=head1 AUTHOR

Gil Gonçalves <lt>lurst@gmail.com<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2013 by Gil Gonçalves

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.16.2 or,
at your option, any later version of Perl 5 you may have available.

=cut
