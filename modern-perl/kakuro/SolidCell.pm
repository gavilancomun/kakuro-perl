
package Kakuro::SolidCell;

@ISA = qw(Kakuro::Cell);

use Modern::Perl '2018';
use integer;

use Carp;

use Data::Dumper;

use Kakuro::Cell;

sub draw { my ($self) = @_;
  print " XXXXXXXXX ";
}

1;
