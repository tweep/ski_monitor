#!/usr/local/bin/env perl 

use strict;
use warnings;
use LWP::Simple;
use Getopt::Long;
use autodie; 
use JSON;  
use POSIX; 
use MyMonitor qw(get_file_name  save_content);
use MyMonitor::Config::General qw(RESORT_CONFIG) ; # config file 

print $RESORT_CONFIG->{heavenly}->{url} ."\n"; 
exit(0);

my $file_name = get_file_name("squawalpine"); 

my $url = "http://squawalpine.com/skiing-riding/weather-conditions-webcams/lift-grooming-status"; 

save_content( $file_name, $url ); 


# Connect to URL, write data to file
   # 
   # sub save_content { 
   #   my ($file, $url ) = @_;   
   # 
   #   my $content = get($url);  
   #   die "Couldn't get it!" unless defined $content;
   # 
   #   open (my $fh,">", $file) || die "Can't write to file\n"; 
   #    print $fh $content; 
   #   close($fh);  
   # 
   #   print STDERR "file $file written\n"; 
   # } 
   # 
   # 
   # sub get_file_name { 
   #   my ($name) = @_; 
   # 
   #   my $time = strftime("%Y-%m-%d %H:%M:%S", localtime(time)); 
   #   $time =~ s/\s+/\_\_/; 
   #   return $ENV{HOME}."/squaw_monitor/$name/$name"."_".$time.".txt";
   # }  
