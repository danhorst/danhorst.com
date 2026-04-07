require_relative "../md_wrap"

module PlainTextExport
  FRONT_MATTER_PATTERN = /\A---\n.*?---\n/m

  def self.run(site)
    site.collections[:writing].resources.each do |resource|
      next unless resource.output_ext == ".html"

      raw     = File.read(File.join(site.source, resource.relative_path))
      content = raw.sub(FRONT_MATTER_PATTERN, "").lstrip

      # e.g. output/writing/dash-it-all/index.html → output/writing/dash-it-all.txt
      txt_path = resource.destination.output_path.sub(%r{/index\.html$}, ".txt")
      FileUtils.mkdir_p(File.dirname(txt_path))
      File.write(txt_path, MdWrap.wrap(content))
    end
  end
end
