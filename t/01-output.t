#!/usr/bin/env perl

use strict;
use warnings;
use lib 't/lib';
use Test::More 'no_plan';

use Catalyst::Test 'TestApp';

my $control = eval <<'EOF';
{
'About us' => {
                'children' => {},
                'menutitle' => 'About us',
                'uri' => bless( do{\(my $o = 'http://localhost/about/us')}, 'URI::http' )
              },
'Foo' => {
           'children' => {
                           'Bar' => {
                                      'children' => {},
                                      'menutitle' => 'A foo bar',
                                      'uri' => '/foobar'
                                    }
                         }
         },
'Main' => {
            'children' => {
                            'Public' => {
                                          'children' => {},
                                          'menutitle' => 'A public function',
                                          'uri' => bless( do{\(my $o = 'http://localhost/public')}, 'URI::http' )
                                        }
                          }
          }
};
EOF

my $res = request('/');
my $tree;
eval $res->content;

ok(eq_hash($control, $tree), 'fetch expected data structure');
