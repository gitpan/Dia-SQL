package Dia::SQL::Const;

# $Id: Const.pm 371 2009-02-14 11:16:06Z aff $

use warnings;
use strict;

use lib q{lib};
use Dia::SQL::Logger;

# List of supported relational database management systems
my @RDBMS = qw (
  db2
  informix
  ingres
  innodb
  mssql
  mysql
  oracle
  postgres
  sas
  sybase
);

my %OUTPUT_CLASS = (
  db2      => 'Dia::SQL::Output::DB2',
  informix => 'Dia::SQL::Output::Informix',
  ingres   => 'Dia::SQL::Output::Ingres',
  innodb   => 'Dia::SQL::Output::InnoDB',
  mssql    => 'Dia::SQL::Output::MSSQL',
  mysql    => 'Dia::SQL::Output::MySQL',
  oracle   => 'Dia::SQL::Output::Oracle',
  postgres => 'Dia::SQL::Output::Postgres',
  sas      => 'Dia::SQL::Output::SAS',
  sybase   => 'Dia::SQL::Output::Sybase',
);

# Each statement type must be generated in correct order
my @SMALL_PACK_GEN_SEQ = qw (
  pre
  post
  table
  pk
  columns
  index
  typemap
  macropre
  macropost
);


=head2 new

The constructor.  No arguments.

=cut

sub new {
  my ( $class, %param ) = @_;
  my $self = {};

  bless( $self, $class );
  return $self;
}

=head2 get_rdbms

Return list of databases.

=cut

sub get_rdbms {
  my $self = shift;
  return @RDBMS;
}

=head2 get_small_pack_gen_seq

Return list with sequence for small packages processing.

=cut

sub get_small_pack_gen_seq {
  my $self = shift;
  return @SMALL_PACK_GEN_SEQ;
}


=head2 get_class_name

Database to class lookup. Used by Output->new.

=cut

sub get_class_name {
  my ($self, $db) = @_;
  if (exists($OUTPUT_CLASS{$db})) {
	return $OUTPUT_CLASS{$db};
  } else {
	return;
  }
}

1;

__END__
