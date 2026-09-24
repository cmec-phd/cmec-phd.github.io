# Builds the `research` collection from a BibTeX file instead of Markdown
# files in _research/. Every entry becomes one document per site language,
# all sharing the permalink /research/<citekey>/, with the same front matter
# the layouts already use (title, date, authors, link, link_label) plus
# `venue`, `bibtype` and `pubstate` (BibLaTeX publication state, e.g.
# "accepted", labelled via `research.pubstate` in _data/<lang>.yml). The `abstract` field becomes the page body; it is
# written in English, so `content_lang: en` is set on every document.
#
# The file is `_bibliography/research.bib` unless `research_bibliography` is
# set in _config.yml.
#
# Runs as a :post_read hook at :high priority so the documents exist before
# jekyll-polyglot's own :post_read hook coordinates languages, exactly as if
# they had been read from disk. The maintenance generator still clears them
# later when `under_construction` is true.
require "bibtex"
require "latex/decode"

module CmecPhd
  class BibtexResearch
    DEFAULT_PATH = "_bibliography/research.bib"
    CONTENT_LANG = "en"
    VENUE_FIELDS = %i[journal booktitle publisher school institution howpublished].freeze

    def initialize(site)
      @site = site
      @collection = site.collections["research"]
      @path = File.expand_path(site.config["research_bibliography"] || DEFAULT_PATH, site.source)
    end

    def generate
      return unless @collection
      return Jekyll.logger.warn("BibTeX:", "#{@path} not found, research is empty") unless File.exist?(@path)

      entries.each do |entry|
        data = front_matter(entry)
        next unless data

        languages.each { |lang| @collection.docs << document(entry, data, lang) }
      end
      @collection.docs.sort!
    end

    private

    def entries
      bib = BibTeX.parse(File.read(@path, encoding: "utf-8"), strip: false)
      errors = bib.errors
      raise "BibTeX: cannot parse #{@path}: #{errors.map(&:content).join('; ')}" unless errors.empty?

      bib.replace
      bib.convert(:latex)
      bib.entries.values
    end

    def languages
      ([@site.config["default_lang"]] + Array(@site.config["languages"])).compact.uniq
    end

    def front_matter(entry)
      date = entry_date(entry)
      unless date
        Jekyll.logger.warn("BibTeX:", "skipping #{entry.key}: no year/date")
        return
      end

      data = {
        "title"   => clean(entry[:title]),
        "date"    => date,
        "authors" => names(entry[:author] || entry[:editor]),
        "venue"   => VENUE_FIELDS.map { |f| clean(entry[f]) }.find { |v| !v.empty? },
        "bibtype" => entry.type.to_s,
        "pubstate" => clean(entry[:pubstate]).downcase,
        "citekey" => entry.key.to_s,
      }
      if entry.has_field?(:doi)
        data["link"] = "https://doi.org/#{clean(entry[:doi]).sub(%r{\Ahttps?://(dx\.)?doi\.org/}, '')}"
        data["link_label"] = "DOI"
      elsif entry.has_field?(:url)
        data["link"] = clean(entry[:url])
      end
      data.reject { |_, v| v.nil? || v == "" }
    end

    def document(entry, data, lang)
      slug = Jekyll::Utils.slugify(entry.key.to_s)
      path = File.join(@collection.directory, "#{slug}.#{lang}.md")
      doc = Jekyll::Document.new(path, site: @site, collection: @collection)
      doc.merge_data!(@site.frontmatter_defaults.all(doc.relative_path, :research), source: "front matter defaults")
      doc.merge_data!(data.merge(
        "lang"               => lang,
        "content_lang"       => CONTENT_LANG,
        "permalink"          => "/research/#{slug}/",
        "slug"               => slug,
        "render_with_liquid" => false
      ), source: path)
      doc.content = entry[:abstract].to_s.delete("{}").strip
      doc
    end

    # BibLaTeX `date` (YYYY, YYYY-MM or YYYY-MM-DD) wins over year/month.
    def entry_date(entry)
      if entry.has_field?(:date)
        y, m, d = clean(entry[:date]).split("/").first.split("-").map(&:to_i)
      elsif entry.has_field?(:year)
        y = clean(entry[:year]).to_i
        m = entry.has_field?(:month) ? entry.month_numeric.to_i : nil
      end
      return unless y && y.positive?

      Time.new(y, m.to_i.clamp(1, 12), (d || 1).clamp(1, 31))
    end

    # "Rossi, Mario" -> "Mario Rossi", to match person titles and aliases.
    def names(value)
      return [] unless value

      value.map { |n| [n.first, n.prefix, n.last, n.suffix].compact.join(" ").squeeze(" ").strip }
    end

    def clean(value)
      value.to_s.delete("{}").gsub(/\s+/, " ").strip
    end
  end
end

Jekyll::Hooks.register :site, :post_read, priority: :high do |site|
  CmecPhd::BibtexResearch.new(site).generate
end
