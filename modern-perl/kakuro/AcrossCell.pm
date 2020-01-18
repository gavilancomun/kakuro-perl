
package Kakuro::AcrossCell;

@ISA = qw(Kakuro::Cell);

use Modern::Perl '2018';

use integer;

use Carp;

use Data::Dumper;

use Kakuro::Cell;

sub new { my ($proto, $n) = @_;
  my ($self, $class);

  $class = ref($proto) || $proto;
  $self = { _across => $n };
  bless($self, $class);
  return $self;
}

sub draw { my ($self) = @_;
  my ($n);

  $n = sprintf("%2d", $self->{_across});
  print "    -\\$n   ";
}

sub isAcross { my ($self) = @_;
  return 1;
}

sub getAcrossTotal { my ($self) = @_;
  return $self->{_across};
}

1;
