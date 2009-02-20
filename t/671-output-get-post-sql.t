#   $Id: 671-output-get-post-sql.t 397 2009-02-17 16:33:28Z aff $

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

diag('NOTIMPL!');

__END__
