
package Kakuro::SolidCell;

@ISA = qw(Kakuro::Cell);

use Modern::Perl '2018';
use feature qw(signatures);
no warnings qw(experimental::signatures);

use integer;

use Carp;

use Data::Dumper;

use Kakuro::Cell;

sub draw($self) {
  print " XXXXXXXXX ";
}

1;
