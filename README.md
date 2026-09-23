# cmec-phd.github.io
Official website of the Computational Electroacoustic Music Composition, Generative Algorithmic Models and Computational Complexity PhD program — research, publications, projects, software, datasets, events, and doctoral activities.

## Stack

Jekyll site, bilingual (IT/EN) via [jekyll-polyglot](https://github.com/untra/polyglot), built and deployed to GitHub Pages by a GitHub Actions workflow ([.github/workflows/deploy.yml](.github/workflows/deploy.yml)).

While the site is being built, the deployed version at cmec-phd.github.io shows a "coming soon" page instead of the real content — see [CONTRIBUTING.md](CONTRIBUTING.md#modalità-in-costruzione--under-construction-mode) for how that works and how to turn it off when ready to launch.

## Local development

```bash
bundle install
bundle exec jekyll serve --config _config.yml,_config_dev.yml
```

Open http://localhost:4000 — this always shows the full, real site (Italian at `/`, English at `/en/`), regardless of the "under construction" flag used in production.

## Adding content

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to add People, Research, Productions and News entries.
