# Student Portfolio Starter

A starter kit for a personal portfolio website: your art, shown on one
simple page and published free on the web with **GitHub Pages**.

It's for someone who has **never used git or GitHub before**. Setting it up
is the lesson: you'll create your own GitHub account and repository, make your
first commit, and see your site go live. Then you'll swap the example pieces
for your own work.

**Start here: [GETTING-STARTED.md](GETTING-STARTED.md)**

## How it works

GitHub Pages has a website builder called **Jekyll** built in. Every time you
push, it turns the files in this repo into your website by itself. There's no
build script or workflow file to look after.

- **Art:** run `./resize-image.sh` once on your new image (it makes a small
  web copy), add a few lines for it to `_data/art.yml`, commit, push. That one command is
  the only manual step. The home page shows every piece (image, title, date,
  description) on one page, grouped into sections by each piece's
  `category:` (like Mosaics or Cards).
- **Colors:** change `color_theme:` in `_config.yml` to `default`, `dark`,
  `warm`, `ocean`, or `forest`, or set a single color like `accent_color:`.
  No CSS needed.

The site is live a minute or two after each push.

## What's inside

| Path | What it holds |
| --- | --- |
| `_config.yml` | Your name, your tagline, and your color theme. The main file you edit. |
| `_data/art.yml` | The list of your art pieces, a few lines each: title, date, category, description, and which image to show. |
| `assets/img/` | The small web copies of your art, made by `resize-image.sh`. |
| `source/art/` | Your original, full-quality art files. On your Mac only: ignored by git (see `.gitignore`), so never uploaded. Back them up yourself. |
| `resize-image.sh` | Makes a web-sized copy of an image (on a Mac) and puts it in `assets/img/`. |
| `index.html` | The home page, and the only page. Shows every piece in `_data/art.yml`. |
| `_layouts/`, `_includes/` | The page frame, and the box drawn for each piece on the home page. |
| `_data/themes.yml` | The colors for each theme. Add your own theme here if you like. |
| `assets/css/style.css` | Fonts and layout. Colors come from `_config.yml`, so you don't need to edit this. |
| `assets/js/lightbox.js` | Lets visitors click a picture to see all of it, bigger. Works for every piece by itself. |

There's nothing to install. GitHub builds the site, and `resize-image.sh`
uses an image tool that comes with macOS.

## Growing it later

You can add other things next to the portfolio later. Any new page you add
(an `about.md` with a `layout: default` line at the top, for example) becomes
part of the site, and a new list like `_data/projects.yml` (or a writing
section, which is switched off for now) can be added the same way
`_data/art.yml` is.
