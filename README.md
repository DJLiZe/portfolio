# Student Portfolio Starter

A starter kit for a personal portfolio website: your art and writing,
published free on the web with **GitHub Pages**.

It's for someone who has **never used git or GitHub before**. Setting it up
is the lesson: you'll create your own GitHub account and repository, make your
first commit, and see your site go live. Then you'll swap the example pieces
for your own work.

**Start here: [GETTING-STARTED.md](GETTING-STARTED.md)**

## How it works

You only ever edit your originals and one list. GitHub builds the website:

1. Put a new image in `source/art/` (or a new text file in `source/writing/`).
2. Add an entry for it to `content.yaml`.
3. Commit and push.
4. A **GitHub Action** (a small program GitHub runs for you) makes web-sized
   copies of your images, builds every page, and publishes the site. It's
   live a minute or two later.

## What's inside

| Path | What it holds |
| --- | --- |
| `source/art/` | Your original, full-quality art files. Kept safe in git. |
| `source/writing/` | The original text of your writing, as plain text files. |
| `content.yaml` | The list of every piece. The website is built from it. |
| `templates/` | The HTML pages with blanks to fill in, and `style.css` (colors, fonts, layout). |
| `build-site.py` | Builds the website from `content.yaml`, `source/`, and `templates/`. |
| `resize-image.sh` | Makes a web-sized copy of an image (on a Mac). `build-site.py` uses it. |
| `.github/workflows/publish.yml` | Tells GitHub to run `build-site.py` and publish the result on every push. |
| `docs/` | The finished website. Made fresh by every build, never edited by hand or saved in git. |

There's nothing to install. The build uses Python and an image tool that
both come with macOS, and the website itself is plain HTML and CSS.

## Growing it later

You can add other things next to the portfolio later without changing what's
already here. For example, a `code/` folder for programming projects, or a
`projects/` folder for other work. Only what `build-site.py` puts in `docs/`
gets published, so new folders stay out of the way until you link to them.
