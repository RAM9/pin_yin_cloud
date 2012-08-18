use Mojo::Base -strict;

use Test::More tests => 22;
use Test::Mojo;

my $t = Test::Mojo->new('PinYinCloud');

# Single 
#
$t = $t->get_ok('/lookup/' => {'unicode' => '一'})->status_is(200);

$t->json_is('/results/0/unicode' => '一');
$t->json_is('/results/0/radical' => '1');
$t->json_is('/results/0/english' => 'one; unit');
$t->json_is('/results/0/pinyin/romanized/ascii' => 'yi1');
$t->json_is('/results/0/pinyin/romanized/unicode' => 'yī');
$t->json_is('/results/0/pinyin/romanized/syllable' => 'yi1');

# Multiple
#
#女子English: [woman; female] | Unicode: [女] | Index: [none] | Radical: [38] | 
#Pinyin Romanized Unicode: [rǔ]| 
#Pinyin Romavized Syllable: [ru3]| 
#Pinyin Romavized Ascii: [ru3]| 
#
#English: [offspring; child; son] | Unicode: [子] | Index: [none] | Radical: [39] | 
#Pinyin Romanized Unicode: [zǐ]| 
#Pinyin Romavized Syllable: [zi3]| 
#Pinyin Romavized Asciiii: [zi3]| 
#
$t = $t->get_ok('/lookup/' => {'unicode' => '女子'})->status_is(200);


# 女
$t->json_is('/results/0/unicode' => '女');
$t->json_is('/results/0/radical' => '38');
$t->json_is('/results/0/english' => 'woman; female');
$t->json_is('/results/0/pinyin/romanized/ascii' => 'ru3');
$t->json_is('/results/0/pinyin/romanized/unicode' => 'rǔ');
$t->json_is('/results/0/pinyin/romanized/syllable' => 'ru3');


#子
$t->json_is('/results/1/unicode' => '子');
$t->json_is('/results/1/radical' => '39');
$t->json_is('/results/1/english' => 'offspring; child; son');
$t->json_is('/results/1/pinyin/romanized/ascii' => 'zi3');
$t->json_is('/results/1/pinyin/romanized/unicode' => 'zǐ');
$t->json_is('/results/1/pinyin/romanized/syllable' => 'zi3');


