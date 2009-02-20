#   $Id: 670-output-get-pre-sql.t 413 2009-02-19 08:33:54Z aff $

use warnings;
use strict;

use Data::Dumper;
use Test::More;
use Test::Exception;
use File::Spec::Functions;
use lib catdir qw ( blib lib );

#plan tests => 1;
plan 'no_plan';

use lib q{lib};
use_ok ('Dia::SQL');
use_ok ('Dia::SQL::Output');

my $diasql =  Dia::SQL->new( files => [catfile(qw(t data TestERD.dia))], db => 'db2' );
isa_ok($diasql, q{Dia::SQL}, q{Expect a Dia::SQL object});

# Parse and convert
cmp_ok($diasql->convert(), q{==}, 1,q{Expect convert to return 1});

my $output   = undef;
isa_ok($diasql, 'Dia::SQL');
lives_ok(sub { $output = $diasql->get_output_instance(); },
  q{get_output_instance (db2) should not die});

isa_ok($output, 'Dia::SQL::Output')
  or diag(Dumper($output));
isa_ok($output, 'Dia::SQL::Output::DB2')
  or diag(Dumper($output));


diag(q{NOTIMPL*D get pre sql});
# can_ok($output, 'get_pre_sql');
# drop sequence imageInfo_id;
# create sequence imageInfo_id;


__END__
