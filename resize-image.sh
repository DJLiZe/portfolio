#!/bin/sh
#
# resize-image.sh - make a small, web-friendly copy of one of your images.
#
# WHY THIS EXISTS
#   Your original art in source/art/ stays at full quality: that's the "real
#   thing", safely saved in git. Big originals load slowly on a website,
#   though, so the website shows a smaller, compressed copy from assets/img/.
#   This script makes that copy for you. It's the one step GitHub can't do for
#   you: run it once each time you add a new piece of art.
#
# HOW TO USE IT (in Terminal, from the top folder of this repo)
#   ./resize-image.sh source/art/my-painting.png
#
#   That creates:  assets/img/my-painting.jpg
#
#   Then add a file for the piece in _art/ (the script prints what to put in
#   it), and commit and push both.
#
# WHAT YOU NEED
#   A Mac. It uses "sips", an image tool that comes with macOS, so there is
#   nothing to install.

# Stop right away if any command fails, instead of carrying on confused.
set -e

# The longest side of the web copy, in pixels. 1200 looks sharp on most
# screens and still loads quickly. Make it smaller for even faster pages.
MAX_SIZE=1200

# JPEG quality from 0 (tiny, ugly) to 100 (huge, perfect). 80 is a good balance.
QUALITY=80

# "$1" means "the first thing typed after the script name" - your image path.
SOURCE="$1"

# If no image was given, explain how to use the script and stop.
if [ -z "$SOURCE" ]; then
  echo "Usage: ./resize-image.sh source/art/your-image.png"
  exit 1
fi

# If the file doesn't exist (maybe a typo?), say so and stop.
if [ ! -f "$SOURCE" ]; then
  echo "Can't find the file: $SOURCE"
  exit 1
fi

# Work out the output name: keep the file name, drop the folder and the old
# extension, then add .jpg. "source/art/sunset.png" becomes "sunset.jpg".
NAME=$(basename "$SOURCE")
OUTPUT="assets/img/${NAME%.*}.jpg"

# Make sure the assets/img/ folder exists.
mkdir -p assets/img

# The actual work, in one sips command:
#   -Z $MAX_SIZE                 shrink so the longest side is at most MAX_SIZE
#   -s format jpeg               save as JPEG (small files, great for pictures)
#   -s formatOptions $QUALITY    the JPEG quality from above
#   --out "$OUTPUT"              where to write the copy (the original is untouched)
sips -Z "$MAX_SIZE" -s format jpeg -s formatOptions "$QUALITY" "$SOURCE" --out "$OUTPUT" > /dev/null

echo "Made $OUTPUT"
echo ""
echo "Next: make a file called _art/${NAME%.*}.md containing these lines,"
echo "and change the title, date, description, and alt to match your piece:"
echo ""
echo "---"
echo "title: My New Piece"
echo "date: $(date +%Y-%m-%d)"
echo "description: One sentence about it."
echo "image: /$OUTPUT"
echo "alt: A short description of the picture, for people who can't see it."
echo "---"
