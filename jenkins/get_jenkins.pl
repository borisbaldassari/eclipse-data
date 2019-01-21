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

# The base URL for the Jenkins instance
my $url_base = "https://ci.eclipse.org/";

my $usage = <<EOU;
usage: $0 [-h|--help] project_id

$0 retrieves continuous integration information from a Jenkins instance.

Parameters:
* [-h|--help]               Display usage and exit
* project_id                The project to be analysed, e.g. californium
    
Example:
\$ $0 californium

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

# Get project parameter from cli, or die.
my $project_id = shift or die $usage;
$url_base = $url_base . $project_id;

print "# Jenkins instance test run on " . localtime  . ".\n";
print "  Using [$url_base].\n";

my $ua  = Mojo::UserAgent->new;

print "  Testing basic root acces.\n";

my $url = $url_base . '/api/json';
print "  Using $url.\n";
my $res = $ua->get($url)->result;

if (not $res->is_success) {
    print "Error: Could not get resource $url.\n";
    print $res->message . "\n";
    exit;
}

# Decode JSON from server
my $data = decode_json($res->body);

print "  Found " . scalar(keys %{$data}) . " attributes:\n";
print map { 
    "  - " . $_ . ".\n" 
} keys %{$data};

print "* NodeDescription: " . $data->{'nodeDescription'} . "\n";
print "* Number of executors: " . $data->{'numExecutors'} . "\n";
print "* NodeName: " . $data->{'nodeName'} . "\n";
print "* Mode: " . $data->{'mode'} . "\n";

print "* Jobs: found " . scalar(@{$data->{'jobs'}}) . " items:\n"; 
print map { 
    "    - " . $_->{'name'} . " [ " . $_->{'color'} . " ] " . $_->{'url'} . ".\n" 
} @{$data->{'jobs'}};


# 
# Write Main CSV file
#

my $csv = Text::CSV->new({binary => 1, eol => "\n"});
my $csv_out = "attribute,value\n";
my @attrs = ("nodeName", "nodeDescription", "mode", "slaveAgentPort", "numExecutors");

# Build the next CSV line
foreach my $a (@attrs) {
    $csv->combine( ($a, $data->{$a}) );
    $csv_out .= $csv->string();
}

open my $fh_out, '>', "jenkins_main.csv" or die "Cannot write to jenkins_main.csv.\n";
print $fh_out $csv_out;
close $fh_out;

# 
# Write Jobs CSV file
#

$csv = Text::CSV->new({binary => 1, eol => "\n"});
$csv_out = "name,color,url\n";

# Build the next CSV line
foreach my $j (@{$data->{'jobs'}}) {
    my @job = (
	$j->{'name'},
	$j->{'color'},
	$j->{'url'},
	);	
    
    $csv->combine(@job);
    $csv_out .= $csv->string();
}

open $fh_out, '>', "jenkins_jobs.csv" or die "Cannot write to jenkins_jobs.csv.\n";
print $fh_out $csv_out;
close $fh_out;


# Testing auth
# we have no credentials on jenkins.
#my $url_auth = Mojo::URL->new($url)->userinfo('USER@domain.net:PASSWORD');
