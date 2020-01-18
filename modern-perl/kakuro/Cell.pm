
package Kakuro::Cell;

use Modern::Perl '2018';
use integer;

use Carp;

use Data::Dumper;

sub new { my ($proto) = @_;
  my ($self, $class);

  $class = ref($proto) || $proto;
  $self = {};
  bless($self, $class);
  return $self;
}

sub draw { my ($self) = @_;
  print " ERROR ";
}

sub isAcross { my ($self) = @_;
  return 0;
}

sub isDown { my ($self) = @_;
  return 0;
}

sub isEmpty { my ($self) = @_;
  return 0;
}

1;
