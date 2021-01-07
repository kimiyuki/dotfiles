#!/usr/bin/env perl
use strict;
use warnings;

my $query = shift;
my @queries = split /\s/, $query;

while (my $line = <STDIN>) {
    my $match = 0;
    for my $q (@queries) {
        if ($line =~ m{$q}) {
                 $match = 1;
                 last;
         }
    }
    print $line unless $match;
}
