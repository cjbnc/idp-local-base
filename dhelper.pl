#!/usr/bin/perl
use Data::Dumper;
$Data::Dumper::Indent   = 1;
$Data::Dumper::Sortkeys = 1;
use Getopt::Std qw(getopts);
use JSON;
use Time::Local qw(timegm);

my $REGISTRY = 'web01dock.unity.ncsu.edu:5000';

# get options from command line
my %opt = ();
getopts( 'hlv', \%opt );
Usage() if ( $opt{h} );
my $VERBOSE = $opt{v};
my $LATEST  = $opt{l};

sub Usage {
    die <<EOF;
Usage: $0 [options] action image
Actions:
    login       setup login credential cache
    load        load image from registry
    save        save image to registry
    stamp       get build timestamp for image
Options:
    -h          show this help
    -l          set latest tag on this image
    -v          verbose messages
EOF
}

my $action = shift || '';
my $image  = shift || '';
if ( $action eq 'login' ) {
    exec "docker login $REGISTRY";
}
elsif ( $action eq 'save' ) {
    save_image($image);
}
elsif ( $action eq 'load' ) {
    load_image($image);
}
elsif ( $action eq 'stamp' ) {
    get_stamp($image);
}
else {
    print STDERR "Unknown action: '$action'\n";
    Usage();
}
exit;

sub get_stamp {
    my $img = shift;

    my $imginfo = inspect_image($img);
    die "Image not found: $img\n" if ( !$imginfo );
    my $cdate = from_gmtime( $imginfo->{Created} );
    print "$cdate\n";
}

sub save_image {
    my $img = shift;

    my $imginfo = inspect_image($img);
    die "Image not found: $img\n" if ( !$imginfo );

    my ( $name, $tag ) = split /:/, $img;
    if ( $img =~ /\A[0-9a-f]+\z/i ) {

        undef $name, $tag;

        # gave us a raw imageid, look up the tags
        foreach my $rtag ( @{ $imginfo->{RepoTags} } ) {
            next if ( $rtag =~ /\A$REGISTRY/i );
            ( $name, $tag ) = split /:/, $rtag;
            last;
        }
    }
    my $cdate = from_gmtime( $imginfo->{Created} );
    debug("Found image $name:$tag created $cdate");

    # tag and save the local image with create stamp
    my $newtag = $name . ':' . $cdate;
    docker( 'tag', $img, $newtag ) if ( $newtag ne $img );
    my $regtag = $REGISTRY . '/' . $newtag;
    docker( 'tag', $img, $regtag );
    docker( 'push', $regtag );

    # repeat with latest tag, if requested
    if ($LATEST) {
        $newtag = $name . ':' . 'latest';
        docker( 'tag', $img, $newtag ) if ( $newtag ne $img );
        $regtag = $REGISTRY . '/' . $newtag;
        docker( 'tag', $img, $regtag );
        docker( 'push', $regtag );
    }
}

sub load_image {
    my $img = shift;

    debug("Trying to load $img from registry");
    my $regtag = $REGISTRY . '/' . $img;
    docker( 'pull', $regtag );

    # now inspect it
    my $imginfo = inspect_image($regtag);
    die "Loaded image not found: $regtag\n" if ( !$imginfo );

    my ( $name, $tag ) = split /:/, $img;
    if ( $img =~ /\A[0-9a-f]+\z/i ) {

        undef $name, $tag;

        # gave us a raw imageid, look up the tags
        foreach my $rtag ( @{ $imginfo->{RepoTags} } ) {
            next if ( $rtag =~ /\A$REGISTRY/i );
            ( $name, $tag ) = split /:/, $rtag;
            last;
        }
    }
    my $cdate = from_gmtime( $imginfo->{Created} );
    debug("Found image $name:$tag created $cdate");

    # re-tag in the local repo
    my $newtag = $name . ':' . $cdate;
    docker( 'tag', $regtag, $newtag );

    # repeat with latest tag, if requested
    if ( $LATEST || $tag eq 'latest' ) {
        $newtag = $name . ':' . 'latest';
        docker( 'tag', $regtag, $newtag );
    }
}

sub inspect_image {
    my $img  = shift;
    my $json = JSON->new;

    debug("docker inspect $img");
    my $data = `docker inspect $img`;
    return if ( !$data );
    my $decode = $json->decode($data);
    return if ( !$decode );
    return $decode->[0];    # always an array of one element?
}

sub from_gmtime {
    my $str = shift;

    # 2016-09-12T13:55:15.735358598Z
    # 0    1  2  3  4  5  6
    my @p = split /\D+/, $str;
    my $ut = timegm( @p[ 5, 4, 3, 2 ], $p[1] - 1, $p[0] - 1900 );
    @p = localtime($ut);
    return sprintf "%02d%02d%02d%02d%02d",
        $p[5] % 100, $p[4] + 1, $p[3], $p[2], $p[1];
}

sub docker {
    my @opts = @_;
    my $opts = join ' ', @opts;

    debug("docker $opts");
    system( 'docker', @opts );
}

sub debug {
    my $msg = shift;
    return if ( !$VERBOSE );
    my @lt = localtime();
    printf STDERR "[%02d:%02d:%02d] %s\n", @lt[ 2, 1, 0 ], $msg;
}
