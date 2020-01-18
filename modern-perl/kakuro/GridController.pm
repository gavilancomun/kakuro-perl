
package Kakuro::GridController;

use Modern::Perl '2018';
use feature qw(signatures);
no warnings qw(experimental::signatures);

use integer;

use Carp;

use Data::Dumper;

use Kakuro::Sum;
use Kakuro::RowDef;

my ($CurrentRowDef);

sub new { my ($proto) = @_;
  my ($self, $class);

  $class = ref($proto) || $proto;
  $self = { _rows => [],
            _sums => []
  };
  bless($self, $class);
  return $self;
}

sub width { my ($self) = @_;
  return scalar $self->{_rows}[0]->length();
}

sub height { my ($self) = @_;
  return scalar @{$self->{_rows}};
}

sub get { my ($self, $i, $j) = @_;
  return $self->{_grid}{$i}{$j};
}

sub set { my ($self, $i, $j, $value) = @_;
#  print "$i $j ", Dumper($value);
  $self->{_grid}{$i}{$j} = $value;
}

sub addSum { my ($self, $sum) = @_;
  push @{$self->{_sums}}, $sum;
}

sub newRowDef { my ($self) = @_;
  $CurrentRowDef = Kakuro::RowDef->new(1 + scalar @{$self->{_rows}});
  push @{$self->{_rows}}, $CurrentRowDef;
  return $CurrentRowDef;
}

sub draw { my ($self) = @_;
  my ($r);

  print "\n";
  foreach $r (@{$self->{_rows}}) {
    $r->draw();
  }
}

sub addSolid { my ($self) = @_;
  $CurrentRowDef->addSolid();
}

sub addEmpty { my ($self, $n) = @_;
  $CurrentRowDef->addEmpty($n);
}

sub addDown { my ($self, $d) = @_;
  $CurrentRowDef->addDown($d);
}

sub addAcross { my ($self, $across) = @_;
  $CurrentRowDef->addAcross($across);
}

sub addDownAcross { my ($self, $down, $across) = @_;
  $CurrentRowDef->addDownAcross($down, $across);
}

sub createAcrossSums { my ($self) = @_;
  my ($r, $c, $cell, $sum, $pos, $blank);

  foreach $r (1 .. $self->height()) {
    foreach $c (1 .. $self->width()) {
      $cell = $self->get($r, $c);
      if ($cell->isAcross) {
        $sum = Kakuro::Sum->new($cell->getAcrossTotal());
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

sub createDownSums { my ($self) = @_;
  my ($r, $c, $cell, $sum, $pos, $blank);

  foreach $c (1 .. $self->width()) {
    foreach $r (1 .. $self->height()) {
      $cell = $self->get($r, $c);
      if ($cell->isDown) {
        $sum = Kakuro::Sum->new($cell->getDownTotal());
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

sub createSums { my ($self) = @_;
  $self->createAcrossSums();
  $self->createDownSums();
}

sub parseDef { my ($self) = @_;
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

sub OneScan { my ($self) = @_;
  my ($result, $sum);

  $result = 0;
  foreach $sum (@{$self->{_sums}}) {
    $result += $sum->solve();
  }
  return $result;
}

sub solve { my ($self) = @_;
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
