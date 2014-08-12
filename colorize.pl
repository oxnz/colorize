#!/usr/bin/env perl

use strict;
use warnings;

{
	my %colors = (
		'black'	=> 30,
		'red'	=> 31,
		'green'	=> 32,
		'yellow'=> 33,
		'blue'	=> 34,
		'magneta'	=> 35,
		'cyan'	=> 36,
		'white'	=> 37,
		'default'	=> 39
	);

	my %levels = (
		'debug|(\[debug\]):?' => 'cyan',
		'info|(\[info\]):?'	=> 'green',
		'((warn(ing)?)|(\[warn(ing)?\])):?'	=> 'yellow',
		'(((fatal )?error)|(\[(fatal )?error\])|fatal):?'	=> 'red',
	);

	my %keywords = (
		'\'.*?\''	=> 'blue', # single quote
		'\".*?\"'	=> 'magneta', # double quote
	);

	sub colorize {
		while (my ($level, $color) = each %levels) {
			s/(^$level)/\e[$colors{$color}m$1\e[m/i;
		}
		foreach my $keyword (%keywords) {
			s/($keyword)/\e[$colors{$keywords{$keyword}}m$1\e[m/g;
		}
	}
}


while (<>) {
	&colorize;
	print;
}
