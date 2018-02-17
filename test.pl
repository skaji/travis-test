#!/usr/bin/env perl
use strict;
use warnings;

use HTTP::Tiny;
use IO::Socket::SSL;
use JSON::PP ();

my $http = HTTP::Tiny->new;

my $url = "https://fastapi.metacpan.org/v1/release/_search";

my $query = {
    query => {
        bool => {
            must => [
                { term => { distribution => "perl" } },
            ],
        },
    },
    size => 500,
    sort => [ { date => 'desc' } ],
    fields => [qw( name date author version status maturity authorized download_url )],
};

my $res = $http->post($url, {
    content => JSON::PP::encode_json($query),
    headers => {
        'content-type' => "application/json",
    },
});

print "$res->{status} $res->{reason}\n";
print $res->{content};
