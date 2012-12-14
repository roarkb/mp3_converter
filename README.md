mp3_converter
=============

DESCRIPTION:
this is an mp3 conversion wrapper that uses the "LAME" audio conversion tool to find and convert 
any uncompressed files in your music library to high quality mp3's as well as preserve their id3 
info if they have it

SETUP:
1. install taglib: http://robinst.github.com/taglib-ruby/
2. install LAME and make sure it's in your path: http://lame.sourceforge.net/

USING IT:
1. specify which file extensions you want it to find and convert in the FORMATS array in 
get_uncompressed_songs.rb.  the default is aif, aiff, wav, WAV (it is case sensitive)

2. run './get_uncompressed_songs.rb <full path to music directory>'
this will recursively retrieve all files with the above specified extensions and save them to
uncompressed.txt (look it over before proceeding)

3. run './convert_to_mp3.rb'
this will convert each song in uncompressed.txt to high quality mp3 preserving any id3 info it might
have then if it succeeds it will delete its uncompressed twin.  if it does not succeed it will abort
and let you work out the conflict

TROUBLESHOOTING:
apologies, this script is not perfect but it is cautious.  it will fail to convert some files with 
special characters in the name.  in that event the script will abort without deleting the original
file.  to skip the file simply search for the offending file in uncompressed.txt, delete it and
everything above it then resume the conversion.  at the end of the entire run you can re-run
get_uncompressed_songs.rb to find all skipped songs and convert them by hand