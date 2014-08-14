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
		'(D|d)ebug:|\[(D|d)ebug\](:|)' => {
			'color'	=> 'cyan',
			'font'	=> 'normal'
		},
		'info|(\[info\]):?'	=> {
			'color'	=> 'green',
			'font'	=> 'normal'
		},
		'((warn(ing)?)|(\[warn(ing)?\])):?'	=> {
			'color'	=> 'yellow',
			'font'	=> 'normal'
		},
		'error:|\[error\]:?' => {
			'color'	=> 'red',
			'font'	=> 'normal'
		},
		'fatal( error|):|\[fatal( error|)\]:?' => {
			'color'	=> 'red',
			'font'	=> 'bold'
		}
	);

	my %keywords = (
		'\'.*?\''	=> {
			'color'	=> 'blue', # single quote
			'font'	=> 'normal'
		},
		'\".*?\"'	=> {
			'color'	=> 'magneta', # double quote
			'font'	=> 'bold'
		}
	);


	#foreach my $font (keys %fonts) {
	#	print $fonts{$font}{'color'}, "\n";
	#}
	#exit;
	sub colorize {
		foreach my $level (keys %levels) {
			last if s/(^$level)/\e[$fonts{$levels{$level}{'font'}};$colors{$levels{$level}{'color'}}m$1\e[m/i;
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
