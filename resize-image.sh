#!/bin/sh
#
# resize-image.sh - make a small, web-friendly copy of one of your images.
#
# WHY THIS EXISTS
#   Your original art in source/art/ stays at full quality: that's the "real
#   thing". It stays on your Mac only: source/ is listed in .gitignore, so git
#   never saves it or sends it to GitHub. Keep your own backup of it (iCloud
#   Drive, Google Drive, an external disk...). Big originals load slowly on a
#   website anyway, so the website shows a smaller, compressed copy from
#   assets/img/, and that copy is what git saves and GitHub publishes.
#   This script makes that copy for you. It's the one step GitHub can't do for
#   you: run it once each time you add a new piece of art.
#
# HOW TO USE IT (in Terminal, from the top folder of this repo)
#   ./resize-image.sh source/art/my-painting.png
#
#   That creates:  assets/img/my-painting.jpg
#
#   Then add the piece to the list in _data/art.yml (the script prints the
#   lines to paste in), and commit and push.
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
echo "Next: open _data/art.yml, paste these lines at the very bottom, and"
echo "change the title, date, category, description, and alt to match your piece."
echo "Keep the \"-\" at the left edge and the other lines indented by two spaces."
echo ""
echo "- title: My New Piece"
echo "  date: $(date +%Y-%m-%d)"
echo "  category: School Projects"
echo "  description: One sentence about it."
echo "  image: /$OUTPUT"
echo "  alt: A short description of the picture, for people who can't see it."
