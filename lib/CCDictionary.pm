package CCDictionary;
use utf8; #  this file is utf8
use Lingua::ZH::CCDICT;
use strict;
use warnings;
#use diagnostics;
#enable unicode print
#binmode STDOUT, ":utf8";

####
# Subroutines
###

sub jsonItem {
  my ($item) = @_;
  # hash / associative array / map 
  # are a list of pairs 
  my $data = {
    "unicode" => $item->unicode() || 'none',
    "radical" => $item->radical() || 'none',
    "english" => $item->english() || 'none',
  };

   if ($item->pinyin) {
     $data->{pinyin} = {
       'romanized' => {
         'unicode'  => $item->pinyin->as_unicode(),
         'ascii'    => $item->pinyin->as_ascii(),
         'syllable' => $item->pinyin->syllable()
       }
     };

   }
  return $data;
}
sub jsonResult {
  my ($set) = @_;
  my @itemsAsJson = ();

  while(my $item = $set->next()) {
    push(@itemsAsJson, jsonItem($item));
  }
  my $length = @itemsAsJson; 
  if ($length > 0) {
    return {
      'results' => [@itemsAsJson]
    };
  } else {
   return 0;
  };
}
###
## END SUBROUTINES
###

sub new { 
  bless {}, shift
}


my $dict = Lingua::ZH::CCDICT->new( storage => 'InMemory' );

sub lookup {
  my $self = shift;
  my ($query) = @_;

  my @unicode_multi_codepoints = unpack("U*",$query);
  my @multi_char = map { chr($_) } @unicode_multi_codepoints;

  my $set = $dict->match_unicode(@multi_char);
  my $result = jsonResult($set);
  if ($result) {
    return $result;
  } else {
    return {
      'error' => 1,
      'query' => $query,
      'unicode_multi_codepoints' => [@unicode_multi_codepoints],
      'multi_char' => [@multi_char]
    }
  }
  # return {'results' => [
  #         {
  #           'unicode' => '一',
  #           'english' => 'one; unit',
  #           'pinyin' => 
  #           {
  #             'romanized' => 
  #             {
  #               'unicode' => 'yī',
  #               'ascii' => 'yi1',
  #               'syllable' => 'yi1'
  #             }
  #           }
  #         }
  #       ]};
}
1;
