---
published: false
# ---- Copy this file to add a new person. Delete this comment block. ----
# 1. Duplicate this file twice, once per language, e.g.:
#      mario-rossi.it.md   (lang: it, permalink: /people/mario-rossi/)
#      mario-rossi.en.md   (lang: en, permalink: /people/mario-rossi/)
#    Both files use the SAME permalink (no manual /en/ prefix) — the
#    jekyll-polyglot plugin adds the /en/ prefix automatically for every
#    non-default language at build time.
# 2. Fill in the fields below. `order` controls position in the listing
#    (lower = higher up); leave it out to sort last.
lang: it
title: "Nome Cognome"
role: coordinator | student | board   # chiave: determina la categoria in Persone
role_detail: "Qualifica opzionale (es. Docente di Composizione)"
gender: m | f   # opzionale: sceglie la forma grammaticale (Dottorando/Dottoranda, Coordinatore/Coordinatrice)
cycle: "XLI"            # solo dottorandi
topic: "Tema di ricerca"
supervisor: "Tutor"
affiliation: "Ente"
website: "https://example.org"   # opzionale
interests: ["Interesse 1", "Interesse 2"]   # opzionale
aliases: ["F. Vitucci", "Vitucci, Francesco"]   # opzionale: varianti del nome usate in authors/composer
order: 10
photo: /assets/images/people/example.jpg
links:
  - label: "Email"
    url: "mailto:nome.cognome@example.org"
  - label: "Sito personale"
    url: "https://example.org"
---

Biografia (testo libero, anche più paragrafi). Le pubblicazioni (collezione research, campo authors) e le produzioni (collezione productions, campo composer) che riportano esattamente il nome in `title` compaiono automaticamente.
