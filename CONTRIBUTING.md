# Contributing content

The site is a Jekyll site. Content lives in plain Markdown files with a YAML
front-matter header (the block between `---` lines). You don't need to touch
any layout, include, or CSS file to add or edit content — just add/edit files
in the folders below, either locally or directly through GitHub's web file
editor, then open a pull request (or push to `main` if you have write access).

## Structure

Every page and every collection item exists **once per language**, as two
separate files sharing the exact same `permalink` — see examples below.
Never add an `/en/` prefix by hand: the `jekyll-polyglot` plugin adds it
automatically to every non-default-language page at build time, based on
that page's `lang` value. The language switcher in the header relies on
both files sharing the same permalink, so keep them in sync when you rename
a page.

## Adding a person (`_people/`)

1. Copy `_people/TEMPLATE.md` twice:
   - `your-name.it.md`
   - `your-name.en.md`
2. Fill in `title`, `role`, `order` (controls position in the list), and set
   `permalink` to `/people/your-name/` in **both** files.
3. Write a short bio in the body, below the closing `---`.

## Adding a research output (`_bibliography/research.bib`)

Unlike the other sections, Research is not written as Markdown files: it is
generated from the BibTeX file `_bibliography/research.bib` (by
`_plugins/bibtex_research.rb`). Add or edit an entry there — e.g. by
exporting it from Zotero — and both the Italian and English pages are built
automatically at `/research/<citekey>/`.

```bibtex
@inproceedings{rossi2025granular,
  author    = {Rossi, Mario and Bianchi, Anna},
  title     = {Title of the paper},
  booktitle = {Proceedings of the International Computer Music Conference},
  year      = {2025},
  month     = may,
  doi       = {10.1234/example},
  abstract  = {English abstract. Separate paragraphs with a blank line.}
}
```

- **Fields used:** `author` (or `editor`), `title`, `year` + optional
  `month` (or a BibLaTeX `date`), the venue (`journal`, `booktitle`,
  `publisher`, …), `doi` or `url`, and `abstract`. Entries without a year
  are skipped with a warning; a syntax error stops the build.
- **Not yet published:** add `pubstate = {accepted}` (or `submitted`,
  `inpress`, `forthcoming`) and the site shows a matching label next to the
  entry. Remove the field once the paper is out.
- **Abstract:** write it in English; it is shown as-is on both language
  versions of the page.
- **Authors:** write names exactly as in the person's `title` (or one of
  their `aliases`) so the publication appears on their profile. LaTeX
  accents such as `{\'e}` are converted automatically.
- **Citekey:** it becomes the URL, so don't change it once published.

## Adding a music production (`_productions/`)

Copy `_productions/TEMPLATE.md` into an `.it.md` / `.en.md` pair. Set
`composer`, `date`, and either `audio` (path to an audio file under
`assets/audio/`) or `video` (an embed snippet).

## Adding a news item / event (`_news/`)

Copy `_news/TEMPLATE.md` into an `.it.md` / `.en.md` pair with `title` and
`date`.

## Editing a fixed page (Home, The Programme, Contacts)

These are the `programme.it.md` / `programme.en.md` and `contacts.it.md` /
`contacts.en.md` files at the repository root — edit the body text directly.
The homepage (`index.it.html` / `index.en.html`) only holds the hero text and
card links, which come from `_data/it.yml` / `_data/en.yml`.

## UI text and navigation labels

Menu labels, the hero text, and footer text are not hardcoded in the
templates — they live in `_data/it.yml` and `_data/en.yml`. Edit those two
files to change wording without touching any layout.

## "Under construction" mode

`_config.yml` has an `under_construction: true` flag. While it's `true`,
every production build (the one GitHub Actions deploys) shows a single
"coming soon" page ([_layouts/maintenance.html](_layouts/maintenance.html))
at every URL, no matter how much real content exists in the repository.

Locally, `_config_dev.yml` overrides that flag to `false`, so
`bundle exec jekyll serve --config _config.yml,_config_dev.yml` always
renders the real site — this is how you preview work in progress before it's
public.

**To launch the real site**, change `under_construction` to `false` in
`_config.yml` and push to `main`.
