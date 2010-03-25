use 5.008;
use strict;
use warnings;

package Dist::Zilla::Plugin::FatPacker;

# ABSTRACT: pack your dependencies onto your script file
use Moose;
with 'Dist::Zilla::Role::FileMunger';

sub munge_file {
    my ($self, $file) = @_;
    my $content = $file->content;
    $content =~ s/.*__FATPACK__/`$^X -e 'use App::FatPacker -run_script' file`/e;
    $file->content($content);
}
__PACKAGE__->meta->make_immutable;
no Moose;
1;

=pod

=for test_synopsis
1;
__END__

=head1 SYNOPSIS

In C<dist.ini>:

    [FatPacker]

=head1 DESCRIPTION

This plugin uses L<App::FatPacker> to pack your dependencies onto your script
file.

=function munge_file

Looks for a C<__FATPACK__> marker and replaces the line it occurs in with the
packed dependencies. A good way of using this is in a comment line:

    #!/usr/bin/env perl
    # __FATPACK__
    use strict;
    use warnings;
    use Foo::Bar;
    use Hoge::Hoge;

=cut
