
package Kakuro::Sum;

use strict;
use integer;

use Carp;

use Data::Dumper;

use Kakuro::SolidCell;
use Kakuro::DownCell;
use Kakuro::AcrossCell;
use Kakuro::DownAcrossCell;
use Kakuro::EmptyCell;

my (%possibles, %counts, @candidate);

sub new { my ($proto, $total) = @_;
  my ($self, $class);

  $class = ref($proto) || $proto;
  $self = { _total => $total };
  bless($self, $class);
  return $self;
}

sub add { my ($self, $value) = @_;
  push @{$self->{_cells}}, $value;
}

sub get { my ($self, $pos) = @_;
  return $self->{_cells}[$pos];
}

sub length { my ($self) = @_;
  return scalar @{$self->{_cells}};
}

sub addPossible { my ($pos, $value) = @_;
  $possibles{$pos}{$value} = 1;
#  print "    Setting poss $value\n";
  return 1;
}

sub handleCandidate { my ($value) = @_;
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

sub solvePart { my ($self, $total, $pos) = @_;
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

sub applyResult { my ($self) = @_;
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

sub solve { my ($self) = @_;
  %possibles = ();
  $self->solvePart($self->{_total}, 0);
  return $self->applyResult();
}

1;
