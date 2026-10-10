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

Either way, one setting is needed, because this template keeps the website in
the `docs/` folder. You'll do that in step 6.

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

Check it worked. You should see `README.md`, `GETTING-STARTED.md`, `docs`,
`source`, and the other files:

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
2. Give it a note like `my laptop`, pick an expiration, and tick the **repo**
   box.
3. Click **Generate token** and copy it. GitHub only shows it once.
4. Back in Terminal, paste the token when git asks for your password. Nothing
   appears as you paste. That's normal. Press Enter.

Your Mac saves it in your Keychain, so you won't have to do this every time.

Reload your repo page on GitHub. Your files are there.

## 6. Turn on your website

1. In your repo on GitHub, click **Settings**, then **Pages** in the left menu.
2. Under **Build and deployment**, set **Source** to **Deploy from a branch**.
3. Under **Branch**, pick **main**, change the folder dropdown from `/ (root)`
   to **`/docs`**, then click **Save**.
4. Wait a minute or two. Click the **Actions** tab at the top of your repo
   to watch it publish. A green check means it's done.
5. Visit `https://<your-username>.github.io/`.

You should see the example portfolio with "Your Name" at the top. **That page
is live on the internet.** Anyone with the link can see it.

If you see a 404 page, wait another minute and reload. Double-check that the
Pages setting says `main` and `/docs`.

## 7. Make it yours

First, put your name on it. Open `docs/index.html` in a text editor (TextEdit
works, but a free code editor like [VS Code](https://code.visualstudio.com/)
is much nicer). Change `Your Name` and the tagline, and save.

To preview a page before you publish it, double-click the HTML file in Finder
to open it in your browser.

Then commit and push, the same pattern every time:

```sh
git add .
git commit -m "Put my name on the site"
git push
```

Reload your site after a minute to see the change.

### Adding a new art piece

1. **Save the original** in `source/art/`, full quality, for example
   `source/art/self-portrait.png`. This is the real thing, saved in git.
2. **Make the web copy:**
   ```sh
   ./resize-image.sh source/art/self-portrait.png
   ```
   This creates `docs/assets/img/self-portrait.jpg`, a smaller version that
   loads quickly.
3. **Make its page:** copy an existing art page, for example
   `docs/art-sunset.html`, to a new name like `docs/art-self-portrait.html`.
   Open it and change the title, the date, the image path
   (`assets/img/self-portrait.jpg`), the `alt` text (a short description of
   the picture for people who can't see it), and the description.
4. **Add it to the home page:** in `docs/index.html`, copy one of the
   `<a class="card"> ... </a>` blocks in the Art section, and change the link,
   image, and title to match.
5. **Add it to `content.yaml`:** copy a block and fill in the details.
6. **Commit and push:**
   ```sh
   git add .
   git commit -m "Add self-portrait"
   git push
   ```

### Adding a new piece of writing

1. **Save the original** as a text file in `source/writing/`, for example
   `source/writing/winter-story.md`.
2. **Make its page:** copy `docs/writing-morning-bus.html` (for poems, where
   line breaks matter) or `docs/writing-why-i-draw.html` (for prose, where each
   paragraph goes in `<p> ... </p>`). Paste in your text and change the title
   and date.
3. **Add a card** to the Writing section of `docs/index.html` with a short
   excerpt.
4. **Add it to `content.yaml`**, then commit and push like above.

### Removing the examples

When you have your own pieces, delete the example files (everything named
`example-...` and the example pages in `docs/`), remove their cards from
`docs/index.html` and their entries from `content.yaml`, then commit and push.
Don't worry, git still has them in your history if you ever want them back.

---

## How this template is put together (and why)

- **Two copies of every artwork.** The full-quality original lives in
  `source/`, safely versioned in git. The website in `docs/` only shows a
  smaller copy, so pages load fast. Your repo is public, so the originals can
  still be downloaded from GitHub. Keep anything private out of this repo.
- **The pages are written by hand.** Each page in `docs/` is a plain HTML file
  you edit directly. There's no tool that builds the site from a data file.
  That means a bit of copying and pasting when you add a piece, but nothing is
  hidden: what's in the file is exactly what's on the website, and you learn
  how HTML actually works.
- **`content.yaml` is a record, not a recipe.** The website doesn't read it.
  It's a tidy list of every piece, where its original lives, and where it's
  published, for you and anyone browsing your repo. If you later want to
  generate pages from it automatically, it's already in the right shape.
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
| GitHub Pages | GitHub's free website hosting, which publishes your `docs/` folder. |
