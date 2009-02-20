#   $Id: 610-output-getinstance.t 418 2009-02-19 13:24:17Z aff $

use warnings;
use strict;

use Data::Dumper;
use Test::More;
use Test::Exception;  # test code that dies
use File::Spec::Functions;
use lib catdir qw ( blib lib );

plan tests => 9;

use lib q{lib};
use_ok ('Dia::SQL');
use_ok ('Dia::SQL::Logger');

my $diasql = Dia::SQL->new(db => 'foo');
isa_ok($diasql, 'Dia::SQL');

ok(Dia::SQL::Logger::log_off());
throws_ok(
  sub { $diasql->get_output_instance(); },
  qr/failed to get instance/i,
  q{get_output_instance (foo) should die}
);
ok(Dia::SQL::Logger::log_on());
undef $diasql;


$diasql = Dia::SQL->new(db => 'db2',);

isa_ok($diasql, 'Dia::SQL');
my $subclass = undef;
lives_ok( sub { $subclass = $diasql->get_output_instance(); }, q{get_output_instance (db2) should not die});
isa_ok($subclass, 'Dia::SQL::Output::DB2');


__END__
