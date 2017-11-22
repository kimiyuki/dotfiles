#!/usr/bin/perl

use strict;
use warnings;

my $pattern = shift or die "usage: $0 [pattern]";
while(my $line = <STDIN>){ 
  chomp $line;
  print $line, "\n" if $line =~ /$pattern/;
}

__END__
"CustomMatcher": {
	"Perl/Regexp": [
		"perl",
		"/path/to/grep.pl",
		"$QUERY"
	]
}
