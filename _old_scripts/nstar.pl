#!/usr/local/bin/env perl 

use strict;
use warnings 'all';
use LWP::Simple;
use Getopt::Long;
use autodie; 
use JSON;  

use POSIX; 

my $file_name = get_file_name("nstar"); 

my $url = "http://www.northstarcalifornia.com/the-mountain/terrain-status.aspx"; 

save_content( $file_name, $url ); 


# Connect to URL, write data to file

sub save_content { 
  my ($file, $url ) = @_;   

  my $content = get($url);  
  die "Couldn't get it!" unless defined $content;

  open (my $fh,">", $file) || die "Can't write to file\n"; 
   print $fh  $content; 
  close($fh);  

  print STDERR "file $file written\n"; 
} 


sub get_file_name { 
  my ($name) = @_; 

  my $time = strftime("%Y-%m-%d %H:%M:%S", localtime(time)); 
  $time =~ s/\s+/\_\_/;
  return $ENV{HOME}."/squaw_monitor/$name/$name"."_".$time.".txt"; 
}  
