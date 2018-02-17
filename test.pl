#!/usr/bin/env perl
use strict;
use warnings;
use HTTP::Tinyish;

print "$^X $^V\n";
for my $klass ("HTTP::Tiny", "HTTP::Tinyish", "IO::Socket::SSL", "Net::SSLeay", "LWP", "LWP::Protocol::https") {
    my $version = eval "require $klass; $klass->VERSION" || "N/A";
    print "$klass $version\n";
}
print "\n";

my $fail = { status => '000', reason => '?', content => '' };
for my $backend (map "HTTP::Tinyish::$_", qw( LWP HTTPTiny Curl Wget )) {
    local $HTTP::Tinyish::PreferredBackend = $backend;
    my $http = HTTP::Tinyish->new;
    my $res = eval { $http->get("https://metacpan.org/") } || $fail;
    print "---> $backend\n";
    print "$res->{status} $res->{reason}\n";
    print $res->{content} unless $res->{success};
}
