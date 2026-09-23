# When `under_construction: true` (see _config.yml), replace the entire
# site — every page and every collection document — with a single
# "coming soon" page at the root URL. Locally, _config_dev.yml sets
# `under_construction: false`, so `bundle exec jekyll serve --config
# _config.yml,_config_dev.yml` always renders the real, full site.
#
# Runs at :highest priority so it executes before jekyll-polyglot (or any
# other generator) has a chance to duplicate/localize pages.
module CmecPhd
  class MaintenanceGenerator < Jekyll::Generator
    priority :highest

    def generate(site)
      return unless site.config["under_construction"]

      site.pages.clear
      site.collections.each_value { |collection| collection.docs.clear }

      page = Jekyll::PageWithoutAFile.new(site, site.source, "", "index.html")
      page.content = ""
      page.data.merge!(
        "layout"    => "maintenance",
        "title"     => "CMEC PhD",
        "permalink" => "/"
      )
      site.pages << page
    end
  end
end
