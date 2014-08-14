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

	my %fonts = (
		'normal'=> '00',
		'bold'	=> '01'
	);

	my %levels = (
		qr/(D|d)ebug:|\[(D|d)ebug\](:|)/i => {
			'color'	=> 'cyan',
			'font'	=> 'normal'
		},
		qr/info|(\[info\]):?/i => {
			'color'	=> 'green',
			'font'	=> 'normal'
		},
		qr/((warn(ing)?)|(\[warn(ing)?\])):?/i => {
			'color'	=> 'yellow',
			'font'	=> 'normal'
		},
		qr/error:|\[error\]:?/i => {
			'color'	=> 'red',
			'font'	=> 'normal'
		},
		qr/fatal( error|):|\[fatal( error|)\]:?/i => {
			'color'	=> 'red',
			'font'	=> 'bold'
		}
	);

	my %keywords = (
		qr/\'.*?\'/	=> {
			'color'	=> 'blue', # single quote
			'font'	=> 'normal'
		},
		qr/\".*?\"/	=> {
			'color'	=> 'magneta', # double quote
			'font'	=> 'bold'
		}
	);


	#foreach my $font (keys %fonts) {
	#	print $fonts{$font}{'color'}, "\n";
	#}
	#exit;
	sub colorize {
		foreach my $pattern (keys %levels) {
			last if s/(^$pattern)/\e[$fonts{$levels{$pattern}{'font'}};$colors{$levels{$pattern}{'color'}}m$1\e[m/i;
		}
		foreach my $keyword (%keywords) {
			s/($keyword)/\e[$fonts{$keywords{$keyword}{'font'}};$colors{$keywords{$keyword}{'color'}}m$1\e[m/g;
		}
	}
}


while (<>) {
	&colorize;
	print;
}
