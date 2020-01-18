
package Kakuro::DownAcrossCell;

@ISA = qw(Kakuro::Cell);

use strict;
use integer;

use Carp;

use Data::Dumper;

use Kakuro::Cell;

sub new { my ($proto, $down, $across) = @_;
  my ($self, $class);

  $class = ref($proto) || $proto;
  $self = { _down => $down, _across => $across };
  bless($self, $class);
  return $self;
}

sub draw { my ($self) = @_;
  my ($n, $d);

  $d = sprintf("%2d", $self->{_down});
  $n = sprintf("%2d", $self->{_across});
  print "   $d\\$n   ";
}

sub getAcrossTotal { my ($self) = @_;
  return $self->{_across};
}

sub getDownTotal { my ($self) = @_;
  return $self->{_down};
}


sub isAcross { my ($self) = @_;
  return 1;
}

sub isDown { my ($self) = @_;
  return 1;
}

1;
