require_relative "../md_wrap"

module PlainTextExport
  FRONT_MATTER_PATTERN = /\A---\n.*?---\n/m

  def self.run(site)
    # Collections: writing, rum, health
    %i[writing rum health].each do |col|
      site.collections[col].resources.each do |resource|
        next unless resource.output_ext == ".html"
        next unless resource.relative_path.to_s.end_with?(".md")
        export(site, resource)
      end
    end

    # Standalone pages with markdown_export: true
    site.collections[:pages].resources.each do |page|
      next unless page.data.markdown_export
      next unless page.output_ext == ".html"
      export(site, page)
    end
  end

  def self.export(site, resource)
    raw     = File.read(File.join(site.source, resource.relative_path))
    content = raw.sub(FRONT_MATTER_PATTERN, "").lstrip

    # e.g. output/writing/dash-it-all/index.html → output/writing/dash-it-all.txt
    txt_path = resource.destination.output_path.sub(%r{/index\.html$}, ".txt")
    FileUtils.mkdir_p(File.dirname(txt_path))
    File.write(txt_path, MdWrap.wrap(content))
  end
  private_class_method :export
end
