use Test::More tests => 5;
use Prima::Test qw(noX11);
use Prima::Application;

use strict;
use warnings;

my $sub_ref = \&set_flag;
reset_flag();
my $window = create_window();
my @xpm = (0,0);
my $c = $window-> insert( Widget =>
                     onCreate => $sub_ref,
                     onDestroy => $sub_ref,
                     onPostMessage => sub { set_flag(0); @xpm = ($_[1],$_[2])}
    );
ok($c);
ok(get_flag());
$c-> post_message("abcd", [1..200]);
$c-> owner( $::application);
$c-> owner( $window );
ok(&Prima::Test::wait);
ok($xpm[0] eq 'abcd' && @{$xpm[1]} == 200);
reset_flag();
$c-> destroy;
ok(get_flag());

done_testing();