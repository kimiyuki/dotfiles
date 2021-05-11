#!/usr/bin/perl -w

use strict;
my @lines;
while (<>)
{
  while (/\\\Z/)
  {
    $_ .= <>;
  }
  push @lines, $_;
}
my %seen=();
print grep { not $seen{$_}++ } @lines;

# from
# http://blog.umasaka.com/archives/1710

