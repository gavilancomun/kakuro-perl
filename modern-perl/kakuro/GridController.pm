package Kakuro::GridController;

use Modern::Perl '2018';
use feature qw(signatures);
no warnings qw(experimental::signatures);

use Data::Dumper;

use Kakuro::Sum;
use Kakuro::RowDef;

my ($CurrentRowDef);

sub new($proto) {
  my ($self, $class);

  $class = ref($proto) || $proto;
  $self = { _rows => [],
            _sums => []
  };
  bless($self, $class);
  return $self;
}

sub width($self) {
  return scalar $self->{_rows}[0]->length();
}

sub height($self) {
  return scalar @{$self->{_rows}};
}

sub get($self, $i, $j) {
  return $self->{_grid}{$i}{$j};
}

sub set($self, $i, $j, $value) {
  $self->{_grid}{$i}{$j} = $value;
}

sub addSum($self, $sum) {
  push @{$self->{_sums}}, $sum;
}

sub newRowDef($self) {
  $CurrentRowDef = Kakuro::RowDef->new();
  push @{$self->{_rows}}, $CurrentRowDef;
  return $CurrentRowDef;
}

sub draw($self) {
  my ($r);

  print "\n";
  foreach $r (@{$self->{_rows}}) {
    $r->draw();
  }
}

sub addSolid($self) {
  $CurrentRowDef->addSolid();
}

sub addEmpty($self, $n) {
  $CurrentRowDef->addEmpty($n);
}

sub addDown($self, $d) {
  $CurrentRowDef->addDown($d);
}

sub addAcross($self, $across) {
  $CurrentRowDef->addAcross($across);
}

sub addDownAcross($self, $down, $across) {
  $CurrentRowDef->addDownAcross($down, $across);
}

sub createAcrossSums($self) {
  my ($r, $c, $cell, $sum, $pos, $blank);

  foreach $r (1 .. $self->height()) {
    foreach $c (1 .. $self->width()) {
      $cell = $self->get($r, $c);
      if ($cell->isAcross) {
        $sum = Kakuro::Sum->new(_total => $cell->_across);
        $pos = $c + 1;
        $blank = $self->get($r, $pos);
        while (defined($blank) and $blank->isEmpty()) {
          $sum->add($blank);
          ++$pos;
          $blank = $self->get($r, $pos);
        }
        $self->addSum($sum);
      }
    }
  }
}

sub createDownSums($self) {
  my ($r, $c, $cell, $sum, $pos, $blank);

  foreach $c (1 .. $self->width()) {
    foreach $r (1 .. $self->height()) {
      $cell = $self->get($r, $c);
      if ($cell->isDown) {
        $sum = Kakuro::Sum->new(_total => $cell->_down);
        $pos = $r + 1;
        $blank = $self->get($pos, $c);
        while (defined($blank) and $blank->isEmpty()) {
          $sum->add($blank);
          ++$pos;
          $blank = $self->get($pos, $c);
        }
        $self->addSum($sum);
      }
    }
  }
}

sub createSums($self) {
  $self->createAcrossSums();
  $self->createDownSums();
}

sub parseDef($self) {
  my ($r, $c, $row);

  $r = 1;
  foreach $row (@{$self->{_rows}}) {
    foreach $c (1 .. $row->length()) {
      $self->set($r, $c, $row->get($c));
    }
    ++$r;
  }
  $self->createSums();
}

sub OneScan($self) {
  my ($result, $sum);

  $result = 0;
  foreach $sum (@{$self->{_sums}}) {
    $result += $sum->solve();
  }
  return $result;
}

sub solve($self) {
  my ($result);

  $self->parseDef();
  $self->draw();
  $result = $self->OneScan();
  while ($result > 0) {
    print "\nresult $result\n";
    $self->draw();
    $result = $self->OneScan();
  }
}

1;
