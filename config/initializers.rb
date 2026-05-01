require "cgi"
require "htmlbeautifier"
require_relative "../lib/builders/sidenotes"
require_relative "../lib/builders/lightbox_figures"
require_relative "../lib/builders/plain_text_export"
require_relative "../lib/builders/llms_txt"

# Bridgetown hardcodes `/_bridgetown/static` as the asset URL prefix in
# Utils#static_frontend_path, which is what the `asset_path` helper uses to
# generate <link> and <script> tags. This patch replaces that prefix with
# `/assets` to match the custom `publicPath` and `outdir` set in
# esbuild.config.js. If Bridgetown is upgraded, check whether
# Utils#static_frontend_path has changed before accepting the update to
# config/esbuild.defaults.js (run `bridgetown esbuild update`).
module Bridgetown
  module Utils
    def static_frontend_path(site, additional_parts = [])
      path_parts = [
        site.base_path.gsub(%r{^/|/$}, ""),
        "assets",
        *additional_parts,
      ]
      path_parts[0] = "/#{path_parts[0]}" unless path_parts[0].empty?
      Addressable::URI.parse(path_parts.join("/")).normalize.to_s
    end
  end
end

Bridgetown.configure do |config|
  init :"bridgetown-feed"

  hook :resources, :post_render do |resource|
    next unless resource.output_ext == ".html"
    next unless resource.output.include?("footnotes")

    resource.output = Sidenotes.transform(resource.output)
  end

  hook :resources, :post_render do |resource|
    next unless resource.output_ext == ".html"
    next unless resource.output.include?("image-figure")

    resource.output = LightboxFigures.transform(resource.output)
  end

  hook :resources, :post_render, priority: :low do |resource|
    next unless resource.output_ext == ".html"

    resource.output = HtmlBeautifier.beautify(resource.output)
  end
end

Bridgetown::Hooks.register :site, :post_write do |site|
  PlainTextExport.run(site)
  LlmsTxt.run(site)

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
