#!/usr/local/bin/env perl 

use strict;
use warnings;
use LWP::Simple;
use Getopt::Long;
use autodie; 
use JSON;  

use POSIX; 

my $file_name = get_file_name("kwood"); 

my $url = "http://www.kirkwood.com/mountain/terrain-status.aspx"; 

save_content( $file_name, $url ); 


# Connect to URL, write data to file

sub save_content { 
  my ($file, $url ) = @_;   

  my $content = get($url);  
  die "Couldn't get it!" unless defined $content;

  open (O,">", $file) || die "Can't write to file\n"; 
   print O $content; 
  close(O);  

  print STDERR "file $file written\n"; 
} 


sub get_file_name { 
  my ($name) = @_; 

  my $time = strftime("%Y-%m-%d %H:%M:%S", localtime(time)); 
  $time =~ s/\s+/\_\_/;
  return $ENV{HOME}."/squaw_monitor/$name/$name"."_".$time.".txt";
}  
