package Kakuro::Cell;

use Modern::Perl '2018';
use feature qw(signatures);
no warnings qw(experimental::signatures);

use Class::Tiny;

sub isAcross($self) {
  return 0;
}

sub isDown($self) {
  return 0;
}

sub isEmpty($self) {
  return 0;
}

sub draw($self) {
  print " ERROR ";
}

1;
