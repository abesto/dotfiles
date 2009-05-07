use strict;
use Lyrics::Fetcher;
use Audio::MPD;

my $mpd = Audio::MPD->new;
my $song = $mpd->current();

my ($artist, $song) = ($song->artist(), $song->title());

open FH, '>lyrics' or die $!;

my $lyrics = Lyrics::Fetcher->fetch($artist, $song);
if ($lyrics eq "") {
    print FH "No lyrics found, sorry." or die $!;
} else {
    print FH $lyrics or die $!;
}
close FH or die $!;

system("zenity --text-info --filename=\"./lyrics\" --title=\"" . $song . " by " . $artist . " (lyrics)\"");
system("rm lyrics");
