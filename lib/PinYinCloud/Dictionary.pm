package PinYinCloud::Dictionary;
use strict;
use warnings;
use Mojo::Base 'Mojolicious::Controller';
#use utf8; #  this file is utf8
use Lingua::ZH::CCDICT;


# This action will render a template
sub lookup {
  my $self = shift;

  # helper ccdict is defined in the application class 'PinYinCloud.pm'
  # to be the CCDictionary 'model'
  my $resultsObject = $self->ccdict->lookup($self->param('unicode'));
  
  $self->render(json => $resultsObject);

}

1;
