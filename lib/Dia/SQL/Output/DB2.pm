package Dia::SQL::Output::DB2;

# $Id: DB2.pm 430 2009-02-20 08:18:59Z aff $

use warnings;
use strict;

use Data::Dumper;
use File::Spec::Functions qw(catfile);

use lib q{lib};
use base q{Dia::SQL::Output}; # extends

require Dia::SQL::Logger;
require Dia::SQL::Const;

=head2 new

The constructor.  Arguments:

=cut

sub new {
  my ( $class, %param ) = @_;
  my $self = {};

  # Set default index_options for db2
  $param{index_options} = ['allow reverse scans']
    unless (exists($param{index_options})
      && scalar(@{ $param{index_options} }));

  $param{db} = q{db2};    # Make user superclass knows
                          # we're db2 so that Utils is
                          # properly initialized

  $self = $class->SUPER::new(%param);


  bless( $self, $class );
  return $self;
}

=head2

Create primary key clause, e.g.

constraint pk_<tablename> primary key (<column1>,..,<columnN>)

For DB2 the PK must be 18 characters or less

=cut


sub _create_pk_string {
  my ($self, $tablename, @pks) = @_;
  my $DB2_OBJECT_NAME_MAX_LENGTH = 18; # TODO move to Const.pm

	if (!$tablename) {
		$self->{log}->error(q{Missing argument tablename - cannot create pk string!});
		return;
	}

  # old school name length reduction
  $tablename = $self->{utils}->mangle_name ($tablename, $DB2_OBJECT_NAME_MAX_LENGTH - 4);

  # new school name length reduction
#  $tablename = $self->{utils}->make_name ($tablename);

  return qq{constraint pk_$tablename primary key (} .
			join(q{,}, @pks)
		   .q{)};
}

1;

__END__

=pod

Subclass for outputting SQL for the DB2 database

=cut
