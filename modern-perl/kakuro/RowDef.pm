package Kakuro::RowDef;

#
# This stores a user-oriented description of a row of the task.
#

use Modern::Perl '2018';
use feature qw(signatures);
no warnings qw(experimental::signatures);

use Kakuro::SolidCell;
use Kakuro::DownCell;
use Kakuro::AcrossCell;
use Kakuro::DownAcrossCell;
use Kakuro::EmptyCell;

use Class::Tiny qw(), {
  cells => []
};

sub length($self) {
  return scalar @{$self->{cells}};
}

sub addSolid($self) {
  $self->add(Kakuro::SolidCell->new());
}

sub addEmpty($self, $n) {
  my ($count);

  $count = $n // 1;
  foreach (1 .. $n) {
    $self->add(Kakuro::EmptyCell->new());
  }
}

sub addDown($self, $d) {
  $self->add(Kakuro::DownCell->new(_down => $d));
}

sub addAcross($self, $across) {
  $self->add(Kakuro::AcrossCell->new(_across => $across));
}

sub addDownAcross($self, $down, $across) {
  $self->add(Kakuro::DownAcrossCell->new(_down => $down, _across => $across));
}

sub draw($self) {
  foreach my $c (@{$self->{cells}}) {
    $c->draw();
  }
  print "\n";
}

sub get($self, $n) {
  return $self->{cells}[$n - 1];
}

sub add($self, $cell) {
  push @{$self->{cells}}, $cell;
}

1;
