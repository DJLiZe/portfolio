#!/bin/sh
#
# resize-all.sh - make web copies of EVERY image in a folder, in one go.
#
# WHY THIS EXISTS
#   resize-image.sh handles one image at a time, which is perfect when you add
#   a new piece. If you already have a pile of art to bring in, running it
#   once per file gets tedious. This script runs resize-image.sh for you on
#   every image in a folder. It doesn't resize anything itself: all the real
#   work still happens in resize-image.sh, so there's only one place to change
#   how images are resized.
#
# HOW TO USE IT (in Terminal, from the top folder of this repo)
#   ./resize-all.sh                       uses source/art/
#   ./resize-all.sh source/art/batch1/    uses a folder you choose
#
#   For each image it makes a copy in assets/img/ and prints the lines to
#   paste into _data/art.yml, just like resize-image.sh does.
#
# WHAT COUNTS AS AN IMAGE
#   Files ending in .png, .jpg, .jpeg or .heic (capital letters are fine too).
#   Hidden files (names starting with ".") and anything inside sub-folders
#   are skipped.

# Stop right away if any command fails, instead of carrying on confused.
set -e

# "${1:-source/art}" means "the first thing typed after the script name, or
# source/art if nothing was typed".
FOLDER="${1:-source/art}"

# If the folder doesn't exist (maybe a typo?), say so and stop.
if [ ! -d "$FOLDER" ]; then
  echo "Can't find the folder: $FOLDER"
  echo "Check the spelling, or run it with no folder to use source/art/."
  exit 1
fi

# Make a list of the images, one per line, in a temporary file.
#   -maxdepth 1      only look directly in the folder, not in sub-folders
#   -type f          only files, not folders
#   ! -name '.*'     skip hidden files
#   -iname           match the extension, ignoring capital letters
LIST=$(mktemp)
# Delete the temporary list when the script ends, however it ends.
trap 'rm -f "$LIST"' EXIT

find "$FOLDER" -maxdepth 1 -type f ! -name '.*' \
  \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.heic' \) \
  | sort > "$LIST"

# If the list is empty, there's nothing to do: say so and stop.
if [ ! -s "$LIST" ]; then
  echo "No images found in: $FOLDER"
  echo "Put .png, .jpg, .jpeg or .heic files in it, then run this again."
  exit 1
fi

# Go through the list one line (one image) at a time. Quoting "$IMAGE"
# keeps file names with spaces in one piece.
COUNT=0
while IFS= read -r IMAGE; do
  echo "=== $IMAGE ==="
  ./resize-image.sh "$IMAGE"
  echo ""
  COUNT=$((COUNT + 1))
done < "$LIST"

echo "Resized $COUNT images."
