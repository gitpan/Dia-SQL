#   $Id: 001-new.t 339 2009-02-10 09:38:56Z aff $

use warnings;
use strict;

use Test::More;
use File::Spec::Functions;
use lib catdir qw ( blib lib );

plan tests => 2;

use_ok ('Dia::SQL');

my $diasql = Dia::SQL->new();
isa_ok($diasql, q{Dia::SQL}, q{Expect a Dia::SQL object});

__END__

