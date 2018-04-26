#!/usr/bin/env perl
use strict;
use warnings;

use IO::Uncompress::Gunzip;

my $file = shift or die;
my $tmp = "/tmp/temp1";

for (1..5000) {
    if (-f $tmp) {
        unlink $tmp or die;
    }
    IO::Uncompress::Gunzip::gunzip($file, $tmp) or die;
    my $s = -s $tmp;
    if ($s != 4214) {
        die;
    }
}
warn "done";
