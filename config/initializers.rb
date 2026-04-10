require "cgi"
require_relative "../lib/builders/sidenotes"
require_relative "../lib/builders/lightbox_figures"
require_relative "../lib/builders/plain_text_export"

Bridgetown.configure do |config|
  init :"bridgetown-feed"
end

Bridgetown::Hooks.register :resources, :post_render do |resource|
  next unless resource.output_ext == ".html"
  next unless resource.output.include?("footnotes")

  resource.output = Sidenotes.transform(resource.output)
end

Bridgetown::Hooks.register :resources, :post_render do |resource|
  next unless resource.output_ext == ".html"
  next unless resource.output.include?("image-figure")

  resource.output = LightboxFigures.transform(resource.output)
end

Bridgetown::Hooks.register :site, :post_write do |site|
  PlainTextExport.run(site)

  feed_path = File.join(site.config.destination, "feed")
  next unless File.file?(feed_path)

  base_url = site.config.url.chomp("/")
  content  = File.read(feed_path)
  updated  = content.gsub(/(src|href)=&quot;\//, "\\1=&quot;#{base_url}/")

  ns  = { "atom" => "http://www.w3.org/2005/Atom" }
  doc = Nokogiri::XML(updated)
  doc.xpath("//atom:entry", ns).each do |entry|
    id_el = entry.at_xpath("atom:id", ns)
    if id_el&.text&.start_with?("repo://")
      link_el = entry.at_xpath("atom:link[@rel='alternate']", ns)
      id_el.content = link_el["href"] if link_el
    end

    content_el = entry.at_xpath("atom:content[@type='html']", ns)
    if content_el && content_el.text.include?("image-figure")
      content_el.content = LightboxFigures.transform_fragment(CGI.unescapeHTML(content_el.text))
    end
  end
  updated = doc.to_xml(encoding: "utf-8")

  File.write(feed_path, updated)
end
