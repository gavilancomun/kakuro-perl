
package Kakuro::RowDef;

#
# This stores a user-oriented description of a row of the task.
#

use Modern::Perl '2018';
use feature qw(signatures);
no warnings qw(experimental::signatures);

use integer;

use Carp;

use Data::Dumper;

use Kakuro::SolidCell;
use Kakuro::DownCell;
use Kakuro::AcrossCell;
use Kakuro::DownAcrossCell;
use Kakuro::EmptyCell;

sub new { my ($proto) = @_;
  my ($self, $class);

  $class = ref($proto) || $proto;
  $self = { _cells => [] };
  bless($self, $class);
  return $self;
}

sub length { my ($self) = @_;
  return scalar @{$self->{_cells}};
}

sub addSolid { my ($self) = @_;
  $self->add(Kakuro::SolidCell->new());
}

sub addEmpty { my ($self, $n) = @_;
  my ($count);

  $count = defined $n ? $n : 1;
  foreach (1 .. $n) {
    $self->add(Kakuro::EmptyCell->new());
  }
}

sub addDown { my ($self, $d) = @_;
  $self->add(Kakuro::DownCell->new(_down => $d));
}

sub addAcross { my ($self, $across) = @_;
  $self->add(Kakuro::AcrossCell->new(_across => $across));
}

sub addDownAcross { my ($self, $down, $across) = @_;
  $self->add(Kakuro::DownAcrossCell->new($down, $across));
}

sub draw { my ($self) = @_;
  my ($c);

  foreach $c (@{$self->{_cells}}) {
    $c->draw();
  }
  print "\n";
}

sub get { my ($self, $n) = @_;
  return $self->{_cells}[$n - 1];
}

sub add { my ($self, $cell) = @_;
  push @{$self->{_cells}}, $cell;
}



1;
