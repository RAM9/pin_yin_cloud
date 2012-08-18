#http://perldoc.perl.org/utf8.html
use utf8;

use strict;
use warnings;

#enable unicode print
binmode STDOUT, ":utf8";

use Lingua::ZH::CCDICT;


####
# Subroutines
###
sub displayPinYin {
  my ($pinyin) = @_;
  print "\n\t";
  if ($pinyin) {
    print "Pinyin Romanized Unicode: ["  . $pinyin->as_unicode() ."]". "| ";
    print "\n\t";
    print "Pinyin Romavized Syllable: ["  . $pinyin->syllable() ."]".  "| ";
    print "\n\t";
    print "Pinyin Romavized Ascii: ["  . $pinyin->as_ascii() ."]".     "| ";
  } else{
    print "Pinyin : [none]";
  }
}

sub displayItem {
  my ($item) = @_;
  # hash / associative array / map 
  # are a list of pairs 
  my %data = (
    "Unicode" , $item->unicode() || 'none',
    "Radical" , $item->radical() || 'none',
    "Index"   , $item->index()   || 'none',
    "English" , $item->english() || 'none'
  ); 
  while(my ($name, $value) = each(%data)) {
    print $name .": [". ($value) ."] | ";
  }
  displayPinYin($item->pinyin());
}
###
## END SUBROUTINES
###
#
#
#


my @array = (1,1,3); # array
my $array_length = @array; # list context becomes scalar => becomes length
print $array_length;
print "\n";



# literal UTF8
my $query_single = '一';

##
## Perl encoding / ordinals and unicode
##

my @unicode, my @hex, my $test;


##
## Single UTF8 Code-Point String scalar
##

$test = $query_single;
print "Length: " . (length $test) . "\n";
print "utf8 flag: " . utf8::is_utf8($test) . "\n";
print "single unicode character string scalar as ordinal:\n".ord($test)."\n";
print "single Unicode character string scalar in hex:\n".sprintf("%x",ord($test))."\n";

@unicode = (unpack('U*', $test));
print "Unicode code-point:\n@unicode\n";
print "Unicode code-point in hex:\n".sprintf("%x",@unicode)."\n";




# literal UTF8 
my $query_multiple = '女子';


##
## Multiple UTF8 Code-Point String scalar
##

$test = $query_multiple;
print "Length: " . (length $test) . "\n";
print "utf8 flag: " . utf8::is_utf8($test) . "\n";

@unicode = (unpack('U*', $test));
print "Unicode code-point:\n@unicode\n";
print "Unicode code-point in hex:\n";
foreach my $cp (@unicode) {
  print sprintf("%x",$cp) . " "
}
print "\n";


#
####
####
#
# Build a dictonary object 
#
###

my $dict = Lingua::ZH::CCDICT->new( storage => 'InMemory' );
#
# convert a single character string to an ordinal (numeric)
# and then to a character scalar value
my $char = chr(ord($query_single));



# 
# convert scalar multi-code point string into array of ordinal codepoints
# then run map  with proc that converts ordinal to char array
#
my @unicode_multi_codepoints = unpack("U*",$query_multiple);
my @multi_char = map { chr($_) } @unicode_multi_codepoints;


#
#  match unicode only supports entry of a list of character scalars
#  values
#
#  Esentially it expects a character version of  the  unicode character point as input
#
my $set = $dict->match_unicode($char);
#my $set = $dict->match_stroke_count(1); # return ResultSet object
# this returns result set cursor current position (0) initially
# i assumed it was the  size of results at first
#print "$set->count()."\n";


while(my $item = $set->next()) {
  # item is a ResultItem object
    displayItem($item);
    print "\n";
}

print "\n======= Multiple Unicode Code Points\n";
print @multi_char;
$set = $dict->match_unicode(@multi_char);

while(my $item = $set->next()) {
  # item is a ResultItem object
    displayItem($item);
    print "\n";
}

