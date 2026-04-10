require_relative "../md_wrap"

module PlainTextExport
  FRONT_MATTER_PATTERN = /\A---\n.*?---\n/m

  def self.run(site)
    site.collections.each_value do |collection|
      collection.resources.each do |resource|
        next unless resource.output_ext == ".html"
        next unless resource.relative_path.to_s.end_with?(".md")
        export(site, resource)
      end
    end
  end

  def self.export(site, resource)
    raw     = File.read(File.join(site.source, resource.relative_path))
    content = raw.sub(FRONT_MATTER_PATTERN, "").lstrip
    content = "# #{resource.data.title}\n\n#{content}" if resource.data.title

    # e.g. output/writing/dash-it-all/index.html → output/writing/dash-it-all.txt
    txt_path = resource.destination.output_path.sub(%r{/index\.html$}, ".txt")
    FileUtils.mkdir_p(File.dirname(txt_path))
    File.write(txt_path, MdWrap.wrap(content))
  end
  private_class_method :export
end
