# $Id: 902-pod.t 391 2009-02-17 13:53:52Z aff $

use strict;
use warnings;
use Test::More;

BEGIN {
  plan( skip_all => 'AUTHOR_TEST must be set for pod test; skipping' )
    if ( !$ENV { 'AUTHOR_TEST' } );
}

# Ensure a recent version of Test::Pod
my $min_tp = 1.22;
eval "use Test::Pod $min_tp";
plan skip_all => "Test::Pod $min_tp required for testing POD" if $@;

all_pod_files_ok();

__END__