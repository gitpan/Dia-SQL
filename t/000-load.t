# $Id: 000-load.t 339 2009-02-10 09:38:56Z aff $

use warnings;
use strict;

use Test::More tests => 1;
use Config;
use File::Spec::Functions;
use lib catdir qw ( blib lib );

BEGIN {
  use_ok( 'Dia::SQL' );
}

diag( "Testing Dia::SQL $Dia::SQL::VERSION, Perl $], $^X, archname=$Config{archname}, byteorder=$Config{byteorder}" );

__END__
