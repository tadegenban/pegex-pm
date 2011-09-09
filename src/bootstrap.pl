my $pegexlib;
BEGIN { $pegexlib = "$ENV{HOME}/src/pegex-pm/lib" }
use lib $pegexlib;
use strict;

use IO::All;

my $grammar = io("$pegexlib/Pegex/Grammar.pm")->all;
$grammar =~ s/.*?\npackage .*?\n//s or die;
$grammar =~ s/\n1;\n.*//s or die;
my $parser = io("$pegexlib/Pegex/Parser.pm")->all;
$parser =~ s/.*?\npackage .*?\n//s or die;
$parser =~ s/\n1;\n.*//s or die;
my $receiver = io("$pegexlib/Pegex/Receiver.pm")->all;
$receiver =~ s/.*?\npackage .*?\n//s or die;
$receiver =~ s/\n1;\n.*//s or die;

print <<"...";
# THIS FILE WAS GENERATED BY src/bootstrap.pl IN PEGEX DISTRIBUTION.

##
# name:      Pegex::Grammar::Bootstrap
# abstract:  Pegex Grammar Class (to Bootstrap TestML)
# author:    Ingy döt Net <ingy\@cpan.org>
# license:   perl
# copyright: 2010, 2011

package Pegex::Grammar::Bootstrap;
$grammar

BEGIN { \$INC{'Pegex/Parser.pm'} = 'inlined' }
package Pegex::Parser;
$parser

BEGIN { \$INC{'Pegex/Receiver.pm'} = 'inlined' }
package Pegex::Receiver;
$receiver

1;

=head1 DESCRIPTION

Pegex tests itself with TestML. TestML parses itself with Pegex. Bootstrapping
problem. This is the solution.

This is the copy of the Pegex Grammar runtime that TestML relies on. Otherwise
it is impossible to test changes to the runtime using the TestML tests.

This way we can use the last known good Pegex runtime with TestML to test new
changes to the runtime. When the new runtime is stable, then it gets moved to
here, and the TestML grammar gets recompiled and installed.
...
