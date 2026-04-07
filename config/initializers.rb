require_relative "../lib/builders/sidenotes"
require_relative "../lib/builders/plain_text_export"

Bridgetown.configure do |config|
  init :"bridgetown-feed"
end

Bridgetown::Hooks.register :resources, :post_render do |resource|
  next unless resource.output_ext == ".html"
  next unless resource.output.include?("footnotes")

  resource.output = Sidenotes.transform(resource.output)
end

Bridgetown::Hooks.register :site, :post_write do |site|
  PlainTextExport.run(site)

  feed_path = File.join(site.config.destination, "feed")
  next unless File.file?(feed_path)

  base_url = site.config.url.chomp("/")
  content  = File.read(feed_path)
  updated  = content.gsub(/(src|href)=&quot;\//, "\\1=&quot;#{base_url}/")
  File.write(feed_path, updated) if updated != content
end
