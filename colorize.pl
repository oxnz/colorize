#!/usr/bin/env perl

use strict;
use warnings;

{
	my %color = (
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

	my %subst = (
		'debug'		=> 'green',
		'info'	=> 'cyan',
		'warning|warn'	=> 'yellow',
		'error|fatal'		=> 'red',
		'\'.*?\''	=> 'blue', # single quote
		'\".*?\"'	=> 'blue', # double quote
	);

	sub colorize {
		while (my ($keywords, $colorkey) = each %subst) {
			s/($keywords)/\e[$color{$colorkey}m$1\e[m/ig;
		}
	}
}


while (<>) {
	&colorize;
	print;
}
