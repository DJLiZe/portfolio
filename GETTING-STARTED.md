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
as your personal site. It switches GitHub Pages on automatically and gives you
the short address `https://<your-username>.github.io/`. Any other repo name
works too, but then you turn Pages on yourself in Settings, and the address
has the repo name on the end (`https://<your-username>.github.io/<repo-name>/`).
For a first project, the `username.github.io` name is the easy choice.

Either way, one setting is needed, to tell GitHub Pages that a GitHub Action
builds and publishes your site. You'll do that in step 6.

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
`content.yaml`, `source`, `templates`, and the other files:

```sh
ls
```

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
2. Give it a note like `my laptop`, pick an expiration, and tick two boxes:
   **repo** and **workflow**. (`workflow` lets you push the file in
   `.github/workflows/` that tells GitHub how to publish your site. Without
   it, GitHub refuses the push.)
3. Click **Generate token** and copy it. GitHub only shows it once.
4. Back in Terminal, paste the token when git asks for your password. Nothing
   appears as you paste. That's normal. Press Enter.

Your Mac saves it in your Keychain, so you won't have to do this every time.

Reload your repo page on GitHub. Your files are there.

## 6. Turn on your website

Your site is built and published by a **GitHub Action**: a small program
GitHub runs for you every time you push. The instructions for it are in
`.github/workflows/publish.yml`. You need to tell GitHub Pages to use it.

1. In your repo on GitHub, click **Settings**, then **Pages** in the left menu.
2. Under **Build and deployment**, set **Source** to **GitHub Actions**.

   **This is a change.** An earlier version of this guide said to pick
   **Deploy from a branch** and the **`/docs`** folder. Don't. This template
   no longer keeps a finished website in `docs/`; the Action builds it fresh
   each time. If Source already says "Deploy from a branch", change it.
3. Your first push happened before this setting existed, so run the Action
   once by hand: click the **Actions** tab at the top of your repo, click
   **Publish site** on the left, then **Run workflow**, then the green
   **Run workflow** button. (A red X on an earlier run is fine. That was the
   run from before Pages was set up.)
4. Wait a minute or two. A green check next to the run means it's done.
5. Visit `https://<your-username>.github.io/`.

You should see the example portfolio with "Your Name" at the top. **That page
is live on the internet.** Anyone with the link can see it.

If you see a 404 page, wait another minute and reload. Double-check that the
Pages Source says **GitHub Actions** and that the latest run in the Actions
tab has a green check.

## 7. Make it yours

From now on, every change follows the same four steps:

1. **Change your files:** originals go in `source/`, and every piece gets an
   entry in `content.yaml`.
2. **Stage and commit:** `git add .` then `git commit -m "<what you did>"`.
3. **Push:** `git push`.
4. **Wait a minute or two.** The Action makes web-sized copies of your
   images, builds every page, and publishes the site. Watch it in the
   **Actions** tab, then reload your site.

You never edit the website's HTML pages one by one, and there's nothing to
resize or copy into `docs/` by hand. (If a run gets a red X, click it to see
the error message. It usually names the line in `content.yaml` to fix. Fix
it, then commit and push again.)

First, put your name on it. Open `content.yaml` in a text editor (TextEdit
works, but a free code editor like [VS Code](https://code.visualstudio.com/)
is much nicer). Change `name:` and `tagline:` near the top, and save. Then:

```sh
git add .
git commit -m "Put my name on the site"
git push
```

Reload your site after a minute or two to see the change.

### Previewing before you push (optional)

You can build the site on your own Mac exactly the way the Action does:

```sh
python3 build-site.py
open docs/index.html
```

That opens your site in your browser, straight from your computer. The
`docs/` folder it makes is only a preview: git ignores it, and it's rebuilt
from scratch every time, so don't edit anything in it.

### Adding a new art piece

1. **Save the original** in `source/art/`, full quality, for example
   `source/art/self-portrait.png`.
2. **Add it to `content.yaml`:** copy one of the art blocks (from
   `- title:` down to `alt:`), paste it at the bottom, and change the values.
   `source:` is the path to your original, like
   `source/art/self-portrait.png`. `alt:` is a short description of the
   picture for people who can't see it.
3. **Commit and push:**
   ```sh
   git add .
   git commit -m "Add self-portrait"
   git push
   ```

The Action makes the web-sized copy, the piece's own page, and its card on
the home page.

### Adding a new piece of writing

1. **Save it** as a plain text file in `source/writing/`, for example
   `source/writing/winter-story.md`. Leave a blank line between paragraphs.
   Lines that start with `#` are treated as notes and left off the website.
2. **Add it to `content.yaml`:** copy one of the writing blocks and change the
   values. Set `form:` to `poem` to keep your line breaks exactly as typed, or
   `prose` for paragraphs. `excerpt:` is the short quote shown on the home
   page.
3. **Commit and push** like above.

### Changing how the site looks

The pages are built from the files in `templates/`: `index.html` for the
home page, `art.html` and `writing.html` for one piece's page, and the two
`card-...` files for the boxes on the home page. Words starting with `$`, like
`$title`, are blanks that get filled in from `content.yaml`. Colors, fonts,
and layout are in `templates/style.css`. Change them, preview, then commit
and push.

### Removing the examples

When you have your own pieces, delete the example files (everything named
`example-...` in `source/`) and remove their entries from `content.yaml`,
then commit and push. Their pages disappear from the site on the next build.
Don't worry, git still has them in your history if you ever want them back.

---

## How this template is put together (and why)

- **Two copies of every artwork.** The full-quality original lives in
  `source/`, safely versioned in git. The website only shows a smaller copy
  that the build makes, so pages load fast. Your repo is public, so the originals can
  still be downloaded from GitHub. Keep anything private out of this repo.
- **The website is built, not hand-written.** You keep the real things (your
  originals and `content.yaml`) in git. `build-site.py` turns them into the
  website, and the GitHub Action runs it on every push. So adding a piece is
  one new file plus a few lines in `content.yaml`, and every page always
  matches the list. The finished site is never saved in git, because it can
  always be rebuilt.
- **Nothing hidden.** `build-site.py` is a short Python file with notes
  explaining every step, and the templates are ordinary HTML. Open them and
  read them. The Action runs the same `resize-image.sh` you could run
  yourself, on a Mac, so what happens on GitHub is what happens on your
  computer.
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
| GitHub Action | A program GitHub runs for you when something happens, like a push. Yours builds and publishes your site. |
