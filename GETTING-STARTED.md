# Getting Started

This guide takes you from "never used git" to "my portfolio is live on the
web". Go in order. Each step builds on the one before it. Plan on about an
hour the first time.

You'll type commands into **Terminal**, the Mac app for typing commands.
Open it with Spotlight: press `Cmd + Space`, type `Terminal`, press Enter.
When a box below shows a command, type it (or paste it) into Terminal and
press Enter. Anything inside `< >` is a placeholder. Replace the whole thing,
brackets included, with your own value.

---

## 1. What are git and GitHub?

- **git** is a program that saves snapshots of a folder over time. Each
  snapshot is called a **commit**. You can always look back at, or return to,
  any earlier snapshot, so you never lose work.
- **GitHub** is a website that stores a copy of your git folder online (a
  **repository**, or "repo"). It can also publish a website straight from
  that repo, for free. That feature is called **GitHub Pages**.

So: git keeps the history on your computer, GitHub keeps a copy online and
turns it into a website.

Check that git is on your Mac:

```sh
git --version
```

If it prints a version number, you're set. If a window pops up offering to
install "command line developer tools", click **Install**, wait for it to
finish, then run the command again.

Tell git your name and email. They get attached to every commit you make.
Use the same email you'll use for GitHub:

```sh
git config --global user.name "<Your Name>"
git config --global user.email "<you@example.com>"
```

## 2. Create a GitHub account

1. Go to <https://github.com/signup> and sign up.
2. Choose your **username** carefully. It becomes part of your website
   address (`https://<your-username>.github.io`), so pick something you'd be
   happy to put on a college application.
3. Verify your email address when GitHub asks.

## 3. Create your repository

1. On GitHub, click the **+** in the top-right corner, then **New repository**.
2. For **Repository name**, type exactly: `<your-username>.github.io`,
   for example `alexsmith.github.io`. It must match your username exactly.
3. Set it to **Public**. Free GitHub Pages sites need a public repo.
4. **Leave every "Initialize this repository" option unchecked.** No README,
   no .gitignore, no license. You're bringing your own files.
5. Click **Create repository**.

**Why that exact name?** GitHub treats a repo named `<your-username>.github.io`
as your personal site and gives you the short address
`https://<your-username>.github.io/`. Any other repo name works too, but the
address has the repo name on the end
(`https://<your-username>.github.io/<repo-name>/`). For a first project, the
`username.github.io` name is the easy choice. The template works with either:
its links adjust themselves to wherever GitHub puts your site.

Either way, you'll switch GitHub Pages on once in your repo's Settings, in
step 6.

## 4. Get the repo on your computer and add this template

You were given this starter kit as a folder. It **isn't** your repo yet. It
becomes the first contents of the empty repo you just made. To do that, you'll
download (**clone**) your empty repo, then copy the starter files into it.

First, make a folder for your projects and go into it:

```sh
mkdir -p ~/Projects
cd ~/Projects
```

Clone your empty repo. GitHub will say you cloned an empty repository. That's
expected.

```sh
git clone https://github.com/<your-username>/<your-username>.github.io.git
cd <your-username>.github.io
```

Now copy the starter kit's files in. Replace `<path-to-starter-kit>` with
where the starter kit folder is. Tip: type the start of the command, then drag
the folder from Finder into the Terminal window and it fills in the path.

```sh
rsync -a --exclude .git <path-to-starter-kit>/ ./
```

(The `/` after the starter kit path matters: it means "copy what's *inside*
this folder". `--exclude .git` skips the starter kit's own hidden git history,
so your repo starts fresh with your history.)

Check it worked. You should see `README.md`, `GETTING-STARTED.md`,
`_config.yml`, `index.html`, `source`, and the other files:

```sh
ls -a
```

(`-a` shows everything, including the folders whose names start with `_` or
`.`, like `_art` and `_writing`.)

## 5. Your first commit and push

Commit means "save a snapshot". Push means "send my snapshots up to GitHub".

See what git notices. Everything shows up as new, untracked files:

```sh
git status
```

Stage everything (pick what goes in the next snapshot), then commit with a
message saying what you did:

```sh
git add .
git commit -m "Start my portfolio from the starter template"
```

Make sure your main branch is called `main`, then push it to GitHub:

```sh
git branch -M main
git push -u origin main
```

**Signing in to push.** The first time you push, git asks for your GitHub
username and a password. **GitHub doesn't accept your account password here.**
It needs a **personal access token** instead:

1. On GitHub, click your profile picture, then **Settings**, then
   **Developer settings** (at the bottom of the left menu), then
   **Personal access tokens**, then **Tokens (classic)**, then
   **Generate new token (classic)**.
2. Give it a note like `my laptop`, pick an expiration, and tick the
   **repo** box.
3. Click **Generate token** and copy it. GitHub only shows it once.
4. Back in Terminal, paste the token when git asks for your password. Nothing
   appears as you paste. That's normal. Press Enter.

Your Mac saves it in your Keychain, so you won't have to do this every time.

Reload your repo page on GitHub. Your files are there.

## 6. Turn on your website

Your site is built by **Jekyll**, the website builder that's part of GitHub
Pages. You don't install or run it: once Pages is on, GitHub rebuilds your
site by itself every time you push. You just need to switch Pages on, once.

1. In your repo on GitHub, click **Settings**, then **Pages** in the left menu.

   (Don't see **Settings**? It only appears for people who manage the repo.
   Switching Pages on the first time needs that admin access, so do this step
   from the account that owns the repo, or ask its owner to.)
2. Under **Build and deployment**, set **Source** to **Deploy from a branch**.
3. Under **Branch**, pick **main** and **/ (root)**, then click **Save**.

   **This is a change.** An earlier version of this guide said to pick
   **GitHub Actions** (and before that, the **`/docs`** folder). Don't. This
   template is built straight from the top folder of your repo now. If Source
   says "GitHub Actions", change it to "Deploy from a branch".
4. Wait a minute or two. You can watch it happen: click the **Actions** tab at
   the top of your repo, and you'll see a run called **pages build and
   deployment**. That's GitHub's own built-in builder, not something you set
   up. A green check means it's done.
5. Visit `https://<your-username>.github.io/` (or
   `https://<your-username>.github.io/<repo-name>/` if you used a different
   repo name).

You should see the example portfolio with "Your Name" at the top. **That page
is live on the internet.** Anyone with the link can see it.

If you see a 404 page, wait another minute and reload. Double-check that the
Pages Source says **Deploy from a branch**, with **main** and **/ (root)**.

## 7. Make it yours

From now on, every change follows the same four steps:

1. **Change your files:** a new file in `_writing/` or `_art/`, or a setting in
   `_config.yml`.
2. **Stage and commit:** `git add .` then `git commit -m "<what you did>"`.
3. **Push:** `git push`.
4. **Wait a minute or two,** then reload your site. GitHub rebuilds every page
   for you.

You never edit the website's pages one by one. (If a build fails, you'll get
an email from GitHub and a red X in the **Actions** tab. Click it to read the
error. It usually names the file and line to fix, often a missing `---` or a
`:` in a title that needs "quotes". Fix it, then commit and push again.)

First, put your name on it. Open `_config.yml` in a text editor (TextEdit
works, but a free code editor like [VS Code](https://code.visualstudio.com/)
is much nicer). Change `title:` (your name) and `description:` (a line about
you) near the top, and save. Then:

```sh
git add .
git commit -m "Put my name on the site"
git push
```

Reload your site after a minute or two to see the change.

### What's front matter?

Every piece is one file. At the top of the file, between two lines of three
dashes, are the piece's details. That's called **front matter**:

```
---
title: Morning Bus
date: 2026-09-10
description: A poem about the ride to school.
---
```

Each line is a name, a colon and a space, then the value. Dates are written
year-month-day. If a value has a colon and a space in it (like
`Part 1: Home`), wrap the whole value in "double quotes".

### Adding a new piece of writing

No extra steps: just one new file.

1. **Make a new file** in `_writing/`, for example `_writing/winter-story.md`.
   The file name becomes part of the page's address, so use lowercase letters
   and dashes, no spaces.
2. **Start it with front matter,** then write (or paste) your writing
   underneath:

   ```
   ---
   title: Winter Story
   date: 2026-12-01
   description: A short story about the first snow.
   form: prose
   ---
   The snow started at noon, which was the worst possible time...

   Leave a blank line between paragraphs.
   ```

   Set `form:` to `poem` to keep your line breaks exactly as typed (a blank
   line still starts a new stanza), or `prose` for ordinary paragraphs. The
   home page shows the first few words as a preview.
3. **Commit and push:**
   ```sh
   git add .
   git commit -m "Add winter story"
   git push
   ```

Copying one of the example files in `_writing/` and changing it is the easiest
way to start.

### Adding a new art piece

Art needs one extra step, because big image files make websites slow: you
make a small web copy first. It's one command.

1. **Save the original** in `source/art/`, full quality, for example
   `source/art/self-portrait.png`.
2. **Make the web copy:**
   ```sh
   ./resize-image.sh source/art/self-portrait.png
   ```
   That makes `assets/img/self-portrait.jpg`, and prints the front matter for
   the next step.
3. **Make a new file** in `_art/`, for example `_art/self-portrait.md`, and
   paste in what the script printed. Change the values. `image:` is the web
   copy the script made. `alt:` is a short description of the picture for
   people who can't see it.
4. **Commit and push** (this sends the original, the web copy, and the new
   file together):
   ```sh
   git add .
   git commit -m "Add self-portrait"
   git push
   ```

The piece gets its own page and a box on the home page by itself.

### Changing the colors

Open `_config.yml` and find the **COLORS** section. You never need to touch
any CSS.

**To switch themes,** change the word after `color_theme:` to one of
`default`, `dark`, `warm`, `ocean`, or `forest`:

```yaml
color_theme: ocean
```

**To change just one color,** keep your theme and remove the `# ` from the
start of one of the color lines below it, then put in your own hex color (a
`#` plus six letters or digits, in quotes). For example, the ocean theme with
purple links:

```yaml
color_theme: ocean
accent_color: "#7b2cbf"
```

`accent_color` is links and highlights, `background_color` is the page, and
`text_color` is the main text. A color you set here always wins over the
theme's color. To go back to the theme's color, put the `# ` back.

Commit and push, and the new colors are live after the next rebuild, a minute
or two later. (Want a whole theme of your own? Open `_data/themes.yml` and
follow the note at its top.)

### Changing how the site looks

The page designs are in `_layouts/` (`default.html` is the frame around every
page, `art.html` and `writing.html` are one piece's page) and `_includes/`
(the boxes on the home page). The home page itself is `index.html`. Words in
`{{ double braces }}` are blanks Jekyll fills in from `_config.yml` and from
each piece's front matter. Fonts and layout are in `assets/css/style.css`.

### Previewing before you push (optional)

You don't need to preview: pushing and reloading your site is the normal way
to check a change. If you'd like to see changes on your own Mac first, you
can install Jekyll later (search "Jekyll on macOS"). It's optional and takes
some setup, so skip it for now.

### Removing the examples

When you have your own pieces, delete the example files: everything named
`example-...` in `_art/`, `_writing/`, `assets/img/`, and `source/art/`. Then
commit and push. Their pages disappear from the site on the next build. Don't
worry, git still has them in your history if you ever want them back.

---

## How this template is put together (and why)

- **Two copies of every artwork.** The full-quality original lives in
  `source/art/`, safely versioned in git. The website only shows the smaller
  copy in `assets/img/`, so pages load fast. Your repo is public, so the
  originals can still be downloaded from GitHub. Keep anything private out of
  this repo.
- **The website is built, not hand-written.** You keep the real things (your
  pieces and `_config.yml`) in git. Jekyll, built into GitHub Pages, turns
  them into the website on every push. So adding a piece is one new file, and
  every page always matches what's in `_art/` and `_writing/`. The finished
  site is never saved in git, because it can always be rebuilt.
- **Only images need a manual step.** GitHub's builder can't resize images,
  so `resize-image.sh` does that once per new piece, on your Mac. Everything
  else is automatic.
- **Nothing hidden.** The layouts are ordinary HTML with a few blanks to fill
  in, and every file has notes explaining it. Open them and read them.
- **Served from the top folder.** GitHub Pages builds the site from the top
  folder of your `main` branch (the "/ (root)" setting). Folders starting with
  `_` are Jekyll's working files and don't appear on the site as-is, and
  `source/` and the guides are left out on purpose (see `exclude:` in
  `_config.yml`).
- **Very large files.** GitHub warns about files over 50 MB and rejects files
  over 100 MB. Most art scans and photos are well under that. If yours aren't,
  save a slightly smaller "master" copy in `source/`.

## Words you'll see

| Word | Meaning |
| --- | --- |
| repository (repo) | A project folder that git tracks. |
| commit | A saved snapshot of your files, with a message. |
| stage (`git add`) | Pick which changes go into the next commit. |
| push | Send your commits up to GitHub. |
| pull | Bring down commits from GitHub (useful if you edit on github.com or a second computer: run `git pull` first). |
| clone | Download a copy of a repo from GitHub. |
| branch | A line of history. You only need `main` for now. |
| GitHub Pages | GitHub's free website hosting. |
| Jekyll | The website builder built into GitHub Pages. It turns your files into web pages every time you push. |
| front matter | The lines between two `---` at the top of a file in `_art/` or `_writing/`: the piece's title, date, and other details. |
| hex color | A color written as `#` plus six letters or digits, like `#b5482a`. Any color picker on the web shows them. |
