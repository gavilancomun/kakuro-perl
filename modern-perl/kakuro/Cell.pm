
package Kakuro::Cell;

use Modern::Perl '2018';
use feature qw(signatures);
no warnings qw(experimental::signatures);

use integer;

use Carp;

use Data::Dumper;

sub new($proto) {
  my ($self, $class);

  $class = ref($proto) || $proto;
  $self = {};
  bless($self, $class);
  return $self;
}

sub draw($self) {
  print " ERROR ";
}

sub isAcross($self) {
  return 0;
}

sub isDown($self) {
  return 0;
}

sub isEmpty($self) {
  return 0;
}

1;
