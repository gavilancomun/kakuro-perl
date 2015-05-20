
package Kakuro::SolidCell;

@ISA = qw(Kakuro::Cell);

use strict;
use integer;

use Carp;

use Data::Dumper;

use Kakuro::Cell;

sub draw { my ($self) = @_;
  print " XXXXXXXXX ";
}

1;
