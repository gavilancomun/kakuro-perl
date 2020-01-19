package Kakuro::DownAcrossCell;

use Modern::Perl '2018';
use feature qw(signatures);
no warnings qw(experimental::signatures);

use parent 'Kakuro::Cell';
use Class::Tiny qw (_across _down);

sub isAcross($self) {
  return 1;
}

sub isDown($self) {
  return 1;
}

sub draw($self) {
  my ($n, $d);

  $d = sprintf("%2d", $self->{_down});
  $n = sprintf("%2d", $self->{_across});
  print "   $d\\$n   ";
}

1;
