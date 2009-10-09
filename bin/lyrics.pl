#!/usr/bin/perl
# Fetch (from the web), display, cache and modify lyrics for the current song
# played by MPD.
#
# Author: Zoltán Nagy <abesto0@gmail.com>
#
# Copyleft: It may kill your cat and throw it into a river with bricks attached
# to the legs, find out the gender of Great A'Tuin or pay your bills. Use and
# modify as you will, at your own risk.

use strict;
use Lyrics::Fetcher;
use Audio::MPD;

my $MUSIC_ROOT = get_music_directory();
my $TMP = "/tmp/lyrics";

my $mpd = Audio::MPD->new;
my $song_obj = $mpd->current();
my ($artist, $song) = ($song_obj->artist(), $song_obj->title());
my $title = $song . " by " . $artist;

our $lyrics = "";
our $file = $MUSIC_ROOT . $song_obj->file() . ".lyrics";

sub get_music_directory
{
    my $file = (-e "~/.mpdconf") ? "~/.mpdconf" : "/etc/mpd.conf";
    my $dir = `awk '/^music_directory/ {print \$2}' $file`;
    if (($dir eq "") && ($file eq "~/.mpdconf")) {
        $dir = `awk '/^music_directory/ {print \$2}' /etc/mpd.conf`;
    }
    if ($dir eq "") {
        print "Couldn't determine MPD music_directory. Exiting.";
        exit;
    }
    $dir =~ s/["\n]//g;
    return $dir."/";
}

sub cache
{
    open FH, '>', $main::file or die $!;
    print FH $main::lyrics or die $!;
    close FH or die $!;
}

sub log
{
    my $debug = 0; #Nice debug messages :)
    if ($debug) {
        print "Lyrics fetcher: " . @_[0];
    }
}

main::log "Started for " . $title ."\n";

if (-e $file) {
    main::log "Found in cache, displaying.\n";
    my $old = `cat "$file"`;
    $lyrics = `zenity --text-info --filename="$file" --title="$title (lyrics)" --editable`;
    if ($old ne $lyrics) {
        main::log "Lyrics changed, updating cache.\n";
        cache();
    }
} else {
    main::log "Lyrics not found in cache, fetching from web.\n";
    $lyrics = Lyrics::Fetcher->fetch($artist, $song, "LeosLyrics");

    open FH, '>', $TMP or die $!;
    print FH $lyrics or die $!;
    close FH or die $!;
    $lyrics = `zenity --text-info --filename="$TMP" --title="$title (lyrics)" --editable`;
    unlink($TMP);

    if ($lyrics eq "") {
        main::log "Lyrics not found, not caching.\n";
        main::log "Not caching.\n";
    } else {
        main::log "Lyrics found, saving to cache.\n";
        cache();
    }
}
main::log "Done.\n";
