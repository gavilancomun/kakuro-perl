#!/usr/local/bin/perl -w
#
# Copyright (C) 2005 HISL Limited. All rights reserved.
#

package Kakuro;

use Modern::Perl '2018';
use feature qw(signatures);
no warnings qw(experimental::signatures);

use vars qw($opt_q $opt_v);

use Config;
use Cwd;
use File::Copy;
use File::Spec;
use Getopt::Std;
use IO::File;

use Data::Dumper;

use lib "..";

use Kakuro::GridController;

my ($spec);

sub test1 {
  my ($grid);

  $grid = Kakuro::GridController->new();
  $grid->newRowDef();
  $grid->addSolid(); $grid->addDown(4); $grid->addDown(22); $grid->addSolid(); $grid->addDown(16); $grid->addDown(3);
  $grid->newRowDef();
  $grid->addAcross(3); $grid->addEmpty(2); $grid->addDownAcross(16, 6); $grid->addEmpty(2);
  $grid->newRowDef();
  $grid->addAcross(18); $grid->addEmpty(5);
  $grid->newRowDef();
  $grid->addSolid(); $grid->addDownAcross(17, 23); $grid->addEmpty(3); $grid->addDown(14);
  $grid->newRowDef();
  $grid->addAcross(9); $grid->addEmpty(2); $grid->addAcross(6); $grid->addEmpty(2);
  $grid->newRowDef();
  $grid->addAcross(15); $grid->addEmpty(2); $grid->addAcross(12); $grid->addEmpty(2);
  print "Size ", $grid->width(), " x ", $grid->height(), "\n";
  $grid->solve();
}

sub main {
  test1();
}

main();
