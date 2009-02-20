
# $Id: 904-kwalitee.t 399 2009-02-18 07:35:03Z aff $

use strict;
use warnings;

use Test::More;

BEGIN {
  eval { require Test::Kwalitee;  };
  plan( skip_all => 'Test::Kwalitee not installed; skipping' ) if $@;

  plan( skip_all => 'AUTHOR_TEST must be set for kwalitee test; skipping' )
    if ( !$ENV { 'AUTHOR_TEST' } );
}

Test::Kwalitee->import();

__END__

