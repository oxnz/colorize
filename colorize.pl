#!/usr/bin/env perl

# Author: nz
# Email: yunxinyi@gmail.com
# Version: 0.1
# Description: a utility used for colorize the output of compiler, etc.

use strict;
use warnings;

{
	# static variables
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
		'bold'	=> '01',
		'faint'	=> '02',
		'underline'	=> '04',
		'negative'	=> '07',
		'conceal'	=> '08',
		'crossed'	=> '09',
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
		},
		qr/\(.*?\)/	=> {
			'color'	=> 'green', # double quote
			'font'	=> 'normal'
		},
		qr/\{.*?\}/ => {
			'color'	=> 'blue',
			'font'	=> 'normal'
		},
		qr/%\d+/ => {
			'color' => 'yellow',
			'font'	=> 'normal'
		}
	);


	sub colorize {
		foreach my $pattern (keys %levels) {
			last if s/(^$pattern)/\e[$fonts{$levels{$pattern}{'font'}};$colors{$levels{$pattern}{'color'}}m$1\e[m/i;
		}
		foreach my $keyword (%keywords) {
			s/($keyword)/\e[$fonts{$keywords{$keyword}{'font'}};$colors{$keywords{$keyword}{'color'}}m$1\e[m/g;
		}
	}
}

# sub main
{
	while (<>) {
		&colorize;
		print;
	}
}

__END__

=pod

=encoding utf8

=head1 NAME

colorize - colorize for specific field(s) in text file(s).

=head1 SYNOPSIS

colorize [-h]

Examples:

colorize /var/log/confluence.log

tail -f /var/log/tomcat.log | colorize

See below for more description of the switches.

=head1 DESCRIPTION

colorize is a shell script used to colorize specific fields of text files.

=head1 OPTIONS

=over 8

=item -h --help print help message and exit

=back

=head1 SEE ALSO

tail

=head1 AUTHOR

Current maintainer: nz L<yunxinyi@gmail.com>

=cut
