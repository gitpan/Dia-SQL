#   $Id: 681-output-db2-get-sql.t 425 2009-02-19 22:19:30Z aff $

use warnings;
use strict;

use Data::Dumper;
use Test::More;
use Test::Exception;
use File::Spec::Functions;
use lib catdir qw ( blib lib );

plan tests => 5 ;

use lib q{lib};
use_ok ('Dia::SQL');
use_ok ('Dia::SQL::Output');
use_ok ('Dia::SQL::Output::DB2');

my $diasql =  Dia::SQL->new( file => catfile(qw(t data TestERD.dia)), db => 'db2');
isa_ok($diasql, q{Dia::SQL}, q{Expect a Dia::SQL object});
is($diasql->convert(), 1, q{Expect convert to return 1});

my $sql = $diasql->get_sql;
diag('TODO: Check output from get_sql');
diag($sql);

__END__

