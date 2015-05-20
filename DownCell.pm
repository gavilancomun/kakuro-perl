
package Kakuro::DownCell;

@ISA = qw(Kakuro::Cell);

use strict;
use integer;

use Carp;

use Data::Dumper;

use Kakuro::Cell;

sub new { my ($proto, $n) = @_;
  my ($self, $class);

  $class = ref($proto) || $proto;
  $self = { _down => $n };
  bless($self, $class);
  return $self;
}

sub getDownTotal { my ($self) = @_;
  return $self->{_down};
}

sub isDown { my ($self) = @_;
  return 1;
}

sub draw { my ($self) = @_;
  my ($d);

  $d = sprintf("%2d", $self->{_down});
  print "   $d\\-    ";
}

1;
