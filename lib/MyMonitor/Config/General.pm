
=head1 NAME

MyMonitor::Config::General

=head1 SYNOPSIS

    use MyMonitor::Config::General; 

=head1 DESCRIPTION

General configuration file. 

The module will die if a variable which doesn\'t appear in its
C<%Config> hash is asked to be set.

The variables can also be references to arrays or hashes.

Edit C<%Config> to add or alter variables.

All the variables are in capitals, so that they resemble environment
variables.

=cut


package MyMonitor::Config::General;

use strict;
use vars qw(%Config);

%Config = (

  RESORT_CONFIG =>  { 
                       "heavenly" => {  
                                      resort_name => "heavenly",  
                                      url  => "http://www.skiheavenly.com/the-mountain/terrain-and-lift-status.aspx",
                        },  
                       "kwood" => {
                                      resort_name => "kwood", 
                                      url  => "http://www.kirkwood.com/mountain/terrain-status.aspx",
                       }, 
                       "nstar" => { 
                                     resort_name => "nstar", 
                                     url  => "http://www.northstarcalifornia.com/the-mountain/terrain-status.aspx",
                       }, 
                       "rose"  => { 
                                     resort_name => "rose", 
                                     url  => "http://skirose.com/the-mountain/snow-report",
                       },
                       "sbowl" => {
                                     resort_name => "sbowl", 
                                      url  => "http://www.sugarbowl.com/conditions", 
                        }, 
                        "squawalpine" => {
                                           resort_name => "squawalpine", 
                                           url  => "http://squawalpine.com/skiing-riding/weather-conditions-webcams/lift-grooming-status",
                                         },
                    },
    MAIN_DL_FOLDER => "value" ,

);



sub import {
  my ($callpack) = caller(0); # Name of the calling package
  my $pack = shift; # Need to move package off @_

  # Get list of variables supplied, or else all
  my @vars = @_ ? @_ : keys(%Config);
  return unless @vars;

  # Predeclare global variables in calling package
  eval "package $callpack; use vars qw("
         . join(' ', map { '$'.$_ } @vars) . ")";
  die $@ if $@;


  foreach (@vars) {
    if (defined $Config{ $_ }) {
      no strict 'refs';

      # Exporter does a similar job to the following
      # statement, but for function names, not
      # scalar variables:
      *{"${callpack}::$_"} = \$Config{ $_ };
    } else {
      die "Error: Config: $_ not known\n";
    }
  }
}

1;
