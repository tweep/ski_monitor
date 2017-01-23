#!/usr/local/bin/env perl 

use strict;
use warnings;
use LWP::UserAgent;
use Getopt::Long;
use autodie; 
use JSON;  

use POSIX; 

my $file_name = get_file_name("rose"); 

my $url = "http://skirose.com/the-mountain/snow-report";

save_content( $file_name, $url ); 


# Connect to URL, write data to file

sub save_content { 
  my ($file, $url ) = @_;   

   system("wget $url -O $file"); 

  #open (O,">", $file) || die "Can't write to file\n"; 
  # print O $content; 
  #close(O);  

  print STDERR "file $file written\n"; 
} 


sub get_file_name { 
  my ($name) = @_; 

  my $time = strftime("%Y-%m-%d %H:%M:%S", localtime(time)); 
  $time =~ s/\s+/\_\_/;
  return $ENV{HOME}."/squaw_monitor/$name/$name"."_".$time.".txt"; 
}  
