#! /usr/bin/env perl

######################################################################
# Copyright (c) 2017 Castalia Solutions
#
# This program and the accompanying materials are made
# available under the terms of the Eclipse Public License 2.0
# which is available at https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
######################################################################

use strict;
use warnings;

use Getopt::Long;

use Mojo::UserAgent;
use Mojo::JSON qw(decode_json encode_json);
use Text::CSV;

use Data::Dumper;

# The base URL for the Gerrit instance
my $url_base = "https://git.eclipse.org/r/";

my $usage = <<EOU;
usage: $0 [-h|--help] 

$0 lists all projects defined on the Gerrit instance.
Writes the ouput to a CSV file (gerrit_projects.csv).

Parameters:
* [-h|--help]               Display usage and exit
    
Example:
\$ $0 

EOU

Getopt::Long::Configure("bundling");

# Define available options
my ($o_help);
my $options = GetOptions(
    'h|help' => \$o_help,
    );

# Display usage if help is needed.
if ( defined($o_help) ) {
    print $usage;
    exit;
}

print "# Gerrit instance test run on " . localtime  . ".\n\n";
print "  Using [$url_base].\n\n";

my $ua  = Mojo::UserAgent->new;

# Testing gerrit projects

print "\n# Testing gerrit > projects.\n";

my $url = $url_base . "projects/";
print "  Using $url.\n";
my $res = $ua->get($url)->result;

if (not $res->is_success) {
    print "Error: Could not get resource $url.\n";
    print $res->message . "\n";
    exit;
}

my $json = $res->body;
# Remove 5 first chars
substr($json, 0, 5) = "";
my $data = decode_json($json);

print "  => Found " . scalar(keys %{$data}) . " projects:\n";
my @projects;
foreach my $c (keys %$data) {
    $data->{$c}{'project'} = $c;
    push( @projects, $data->{$c} );
}
# List projects on stdout
print map { "  - " . $_ . " " . $data->{$_}{'state'} . " \n" } keys %$data;

# 
# Write Projects CSV file
#

my $csv = Text::CSV->new({binary => 1, eol => "\n"});
my $csv_out = "project,state,web_links\n";

foreach my $p (@projects) {
    foreach my $wl (@{$p->{'web_links'}}) {
	my @i = (
	    $p->{'project'},
	    $p->{'state'},
	    $wl->{'url'},
	    );	
	
	$csv->combine(@i);
	$csv_out .= $csv->string();
    }
}

open my $fh_out, '>', "gerrit_projects.csv" or die "Cannot write to gerrit_projects.csv.\n";
print $fh_out $csv_out;
close $fh_out;
