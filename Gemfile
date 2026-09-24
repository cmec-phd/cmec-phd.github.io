source "https://rubygems.org"

gem "jekyll", "~> 4.3"
gem "jekyll-polyglot"
gem "jekyll-feed"
gem "jekyll-sitemap"

# Research collection is generated from _bibliography/research.bib
# (see _plugins/bibtex_research.rb)
gem "bibtex-ruby"
gem "latex-decode"

# Windows and JRuby does not include zoneinfo files, so bundle the tzinfo-data gem
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]

# Lock `http_parser.rb` gem to `v0.6.x` on JRuby builds
gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]
