package Kakuro::EmptyCell;

@ISA = qw(Kakuro::Cell);

use Modern::Perl '2018';
use feature qw(signatures);
no warnings qw(experimental::signatures);

use Data::Dumper;

use Kakuro::Cell;

sub new($proto) {
  my ($self, $class);

  $class = ref($proto) || $proto;
  $self = {
    _values => {
      1 => 1,
      2 => 1,
      3 => 1,
      4 => 1,
      5 => 1,
      6 => 1,
      7 => 1,
      8 => 1,
      9 => 1     
    }
  };
  bless($self, $class);
  return $self;
}

sub isEmpty($self) {
  return 1;
}

sub draw($self) {
  my ($i);

  print " ";
  if (1 == scalar $self->getValues()) {
    foreach my $i ($self->getValues()) {
      print "   <", $i, ">   ";
    }
  }
  else {
    foreach my $i (1 .. 9) {
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
  return $self->{_values}{$value};
}

sub setImpossible($self, $value) {
  if (not $self->{_values}{$value}) {
    return 0;
  }
  delete $self->{_values}{$value};
  return 1;
}

sub getValues($self) {
  return keys %{$self->{_values}};
}

1;
