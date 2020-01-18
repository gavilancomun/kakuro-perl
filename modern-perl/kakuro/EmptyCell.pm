
package Kakuro::EmptyCell;

@ISA = qw(Kakuro::Cell);

use Modern::Perl '2018';
use feature qw(signatures);
no warnings qw(experimental::signatures);

use integer;

use Carp;

use Data::Dumper;

use Kakuro::Cell;

my ($impossible, $possible) = (1, 2);

sub new { my ($proto) = @_;
  my ($self, $class);

  $class = ref($proto) || $proto;
  $self = {};
  bless($self, $class);
  $self->reset();
  return $self;
}

sub isEmpty { my ($self) = @_;
  return 1;
}

sub draw { my ($self) = @_;
  my ($i);

  print " ";
  if (1 == scalar $self->getValues()) {
    foreach $i ($self->getValues()) {
      print "   <", $i, ">   ";
    }
  }
  else {
    foreach $i (1 .. 9) {
      if ($self->isPossible($i)) {
        print $i;
      }
      else {
        print ".";
      }
    }
  }
  print " ";
}

sub isPossible { my ($self, $value) = @_;
  return defined $self->{_values}{$value};
}

sub setImpossible { my ($self, $value) = @_;
#  print "  set imposs $value\n";
  if (not defined $self->{_values}{$value}) {
    return 0;
  }
  delete $self->{_values}{$value};
  return 1;
}

sub reset { my ($self) = @_;
  my ($i);

  foreach $i (1 .. 9) {
    $self->{_values}{$i} = $possible;
  }
}

sub getValues { my ($self) = @_;
  return keys %{$self->{_values}};
}

1;
