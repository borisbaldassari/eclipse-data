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
usage: $0 [-h|--help] project_id

$0 retrieves git review information from a Gerrit instance.
Writes changes information in a CSV file.

Parameters:
* [-h|--help]               Display usage and exit
* project_id                The project to be analysed, e.g. sirius/org.eclipse.sirius
    
Example:
\$ $0 sirius/org.eclipse.sirius

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

print "# Gerrit instance test run on " . localtime  . ".\n\n";
print "  Using [$url_base].\n\n";

my $ua  = Mojo::UserAgent->new;

# Testing gerrit change

print "  Testing gerrit > changes.\n";

my $url = $url_base . "changes/?q=+project:$project_id";
#my $url = $url_base . "changes/?q=status:open+project:$project_id";
print "  Using $url.\n";

my $data;
my $page = 1;
my @changes;
my $cont = 1;

# While there are more pages, ask for them (aka pagination)
while ($cont) {
    my $url_tmp = $url . "\&S=$page";
    my $res = $ua->get($url_tmp)->result;
    if (not $res->is_success) {
	print "Error: Could not get resource $url_tmp.\n";
	print $res->message . "\n";
	exit;
    }
    
    my $json = $res->body;
    # Remove 5 first chars
    substr($json, 0, 5) = "";
    $data = decode_json($json);

    foreach my $i (@$data) {
	push(@changes, $i);
    }
    if ( not exists($changes[-1]->{'_more_changes'}) ) { 
	$cont = 0 
    } else {
	$page = $page + 100;
    }
}

print "  => Found " . scalar(@changes) . ".\n";
my $c = $changes[0];
print "  Attributes: \n";
print Dumper(keys %{$c}) . "\n";

print "# List of changes (showing only 10 items).\n";
print map { "  - " . $_->{'status'} . " " . $_->{'project'} . " " . $_->{'subject'} . "\n" } @{$data}[1..10];

# 
# Write Changes CSV file
#

my $csv = Text::CSV->new({binary => 1, eol => "\n"});
my $csv_out = "id,status,project,change_id,branch,created,updated,insertions,deletions,submit_type,subject\n";

foreach my $c (@changes) {    
    my @change = (
 	$c->{'id'},
 	$c->{'status'},
 	$c->{'project'},
 	$c->{'change_id'},
 	$c->{'branch'},
 	$c->{'created'},
 	$c->{'updated'},
 	$c->{'insertions'},
 	$c->{'deletions'},
 	$c->{'submit_type'},
 	$c->{'subject'},
	);	
    
    $csv->combine(@change);
    $csv_out .= $csv->string();
}

open my $fh_out, '>', "gerrit_changes.csv" or die "Cannot write to gerrit_changes.csv.\n";
print $fh_out $csv_out;
close $fh_out;


#
# Query open changes
#

$url = $url_base . "changes/?q=status:open+project:$project_id";
print "  Using $url.\n";
$page = 1;
my @changes_open;
$cont = 1;

# While there are more pages, ask for them (aka pagination)
while ($cont) {
    my $url_tmp = $url . "\&S=$page";
    my $res = $ua->get($url_tmp)->result;
    if (not $res->is_success) {
	print "Error: Could not get resource $url_tmp.\n";
	print $res->message . "\n";
	exit;
    }
    
    my $json = $res->body;
    # Remove 5 first chars
    substr($json, 0, 5) = "";
    $data = decode_json($json);

    foreach my $i (@$data) {
	push(@changes, $i);
    }
    if ( not exists($changes[-1]->{'_more_changes'}) ) { 
	$cont = 0 
    } else {
	$page = $page + 100;
    }
}

print "  => Found " . scalar(@changes) . " changes for project.\n";
$c = $changes[0];
print "  Attributes: \n";
print Dumper(keys %{$c}) . "\n";

print "# List of changes (showing only 10 items).\n";
print map { "  - " . $_->{'status'} . " " . $_->{'project'} . " " . $_->{'subject'} . "\n" } @{$data}[1..10];

# 
# Write Open Changes CSV file
#

$csv = Text::CSV->new({binary => 1, eol => "\n"});
$csv_out = "id,status,project,change_id,branch,created,updated,insertions,deletions,submit_type,subject\n";

foreach my $c (@changes_open) {    
    my @change = (
 	$c->{'id'},
 	$c->{'status'},
 	$c->{'project'},
 	$c->{'change_id'},
 	$c->{'branch'},
 	$c->{'created'},
 	$c->{'updated'},
 	$c->{'insertions'},
 	$c->{'deletions'},
 	$c->{'submit_type'},
 	$c->{'subject'},
	);	
    
    $csv->combine(@change);
    $csv_out .= $csv->string();
}

open $fh_out, '>', "gerrit_open_changes.csv" or die "Cannot write to gerrit_open_changes.csv.\n";
print $fh_out $csv_out;
close $fh_out;

