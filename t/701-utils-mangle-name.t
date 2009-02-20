#   $Id: 701-utils-mangle-name.t 418 2009-02-19 13:24:17Z aff $

use warnings;
use strict;

use Data::Dumper;
use Test::More;
use File::Spec::Functions;
use lib catdir qw ( blib lib );

plan tests => 10;

use lib q{lib};
use_ok ('Dia::SQL::Utils');

my $utils = Dia::SQL::Utils->new();
isa_ok($utils, 'Dia::SQL::Utils');


# mangle_name
Dia::SQL::Logger::log_off() or diag(q{Failed to turn off logging});
is($utils->mangle_name(undef,undef), undef);
is($utils->mangle_name(q{},-1),undef);
Dia::SQL::Logger::log_on() or diag(q{Failed to turn on logging});

is($utils->mangle_name(q{a},5),q{a});
is($utils->mangle_name(q{short},5),q{short});
is($utils->mangle_name(q{longer},6),q{longer});
is($utils->mangle_name(q{longer},4),q{loer});
is($utils->mangle_name(q{imalumberjackbutimok},14),q{imalumbbutimok}); # chop here and there
is($utils->mangle_name(q{imalumberjackbutimokiworkallnightandisleepallday},14),q{pSo8US4paCtxKI}); # turns to base64 when input overflows limit by 6 chars

__END__
