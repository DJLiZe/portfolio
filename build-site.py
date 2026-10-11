#!/usr/bin/env python3
"""
build-site.py - build the whole website from content.yaml.

WHAT IT DOES
  1. Reads the list of pieces in content.yaml.
  2. Makes a web-sized copy of each art image with resize-image.sh.
  3. Fills in the HTML templates in templates/ to make one page per piece,
     plus the home page.
  4. Puts the finished site in docs/, ready to publish.

WHO RUNS IT
  A GitHub Action (.github/workflows/publish.yml) runs it every time you push,
  then publishes docs/ to GitHub Pages. You never need to run it yourself,
  but you can, to preview your site before you push. In Terminal, from the top
  folder of this repo, on a Mac:

    python3 build-site.py
    open docs/index.html

  docs/ is rebuilt from scratch every time, so never edit files in it by hand:
  your changes would be wiped out. Edit content.yaml, source/, or templates/.
  (docs/ is listed in .gitignore, so git doesn't save it either.)

WHAT YOU NEED
  Python 3 and a Mac (for resize-image.sh). Both come with macOS. It only uses
  Python's built-in tools, so there is nothing to install.
"""

import html
import shutil
import subprocess
import sys
from datetime import date
from pathlib import Path
from string import Template

# Everything is found relative to this file, so it works from any folder.
ROOT = Path(__file__).resolve().parent
TEMPLATES = ROOT / "templates"
OUTPUT = ROOT / "docs"

MONTHS = ["January", "February", "March", "April", "May", "June", "July",
          "August", "September", "October", "November", "December"]


def stop(message):
    """Print a friendly error and stop. In GitHub Actions this shows up in the log."""
    print("Error: " + message, file=sys.stderr)
    sys.exit(1)


def read_content(path):
    """
    Read content.yaml.

    Real YAML is a big format. This reads just the simple shape content.yaml
    uses, so we don't need to install a YAML library:

        name: Your Name           <- a setting for the whole site
        pieces:                   <- the start of the list
          - title: Sunset         <- "- " starts a new piece
            type: art             <- more fields for that piece

    It gives back the site settings and a list of pieces. Each piece is a
    dictionary, like {"title": "Sunset", "type": "art", ...}.
    """
    site = {}
    pieces = []
    for number, line in enumerate(path.read_text(encoding="utf-8").splitlines(), start=1):
        text = line.strip()
        if text == "" or text.startswith("#"):
            continue  # blank lines and notes

        if text.startswith("- "):
            pieces.append({"line": number})  # "- " starts a new piece
            text = text[2:]

        if ":" not in text:
            stop(f"content.yaml line {number} should look like 'field: value', but it's: {line}")
        key, value = text.split(":", 1)
        key, value = key.strip(), value.strip()
        # Remove "quotes" around a value, if there are any.
        if len(value) >= 2 and value[0] == value[-1] and value[0] in "\"'":
            value = value[1:-1]

        if line.startswith((" ", "-")):
            # An indented line is a field of the piece that started above it.
            if not pieces:
                stop(f"content.yaml line {number} is indented, but no piece has started yet (pieces start with '- title:').")
            pieces[-1][key] = value
        elif key != "pieces":
            site[key] = value  # a whole-site setting, like name
    return site, pieces


def require(piece, field):
    """Get a field from a piece, or stop with a message saying which one is missing."""
    value = piece.get(field, "")
    if value == "":
        stop(f"the piece on content.yaml line {piece['line']} is missing '{field}:'.")
    return value


def pretty_date(text, piece):
    """Turn 2026-09-01 into "September 2026"."""
    try:
        when = date.fromisoformat(text)
    except ValueError:
        stop(f"the date '{text}' on content.yaml line {piece['line']} should look like 2026-09-01.")
    return f"{MONTHS[when.month - 1]} {when.year}"


def fill(template_name, values, html_parts=None):
    """
    Fill in a template from templates/. Every $word in the template is
    replaced by values["word"]. Values are made safe for HTML first, so a
    title like "Me & My Dog" can't break the page. html_parts are pieces of
    HTML this script already made (like the cards), so they go in as they are.
    """
    template = Template((TEMPLATES / template_name).read_text(encoding="utf-8"))
    safe = {key: html.escape(value) for key, value in values.items()}
    safe.update(html_parts or {})
    return template.substitute(safe)


def read_writing(path):
    """Read a writing file, skipping lines that start with "#" (headings and notes)."""
    lines = path.read_text(encoding="utf-8").splitlines()
    return "\n".join(line for line in lines if not line.startswith("#")).strip()


def writing_html(text, form):
    """Turn plain text into HTML: a poem keeps its line breaks, prose gets paragraphs."""
    if form == "poem":
        return f'    <div class="poem">{html.escape(text)}</div>'
    paragraphs = [p.strip() for p in text.split("\n\n") if p.strip()]
    return "\n\n".join(f"    <p>{html.escape(p)}</p>" for p in paragraphs)


def main():
    site, pieces = read_content(ROOT / "content.yaml")
    shared = {
        "name": site.get("name", "Your Name"),
        "tagline": site.get("tagline", ""),
        "year": str(date.today().year),
    }

    # Start from an empty docs/ folder, so pieces you removed disappear too.
    shutil.rmtree(OUTPUT, ignore_errors=True)
    (OUTPUT / "assets" / "img").mkdir(parents=True)
    (OUTPUT / "assets" / "css").mkdir(parents=True)
    shutil.copy(TEMPLATES / "style.css", OUTPUT / "assets" / "css" / "style.css")

    art_cards = []
    writing_cards = []

    for piece in pieces:
        kind = require(piece, "type")
        source = require(piece, "source")
        if not (ROOT / source).is_file():
            stop(f"can't find {source} (from content.yaml line {piece['line']}). Check the spelling and the folder.")

        # The page's name comes from the original's file name:
        # source/art/sunset.png becomes art-sunset.html.
        stem = Path(source).stem
        page = f"{kind}-{stem}.html"
        values = dict(shared,
                      title=require(piece, "title"),
                      date=pretty_date(require(piece, "date"), piece),
                      description=piece.get("description", ""),
                      source=source,
                      page=page)

        if kind == "art":
            # resize-image.sh is the same script you can run by hand. It
            # writes the small copy to docs/assets/img/<name>.jpg.
            subprocess.run(["./resize-image.sh", source], cwd=ROOT, check=True)
            values["image"] = f"assets/img/{stem}.jpg"
            values["alt"] = require(piece, "alt")
            (OUTPUT / page).write_text(fill("art.html", values), encoding="utf-8")
            art_cards.append(fill("card-art.html", values))

        elif kind == "writing":
            form = require(piece, "form")
            if form not in ("poem", "prose"):
                stop(f"'form:' on the piece at content.yaml line {piece['line']} should be poem or prose, not '{form}'.")
            text = read_writing(ROOT / source)
            values["excerpt"] = piece.get("excerpt") or text.splitlines()[0] + "..."
            page_html = fill("writing.html", values, {"text": writing_html(text, form)})
            (OUTPUT / page).write_text(page_html, encoding="utf-8")
            writing_cards.append(fill("card-writing.html", values))

        else:
            stop(f"'type:' on the piece at content.yaml line {piece['line']} should be art or writing, not '{kind}'.")

        print(f"Made {page}", flush=True)

    # The home page, with all the cards made above.
    home = fill("index.html", shared, {"art_cards": "\n".join(art_cards),
                                       "writing_cards": "\n".join(writing_cards)})
    (OUTPUT / "index.html").write_text(home, encoding="utf-8")
    print("Made index.html")
    print(f"Done: the site is in docs/ ({len(pieces)} pieces).")


main()
