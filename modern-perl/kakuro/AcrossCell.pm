
package Kakuro::AcrossCell;

use Modern::Perl '2018';
use feature qw(signatures);
no warnings qw(experimental::signatures);

use integer;

use Carp;

use Data::Dumper;

use parent 'Kakuro::Cell';
use Class::Tiny qw (_across);

sub draw($self) {
  my ($n);

  $n = sprintf("%2d", $self->{_across});
  print "    -\\$n   ";
}

sub isAcross($self) {
  return 1;
}

sub getAcrossTotal($self) {
  return $self->{_across};
}

1;
