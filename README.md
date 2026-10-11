# Student Portfolio Starter

A starter kit for a personal portfolio website: your art and writing,
published free on the web with **GitHub Pages**.

It's for someone who has **never used git or GitHub before**. Setting it up
is the lesson: you'll create your own GitHub account and repository, make your
first commit, and see your site go live. Then you'll swap the example pieces
for your own work.

**Start here: [GETTING-STARTED.md](GETTING-STARTED.md)**

## How it works

GitHub Pages has a website builder called **Jekyll** built in. Every time you
push, it turns the files in this repo into your website by itself. There's no
build script or workflow file to look after.

- **Writing:** add a text file to `_writing/`, commit, push. Done.
- **Art:** run `./resize-image.sh` once on your new image (it makes a small
  web copy), add a short file to `_art/`, commit, push. That one command is
  the only manual step.
- **Colors:** change `color_theme:` in `_config.yml` to `default`, `dark`,
  `warm`, `ocean`, or `forest`, or set a single color like `accent_color:`.
  No CSS needed.

The site is live a minute or two after each push.

## What's inside

| Path | What it holds |
| --- | --- |
| `_config.yml` | Your name, your tagline, and your color theme. The main file you edit. |
| `_art/` | One short file per art piece: title, date, description, and which image to show. |
| `_writing/` | One file per piece of writing: a few details at the top, then the writing itself. |
| `assets/img/` | The small web copies of your art, made by `resize-image.sh`. |
| `source/art/` | Your original, full-quality art files. Kept safe in git, not shown on the site. |
| `resize-image.sh` | Makes a web-sized copy of an image (on a Mac) and puts it in `assets/img/`. |
| `index.html` | The home page. Lists every piece in `_art/` and `_writing/`. |
| `_layouts/`, `_includes/` | The page designs Jekyll fills in for each piece. |
| `_data/themes.yml` | The colors for each theme. Add your own theme here if you like. |
| `assets/css/style.css` | Fonts and layout. Colors come from `_config.yml`, so you don't need to edit this. |

There's nothing to install. GitHub builds the site, and `resize-image.sh`
uses an image tool that comes with macOS.

## Growing it later

You can add other things next to the portfolio later. Any new page you add
(an `about.md` with a `layout: default` line at the top, for example) becomes
part of the site, and a new collection like `_projects/` can be added in
`_config.yml` the same way `_art/` and `_writing/` are.
