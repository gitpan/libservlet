# -*- Mode: Perl; indent-tabs-mode: nil; -*-

package Servlet::Test::Request;

use base qw(Servlet::ServletRequest Servlet::Test::Dummy);
use strict;
use warnings;

use Servlet::Test::InputStream ();

sub getInputStream {
    my $self = shift;

    return Servlet::Test::InputStream->new(@_);
}

1;
__END__
