package Term::Vspark;

use 5.016002;
use strict;
use warnings;

use Term::Size;

our @ISA = qw();

our $VERSION = '0.02';

sub show {
    my $num = shift;
    my $max = shift;

    my ($columns, $rows) = Term::Size::chars *STDOUT{IO};

    my @graph = qw{ ▏ ▎ ▍ ▌ ▋ ▊ ▉ █};
    my $bar_num = ( $num * ( scalar(@graph) * $columns ) ) / $max;

    my $str = $graph[-1] x int($bar_num / scalar(@graph) );
    $str   .= $graph[ int($bar_num % (scalar(@graph) - 1) ) ];

    return $str;
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Term::Vspark - Perl extension for dispaying bars in the terminal

=head1 SYNOPSIS

  use Term::Vspark;

  print Term::Vspark::show();

=head1 DESCRIPTION


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
