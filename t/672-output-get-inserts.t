#   $Id: 672-output-get-inserts.t 425 2009-02-19 22:19:30Z aff $

use warnings;
use strict;

use Data::Dumper;
use Test::More;
use Test::Exception;
use File::Spec::Functions;
use lib catdir qw ( blib lib );

plan tests => 20;

use lib q{lib};
use_ok ('Dia::SQL');
use_ok ('Dia::SQL::Output');

my $diasql =  Dia::SQL->new( file => catfile(qw(t data TestERD.dia)), db => 'db2' );
isa_ok($diasql, q{Dia::SQL}, q{Expect a Dia::SQL object});
is($diasql->convert(), 1, q{Expect convert() to return 1});

my $output   = undef;
isa_ok($diasql, 'Dia::SQL');
lives_ok(sub { $output = $diasql->get_output_instance(); },
  q{get_output_instance (db2) should not die});

isa_ok($output, 'Dia::SQL::Output')
  or diag(Dumper($output));
isa_ok($output, 'Dia::SQL::Output::DB2')
  or diag(Dumper($output));

can_ok($output, 'get_inserts');
my $inserts = $output->get_inserts();

like($inserts, qr/.*
insert \s+ into \s+ categoryNames \s+ values \s* \( \s* 'Buildings' \s* \) \s* (;)?
.*/six);

like($inserts, qr/.*
insert \s+ into \s+ categoryNames \s+ values \s* \( 'Landscapes'  \s* \) (;)?
.*/six);

like($inserts, qr/.*
insert \s+ into \s+ categoryNames \s+ values \s* \( 'Nudes'  \s* \) (;)?
.*/six);

like($inserts, qr/.*
insert \s+ into \s+ categoryNames \s+ values \s* \( 'Life \s+ Studies'  \s* \) (;)?
.*/six);

like($inserts, qr/.*
insert \s+ into \s+ categoryNames \s+ values \s* \( 'Portraits'  \s* \) (;)?
.*/six);

like($inserts, qr/.*
insert \s+ into \s+ categoryNames \s+ values \s* \( 'Abstracts'  \s* \) (;)?
.*/six);

like($inserts, qr/.*
insert \s+ into \s+ attributeCategory \s+ values \s* \( 1,'Blurriness'  \s* \) (;)?
.*/six);

like($inserts, qr/.*
insert \s+ into \s+ attributeCategory \s+ values \s* \( 2,'Contrastiness'  \s* \) (;)?
.*/six);

like($inserts, qr/.*
insert \s+ into \s+ attributeCategory \s+ values \s* \( 3,'Saturation'  \s* \) (;)?
.*/six);

like($inserts, qr/.*
insert \s+ into \s+ attributeCategory \s+ values \s* \( 4,'Size'  \s* \) (;)?
.*/six);

like($inserts, qr/.*
insert \s+ into \s+ attributeCategory \s+ values \s* \( 5,'Relevence'  \s* \) (;)?
.*/six);


__END__
