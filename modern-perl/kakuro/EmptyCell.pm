package Kakuro::EmptyCell;

@ISA = qw(Kakuro::Cell);

use Modern::Perl '2018';
use feature qw(signatures);
no warnings qw(experimental::signatures);

use Data::Dumper;

use Kakuro::Cell;

my ($impossible, $possible) = (1, 2);

sub new($proto) {
  my ($self, $class);

  $class = ref($proto) || $proto;
  $self = {};
  bless($self, $class);
  $self->reset();
  return $self;
}

sub isEmpty($self) {
  return 1;
}

sub draw($self) {
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

sub isPossible($self, $value) {
  return defined $self->{_values}{$value};
}

sub setImpossible($self, $value) {
#  print "  set imposs $value\n";
  if (not defined $self->{_values}{$value}) {
    return 0;
  }
  delete $self->{_values}{$value};
  return 1;
}

sub reset($self) {
  my ($i);

  foreach $i (1 .. 9) {
    $self->{_values}{$i} = $possible;
  }
}

sub getValues($self) {
  return keys %{$self->{_values}};
}

1;
