my $stage = 1;

package GumboJumboObject;
use vars qw(@ISA);
use Test::More;

use strict;
use warnings;

@ISA = qw(Prima::Object);

sub init
{
	my $self = shift;
	ok( $self, "init") if $stage == 1;
	my %profile = @_;
	%profile = $self-> SUPER::init( %profile);
	croak("test!") if $stage == 2;
	return %profile;
}


sub setup
{
	main::set_flag(0);
	$_[0]-> SUPER::setup;
}

sub done
{
	my $self = $_[0];
	$self-> SUPER::done;
	pass("done" );
}

package main;
use Prima::Test;
use Prima::Application;
use Test::More tests => 8;

use strict;
use warnings;

reset_flag();
my $o = GumboJumboObject-> create;
ok( $o, "create result" );
ok( $o-> alive, "alive" );
ok( set_flag(0), "method override" );
$o-> destroy;
ok( !$o-> alive, "destroy");
$stage++;
undef $o;
eval { $o = GumboJumboObject-> create; };
ok( !defined $o, "croak during init" );

done_testing();