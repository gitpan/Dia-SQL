#   $Id: 621-output-get-create-table-sql.t 413 2009-02-19 08:33:54Z aff $

use warnings;
use strict;

use Data::Dumper;
use Test::More;
use Test::Exception;
use File::Spec::Functions;
use lib catdir qw ( blib lib );

plan tests => 8;

use lib q{lib};
use_ok ('Dia::SQL');
use_ok ('Dia::SQL::Output');
use_ok ('Dia::SQL::Output::DB2');

# 1. pre-parsed input for simplicity and speed.
# $table is here a hash ref containing one class ('extremes')
my $table =
  {
    'name' => 'extremes',
    'type' => 'table',
    'atts' => {
      'maxval'  => [ 'maxVal',  'numeric (15)', '', '0', undef ],
      'fmorg'   => [],
      'minval'  => [ 'minVal',  'numeric (15)', '', '0', undef ],
      'public'  => [],
      'name'    => [ 'name',    'varchar (32)', '', '2', undef ],
      'colname' => [ 'colName', 'varchar (64)', '', '0', undef ]
    },
    'ops' => [
      [ 'select', 'grant', ['public'], '', undef ],
      [ 'all',    'grant', ['fmorg'],  '', undef ]
    ],
    'uindxn'  => {},
    'pk'      => [ [ 'name', 'varchar (32)', '', '2', undef ], ],
    'uindxc'  => {},
    'attList' => [
      [ 'name',    'varchar (32)', '', '2', undef ],
      [ 'colName', 'varchar (64)', '', '0', undef ],
      [ 'minVal',  'numeric (15)', '', '0', undef ],
      [ 'maxVal',  'numeric (15)', '', '0', undef ]
    ],
  };

my $diasql = Dia::SQL->new(db => 'db2');
my $output   = undef;
isa_ok($diasql, 'Dia::SQL');
lives_ok(sub { $output = $diasql->get_output_instance(); },
  q{get_output_instance (db2) should not die});

isa_ok($output, 'Dia::SQL::Output::DB2')
  or diag(Dumper($output));
can_ok($output, 'get_schema_create');

my $create_table = $output->_get_create_table_sql($table);
#diag($create_table);

like($create_table, qr|.*
create \s+ table \s+ extremes \s* \(
    \s+ name \s+ varchar \s* \(32\) \s+ not \s+ null \s* ,
    \s+ colName \s+ varchar \s* \(64\) \s* ,
    \s+ minVal \s+ numeric \s* \(15\) \s* ,
    \s+ maxVal \s+ numeric \s* \(15\) \s* ,
		\s+ constraint \s+ pk_\w+ \s+ primary \s+ key  \s* \(name\)
    \s* \) \s* (;)?
.*|six, q{Check syntax for sql create table extremes});


__END__
