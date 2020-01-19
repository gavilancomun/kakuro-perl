
package Kakuro::DownCell;

use Modern::Perl '2018';
use feature qw(signatures);
no warnings qw(experimental::signatures);

use parent 'Kakuro::Cell';
use Class::Tiny qw (_down);

sub getDownTotal($self) {
  return $self->{_down};
}

sub isDown($self) {
  return 1;
}

sub draw($self) {
  my ($d);

  $d = sprintf("%2d", $self->{_down});
  print "   $d\\-    ";
}

1;
