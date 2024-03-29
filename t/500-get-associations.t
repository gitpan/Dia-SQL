#   $Id: 500-get-associations.t 375 2009-02-16 07:57:18Z aff $

use warnings;
use strict;

use Data::Dumper;
use Test::More;
use File::Spec::Functions;
use lib catdir qw ( blib lib );

plan tests => 5;

use_ok ('Dia::SQL');

my $diasql =  Dia::SQL->new( file => catfile(qw(t data TestERD.dia)), db => 'db2' );
isa_ok($diasql, q{Dia::SQL}, q{Expect a Dia::SQL object});

# TODO: Add test on return value - call wrapper
$diasql->convert();

my $association_arrayref = $diasql->get_associations_ref();
#diag(Dumper($association_arrayref));

my $expected = [
  [ 'subImageInfo',      'fk_iisii', 'imageInfo_id', 'imageInfo', 'id', '' ],
  [ 'imageCategoryList', 'fk_iiicl', 'imageinfo_id', 'imageInfo', 'id', '' ],
  [ 'imageAttribute',    'fk_iiia',  'imageInfo_id', 'imageInfo', 'id', '' ],
  [
    'userImageRating', 'fk_uiuir',
    'userInfo_id',     'userInfo',
    'id',              'on delete cascade'
  ],
  [
    'userAttribute', 'fk_uiua',
    'userInfo_id',   'userInfo',
    'id',            'on delete cascade'
  ],
  [
    'userSession', 'fk_uius', 'userInfo_id', 'userInfo',
    'id',          'on delete cascade'
  ],
  [
    'imageAttribute',       'fk_iaac',
    'attributeCategory_id', 'attributeCategory',
    'id',                   ''
  ],
  [
    'userAttribute',        'fk_acua',
    'attributeCategory_id', 'attributeCategory',
    'id',                   ''
  ]
];

is_deeply($association_arrayref, $expected);
undef $diasql;

# ------- many-to-many relations -------
my $diasql_many_to_many =  Dia::SQL->new( file => catfile(qw(t data many_to_many.dia)), db => 'db2' );
isa_ok($diasql_many_to_many, q{Dia::SQL}, q{Expect a Dia::SQL object});

# TODO: Add test on return value - call wrapper
$diasql_many_to_many->convert();

my $association_many_to_many_arrayref = $diasql_many_to_many->get_associations_ref();
#diag("association_many_to_many_arrayref: ".Dumper($association_many_to_many_arrayref));

my $expected_many_to_many =  [
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


is_deeply( $association_many_to_many_arrayref, $expected_many_to_many );

#   or diag( q{association_many_to_many_arrayref: }
#     . Dumper($association_many_to_many_arrayref)
#     . q{ expected }
#     . Dumper($expected_many_to_many) );

__END__
