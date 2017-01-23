package MyMonitor;

use strict;
use warnings; 
use LWP::Simple;
use POSIX; 


require Exporter; 

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(
                    check_config 
                    get_file_name  
                    print_all
                    save_content 
                   ); 


sub print_all { 
  my ($href) = @_;   

  print STDERR "Pleese use the -resort_name option to supply a resort\n"; 

  for ( keys %$href ) {  
     print "Resort: $_\n"; 
  } 
} 


=head  

  Checks if a variable / resort is configured in our main config file.

=cut 

sub check_config{
   my ($rn,$resort_name) = @_;

   if ( !defined $rn) {
      die("Resort with name $resort_name is not configured in MyMonitor::Config::General \n");
   }
}


=head  

  Saves the content of a URL to a file.

=cut 


sub save_content { 
  my ($file, $url ) = @_;   

  my $content = get($url);   

  die "Couldn't get it!" unless defined $content;

  open (my $fh,">:encoding(UTF-8)", $file) || die "Can't write to file\n"; 
  print $fh $content; 
  close($fh);  

  print STDERR "file $file written\n"; 
} 


=head  

  constructs the file name for a given 

=cut 

sub get_file_name { 
  my ($name) = @_; 

  my $time = strftime("%Y-%m-%d %H:%M:%S", localtime(time)); 
  $time =~ s/\s+/\_\_/; 
  return $ENV{HOME}."/squaw_monitor/$name/$name"."_".$time.".txt";
}  



