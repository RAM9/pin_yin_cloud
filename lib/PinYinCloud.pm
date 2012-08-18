package PinYinCloud;
use Mojo::Base 'Mojolicious';
use lib 'lib';
use CCDictionary;

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  #  http://mojolicio.us/perldoc/Mojolicious/Guides/Growing#Application_class
  # dictionary in object form
  my $dict = CCDictionary->new;

  $self->helper(ccdict => sub { return $dict });

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#welcome');
  $r->get('/lookup')->to('dictionary#lookup');
}

1;
