#   $Id: 700-utils-load.t 346 2009-02-10 16:06:40Z aff $

use warnings;
use strict;

use Data::Dumper;
use Test::More;
use File::Spec::Functions;
use lib catdir qw ( blib lib );

plan tests => 1;

use lib q{lib};
use_ok ('Dia::SQL::Utils');

__END__
