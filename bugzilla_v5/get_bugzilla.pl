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

# The base URL for the Bugzilla instance
my $url_base = "https://bugs.eclipse.org/bugs/";

my $usage = <<EOU;
usage: $0 [-h|--help] product [bug_id]

$0 retrieves git review information from a Gerrit instance.

Parameters:
* [-h|--help]             Display usage and exit
* product                 The product to be analysed, as defined in the bug 
                          e.g. Platform
* [bug_id]                An optional bug ID to retrieve information from. If none
                          is provided the full list is retrieved.
    
Examples:
\$ $0 Platform
\$ $0 Platform 100

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

# Define the list of attributes we want to use for the list of bugs
# This is only used when no bug_id is provided, though.
my @attrs = ('id', 'summary', 'status', 'resolution', 'severity', 'priority', 'classification', 
             'platform', 'product', 'version', 'component', 'creation_time', 'creator', 
             'assigned_to', 'last_change_time', 'target_milestone');
# Define the list of attributes to retrieve for comments.
my @com_attrs = ('bug_id', 'creator', 'creation_time', 'count', 'is_private', 'text');

# Get product parameter from cli, or die.
my $product = shift or die $usage;
my $bug_id = shift;

# Just make sure that the bug id is a number
if (defined($bug_id) and $bug_id !~ m!^\d+$!) {
    print "Ouch!!! Bug id must be a number! Please stop that!\n";
    die $usage;
}

print "# Bugzilla export run on " . localtime  . ".\n";
print "  Using [$url_base].\n\n";

my $ua  = Mojo::UserAgent->new;
my @bugs;

if ( defined($bug_id) ) {

    # Testing single bug report

    print "\n# Testing single bug report.\n";
    
    my $url_bug = $url_base . "rest/bug/";
    my $url = $url_bug . $bug_id;
    my $res = $ua->get($url)->result;
    
    if (not $res->is_success) {
	print "Error: Could not get resource $url.\n";
	print $res->message . "\n";
	exit;
    }
    
    my $json = $res->body;
    my $data = decode_json($json);
    
    print "  Found " . scalar(keys %{$data->{'bugs'}[0]}) . " keys:\n";
    print map { 
	"  - " . $_ . ": " . (Dumper($data->{'bugs'}[0]{$_}) || '*** UNDEF ***') . "" 
    } keys %{$data->{'bugs'}[0]};

    # Write export of bug to csv file.
    my $csv = Text::CSV->new({binary => 1, eol => "\n"});
    my $csv_out = join(',', @attrs) . "\n";
    
    my @bug = map { $data->{'bugs'}[0]{$_} } @attrs;
    $csv->combine( @bug );
    $csv_out .= $csv->string();
    
    my $bug_out_csv = "bugzilla_bug_" . $bug_id . ".csv";
    open my $fh_out, '>', $bug_out_csv or die "Cannot write to file [$bug_out_csv].\n";
    print $fh_out $csv_out;
    close $fh_out;

    # Testing single bug comments

    print "\n# Testing single bug comments.\n";
    
    my $url_comments = $url_base . "rest/bug/";
    $url = $url_comments . $bug_id . "/comment";
    $res = $ua->get($url)->result;
    
    if (not $res->is_success) {
	print "Error: Could not get resource $url.\n";
	print $res->message . "\n";
	exit;
    }
    
    $json = $res->body;
    $data = decode_json($json);
    
    print "  Found " . scalar(keys %{$data->{'bugs'}{$bug_id}{'comments'}[0]}) . " keys:\n";
    print map { 
	"  - " . $_ . ": " . (Dumper($data->{'bugs'}{$bug_id}{'comments'}[0]{$_}) || '*** UNDEF ***') . "" 
    } keys %{$data->{'bugs'}{$bug_id}{'comments'}[0]};
    
    print "  Found " . scalar(@{$data->{'bugs'}{$bug_id}{'comments'}}) . " comments:\n";
    print map { 
	"  - " . $_->{'time'} . " by " . $_->{'creator'} . ".\n" 
    } @{$data->{'bugs'}{$bug_id}{'comments'}};
    

    # Write list of comments to csv file.
    $csv = Text::CSV->new({binary => 1, eol => "\n"});
    $csv_out = join(',', @com_attrs) . "\n";
    
    foreach my $c ( @{$data->{'bugs'}{$bug_id}{'comments'}} ) { 
	my @com = map { $c->{$_} } @com_attrs;
	$csv->combine( @com );
	$csv_out .= $csv->string();
    }
    
    my $comment_out_csv = "bugzilla_bug_" . $bug_id . "_comments.csv";
    open $fh_out, '>', $comment_out_csv or die "Cannot write to CSV file [$comment_out_csv].\n";
    print $fh_out $csv_out;
    close $fh_out;

    
} else {
    
    # Testing multiple bugs report

    print "# Testing multiple bugs report.\n";
    
    my $url = $url_base . "rest/bug?product=" . $product . 
	"&include_fields=" . join(',', @attrs);
    # the url should look like this:
    # "/rest/bug?id=1&product=" . $product . "&include_fields=id,summary,etc";
    print "  Using $url.\n";
    my $res = $ua->get($url)->result;
    
    if (not $res->is_success) {
	print "Error: Could not get resource $url.\n";
	print $res->message . "\n";
	exit;
    }
    
    my $json = $res->body;
    my $data = decode_json($json); 
    print "\n# Found " . scalar(@{$data->{'bugs'}}) . " items:\n";
    print map { 
	"  - " . $_->{'id'} . " [ " . $_->{'product'} . " ] " . $_->{'summary'} . ".\n" 
    } @{$data->{'bugs'}};


    # Write list of bugs to csv file.
    my $csv = Text::CSV->new({binary => 1, eol => "\n"});
    my $csv_out = join(',', @attrs) . "\n";
    
    foreach my $b ( @{$data->{'bugs'}} ) {
	my @bug = map { $b->{$_} } @attrs;
	$csv->combine( @bug );
	$csv_out .= $csv->string();
    }

    my $bugs_out_csv = "bugzilla_all_bugs.csv";    
    open my $fh_out, '>', $bugs_out_csv or die "Cannot write to file [$bugs_out_csv].\n";
    print $fh_out $csv_out;
    close $fh_out;

    # Fetch all comments.

    print "\n# Fetching comments for all bugs...\n";

    my @coms;
    foreach my $b ( @{$data->{'bugs'}} ) {
        print "  Fetching comments for bug " . $b->{'id'} . "...\n";
        my $url_comments = $url_base . "rest/bug/";
        $url = $url_comments . $b->{'id'} . "/comment";
        $res = $ua->get($url)->result;
        
        if (not $res->is_success) {
            print "Error: Could not get resource $url.\n";
            print $res->message . "\n";
            exit;
        }
        
        $json = $res->body;
        $data = decode_json($json);

        print "  Found " . scalar(@{$data->{'bugs'}{$b->{'id'}}{'comments'}}) . " comments.\n";
        my @bug_comments = map {
            $_->{'bug_id'} = "" . $b->{'id'}; $_;
        } @{$data->{'bugs'}{$b->{'id'}}{'comments'}};
        
        push( @coms, @bug_comments );
    }

    # Write list of comments to csv file.
    $csv = Text::CSV->new({binary => 1, eol => "\n"});
    $csv_out = join(',', @com_attrs) . "\n";
    
    foreach my $c ( @coms ) { 
	my @com = map { $c->{$_} } @com_attrs;
	$csv->combine( @com );
	$csv_out .= $csv->string();
    }

    my $comments_out_csv = "bugzilla_all_comments.csv";    
    open $fh_out, '>', $comments_out_csv or die "Cannot write to file [$comments_out_csv].\n";
    print $fh_out $csv_out;
    close $fh_out;
}

print "\n# Finished at " . localtime() . ". Have a good day! \n";

