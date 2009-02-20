# $Id: 903-perlcritic.t 399 2009-02-18 07:35:03Z aff $

use strict;
use warnings;

use Test::More;

BEGIN {
  plan( skip_all => 'AUTHOR_TEST must be set for perlcritic test; skipping' )
    if ( !$ENV { 'AUTHOR_TEST' } );

  eval "use Test::Perl::Critic ( -severity => 4 )";
  plan(skip_all => 'Test::Perl::Critic required to criticise code') if ($@);
}

all_critic_ok();

__END__
