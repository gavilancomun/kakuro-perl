package Kakuro::Sum;

use Modern::Perl '2018';
use feature qw(signatures);
no warnings qw(experimental::signatures);

use Kakuro::SolidCell;
use Kakuro::DownCell;
use Kakuro::AcrossCell;
use Kakuro::DownAcrossCell;
use Kakuro::EmptyCell;

use Class::Tiny qw(_total);

my (%possibles, %counts, @candidate);

sub add($self, $value) {
  push @{$self->{_cells}}, $value;
}

sub get($self, $pos) {
  return $self->{_cells}[$pos];
}

sub length($self) {
  return scalar @{$self->{_cells}};
}

sub addPossible($pos, $value) {
  $possibles{$pos}{$value} = 1;
#  print "    Setting poss $value\n";
  return 1;
}

sub handleCandidate($value) {
  my (%done, $v, $pos, @trial);

  @trial = @candidate;
  push @trial, $value;
  foreach $v (@trial) {
    if (defined $done{$v}) {
      return 0;
    }
    $done{$v} = 1;
  }
  $pos = 0;
  foreach $v (@trial) {
    addPossible($pos, $v);
    ++$pos;
  }
  return 1;
}

sub solvePart($self, $total, $pos) {
  my ($result, $OneResult, $cell, $value);

#  print "  pos $pos total $total\n";
  $result = 0;
  if ($total < 1) {
    return 0;
  }
  $cell = $self->get($pos);
  if ($pos == ($self->length() - 1)) {
    if ($cell->isPossible($total)) {
      return handleCandidate($total);
    }
    return 0;
  }
  else {
    foreach $value ($cell->getValues()) {
#      print "    value $value\n";
      push @candidate, $value;
      $result += $self->solvePart($total - $value, $pos + 1);
      pop @candidate;
    }
  }
  return $result;
}

sub applyResult($self) {
  my ($cell, $value, $pos, $result);

  $result = 0;
  $pos = 0;
  foreach $cell (@{$self->{_cells}}) {
    foreach $value ($cell->getValues()) {
      if (not defined $possibles{$pos}{$value}) {
        $result += $cell->setImpossible($value);
      }
    }
    ++$pos;
  }
  return $result;
}

sub solve($self) {
  %possibles = ();
  $self->solvePart($self->{_total}, 0);
  return $self->applyResult();
}

1;
