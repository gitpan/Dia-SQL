#   $Id: 643-output-get-drop-permissions-sql.t 413 2009-02-19 08:33:54Z aff $

use warnings;
use strict;

use Data::Dumper;
use Test::More;
use Test::Exception;
use File::Spec::Functions;
use lib catdir qw ( blib lib );

plan tests => 23;

use lib q{lib};
use_ok ('Dia::SQL');
use_ok ('Dia::SQL::Output');


my $diasql =  Dia::SQL->new( file => catfile(qw(t data TestERD.dia)), db => 'db2' );
isa_ok($diasql, q{Dia::SQL}, q{Expect a Dia::SQL object});
is($diasql->convert(), 1, q{Expect convert() to return 1});

# 2. output
my $output   = undef;
isa_ok($diasql, 'Dia::SQL');
lives_ok(sub { $output = $diasql->get_output_instance(); },
  q{get_output_instance (db2) should not die});

isa_ok($output, 'Dia::SQL::Output')
  or diag(Dumper($output));
isa_ok($output, 'Dia::SQL::Output::DB2')
  or diag(Dumper($output));

can_ok($output, 'get_permissions_drop');
my $permissions_drop = $output->get_permissions_drop();

like($permissions_drop, qr/.*
revoke \s+ all \s+ on \s+ imageInfo \s+ from \s+ fmorg \s* (;)?
.*/six);
like($permissions_drop, qr/.*
revoke \s+ select \s+ on \s+ imageInfo \s+ from \s+ public \s* (;)?
.*/six);

like($permissions_drop, qr/.*
revoke \s+ all \s+ on \s+ subImageInfo \s+ from \s+ fmorg \s* (;)?
.*/six);

like($permissions_drop, qr/.*
revoke \s+ all \s+ on \s+ imageCategoryList \s+ from \s+ fmorg \s* (;)?
.*/six);

like($permissions_drop, qr/.*
revoke \s+ select \s+ on \s+ categoryNames \s+ from \s+ public \s* (;)?
.*/six);

like($permissions_drop, qr/.*
revoke \s+ all \s+ on \s+ categoryNames \s+ from \s+ fmorg \s* (;)?
.*/six);

like($permissions_drop, qr/.*
revoke \s+ all \s+ on \s+ imageAttribute \s+ from \s+ fmorg \s* (;)?
.*/six);

like($permissions_drop, qr/.*
revoke \s+ all \s+ on \s+ userInfo \s+ from \s+ fmorg \s* (;)?
.*/six);

like($permissions_drop, qr/.*
revoke \s+ all \s+ on \s+ userAttribute \s+ from \s+ fmorg \s* (;)?
.*/six);

like($permissions_drop, qr/.*
revoke \s+ all \s+ on \s+ userImageRating \s+ from \s+ fmorg \s* (;)?
.*/six);

like($permissions_drop, qr/.*
revoke \s+ all \s+ on \s+ attributeCategory \s+ from \s+ fmorg \s* (;)?
.*/six);

like($permissions_drop, qr/.*
revoke \s+ all \s+ on \s+ userSession \s+ from \s+ fmorg \s* (;)?
.*/six);

like($permissions_drop, qr/.*
revoke \s+ select \s+ on \s+ extremes \s+ from \s+ public \s* (;)?
.*/six);

like($permissions_drop, qr/.*
revoke \s+ all \s+ on \s+ extremes \s+ from \s+ fmorg \s* (;)?
.*/six);

__END__
