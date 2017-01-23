#!/usr/local/bin/env perl 

use strict;
use warnings;
use Getopt::Long;
use autodie; 
use MyMonitor qw(get_file_name print_all  save_content check_config);
use MyMonitor::Config::General qw(RESORT_CONFIG) ; # config file 

use Getopt::Long; 

unless ( @ARGV ) { exit print_all($RESORT_CONFIG) } ;  


my $resort_name; 
&GetOptions (
            'resort_name=s'       => \$resort_name,
        );




my $config = $RESORT_CONFIG->{$resort_name}; 
check_config($config, $resort_name); 

my $file_name = get_file_name($resort_name); 

my $url = $RESORT_CONFIG->{$resort_name}->{url}; 

save_content( $file_name, $url ); 

