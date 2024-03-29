#   $Id: 650-output-get-create-associations.t 436 2009-02-20 09:13:54Z aff $

use warnings;
use strict;

use Data::Dumper;
use Test::More;
use Test::Exception;
use File::Spec::Functions;
use lib catdir qw ( blib lib );

plan tests => 29;

use_ok ('Dia::SQL');

my $diasql =  Dia::SQL->new( file => catfile(qw(t data TestERD.dia)), db => 'db2' );
isa_ok($diasql, q{Dia::SQL}, q{Expect a Dia::SQL object});

# TODO: Add test on return value - call wrapper
$diasql->convert();

# Output
my $output   = undef;
isa_ok($diasql, 'Dia::SQL');
lives_ok(sub { $output = $diasql->get_output_instance(); },
  q{get_output_instance (db2) should not die});

isa_ok($output, 'Dia::SQL::Output')
  or diag(Dumper($output));
isa_ok($output, 'Dia::SQL::Output::DB2')
  or diag(Dumper($output));

can_ok($output, 'get_associations_create');

# associations = foreign keys + indices
my $association_str = $output->get_associations_create();

# unique index
like($association_str, qr|.*
create \s+ unique \s+ index \s+ idx_iimd5 \s+ on \s+ imageInfo 
  \s* \( \s* md5sum \s* \) \s* allow \s+ reverse \s+ scans \s* (;)?
.*
|six, q{Expect unique index on imageInfo});

like($association_str, qr|.*
create \s+ unique \s+ index \s+ idx_uinm \s+ on \s+ userInfo \s* \(name,md5sum\) \s* allow \s+ reverse \s+ scans \s* (;)?
|six, q{Expect unique index});

like($association_str, qr|.*
create \s+ unique \s+ index \s+ idx_iimd5 \s+ on \s+ imageInfo \s* \(md5sum\) \s* allow \s+ reverse \s+ scans \s* (;)?
|six, q{Expect unique index});

# index
like($association_str, qr|.*
create \s+ index \s+ idx_iiid \s+ on \s+ imageInfo \s* \(id\) \s* allow \s+ reverse \s+ scans \s* (;)?
|six, q{Expect index});

like($association_str, qr|.*
create \s+ index \s+ idx_siiid \s+ on \s+ subImageInfo \s* \(imageInfo_id\) \s* allow \s+ reverse \s+ scans \s* (;)?
|six, q{Expect index});

like($association_str, qr|.*
create \s+ index \s+ idx_siips \s+ on \s+ subImageInfo \s* \(pixSize\) \s* allow \s+ reverse \s+ scans \s* (;)?
|six, q{Expect index});

like($association_str, qr|.*
create \s+ index \s+ idx_iclidnm \s+ on \s+ imageCategoryList \s* \(imageInfo_id,name\) \s* allow \s+ reverse \s+ scans \s* (;)?
|six, q{Expect index});

like($association_str, qr|.*
create \s+ index \s+ idx_uiid \s+ on \s+ userInfo \s* \(id\) \s* allow \s+ reverse \s+ scans \s* (;)?
|six, q{Expect index});

like($association_str, qr|.*
create \s+ index \s+ idx_uauiid \s+ on \s+ userAttribute \s* \(userInfo_id\) \s* allow \s+ reverse \s+ scans \s* (;)?
|six, q{Expect index});

like($association_str, qr|.*
create \s+ index \s+ idx_uiruid \s+ on \s+ userImageRating \s* \(userInfo_id\) \s* allow \s+ reverse \s+ scans \s* (;)?
|six, q{Expect index});

like($association_str, qr|.*
create \s+ index \s+ idx_acid \s+ on \s+ attributeCategory \s* \(id\) \s* allow \s+ reverse \s+ scans \s* (;)?
|six, q{Expect index});

like($association_str, qr|.*
create \s+ index \s+ idx_usmd5 \s+ on \s+ userSession \s* \(md5sum\) \s* allow \s+ reverse \s+ scans \s* (;)?
|six, q{Expect index});

# foreign keys
like($association_str, qr|.*
alter \s+ table \s+ subImageInfo \s+ add \s+ constraint \s+ fk_iisii
  \s+ foreign \s+ key \s* \( \s* imageInfo_id \s* \) \s* 
  \s+ references \s+ imageInfo \s* \( \s* id \s* \) \s* 
(;)?
.*
|six, q{Expect foreign key fk_iisii on subImageInfo});

diag(q{TODO: add all foreign keys});


undef $diasql;

# ------- many-to-many relations -------
my $diasql_m2m =  Dia::SQL->new( file => catfile(qw(t data many_to_many.dia)), db => 'db2' );
isa_ok($diasql_m2m, q{Dia::SQL}, q{Expect a Dia::SQL object});

# TODO: Add test on return value - call wrapper
$diasql_m2m->convert();

my $association_m2m_arrayref = $diasql_m2m->get_associations_ref();
#diag("association_m2m_arrayref: ".Dumper($association_m2m_arrayref));

my $expected_m2m =  [
          [
            'student_course',
            'stdn_crs_fk_StntSn',
            'course_id',
            'student',
            'ssn',
            'on delete cascade'
          ],
          [
            'student_course',
            'lTeT8iBKfXObJYiSrq',
            'ssn',
            'course',
            'course_id',
            'on delete cascade'
          ]
        ];


is_deeply( $association_m2m_arrayref, $expected_m2m );

#   or diag( q{association_m2m_arrayref: }
#     . Dumper($association_m2m_arrayref)
#     . q{ expected }
#     . Dumper($expected_m2m) );
my $output_m2m   = undef;
isa_ok($diasql_m2m, 'Dia::SQL');
lives_ok(sub { $output_m2m = $diasql_m2m->get_output_instance(); },
  q{get_output_instance (db2) should not die});

isa_ok($output_m2m, 'Dia::SQL::Output')
  or diag(Dumper($output_m2m));
isa_ok($output_m2m, 'Dia::SQL::Output::DB2')
  or diag(Dumper($output_m2m));

can_ok($output_m2m, 'get_associations_create');

# associations = foreign keys + indices
my $association_str_m2m = $output_m2m->get_associations_create();

# check 2 foreign keys
like($association_str_m2m, qr/.*
alter \s+ table \s+ student_course \s+ add \s+ constraint \s+ stdn_crs_fk_StntSn \s+ foreign \s+ key \s* \( \s* course_id \s* \) \s+ references \s+ student \s* \( \s* ssn \s* \) \s* on \s+ delete \s+ cascade
.*/six);

like($association_str_m2m, qr/.*
alter \s+ table \s+ student_course \s+ add \s+ constraint \s+ lTeT8iBKfXObJYiSrq \s+ foreign \s+ key \s* \( \s* ssn \s* \) \s* references \s+ course \s+ \s* \( \s* course_id \) \s* on \s+ delete \s+ cascade
.*/six);

__END__
