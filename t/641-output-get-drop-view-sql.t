#   $Id: 641-output-get-drop-view-sql.t 413 2009-02-19 08:33:54Z aff $

use warnings;
use strict;

use Data::Dumper;
use Test::More;
use Test::Exception;
use File::Spec::Functions;
use lib catdir qw ( blib lib );

plan tests => 13;

use lib q{lib};
use_ok ('Dia::SQL');
use_ok ('Dia::SQL::Output');

my $diasql =  Dia::SQL->new( file => catfile(qw(t data TestERD.dia)), db => 'db2' );
isa_ok($diasql, q{Dia::SQL}, q{Expect a Dia::SQL object});
is($diasql->convert(), 1, q{Expect convert() to return 1});
my $classes       = $diasql->get_classes_ref();
ok(defined($classes) && ref($classes) eq q{ARRAY} && scalar(@$classes), q{Non-empty array ref});

# 2. output
my $output   = undef;
isa_ok($diasql, 'Dia::SQL');
lives_ok(sub { $output = $diasql->get_output_instance(); },
  q{get_output_instance (db2) should not die});

isa_ok($output, 'Dia::SQL::Output')
  or diag(Dumper($output));
isa_ok($output, 'Dia::SQL::Output::DB2')
  or diag(Dumper($output));

can_ok($output, 'get_schema_drop');
my $drop_table = $output->get_view_drop();

#diag($drop_table);
like($drop_table, qr/.*drop \s+ view \s+ ratings_view \s* ;/six);
like($drop_table, qr/.*drop \s+ view \s+ whorated_view \s* ;/six);
like($drop_table, qr/.*drop \s+ view \s+ users_view \s* ;/six);

__END__
