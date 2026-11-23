require "cgi"
require "time"

module SitePublishingHelpers
  def publication_url(path)
    @config[:url].chomp("/") + path
  end

  def plain_text_url(item)
    url = item[:url]
    return unless url && url != "/" && url.end_with?("/") && item.identifier.to_s.end_with?(".md")

    url.chomp("/") + ".txt"
  end

  def sitemap_items
    @items.select { |item| item[:url] && item[:sitemap] != false && item[:published] != false }
  end

  def atom_entries(collection)
    return [] unless collection

    collection_items(collection).reject { |post| post[:draft] == true }.first(10)
  end

  def atom_content(post)
    # Feed readers may render the entry on other origins.
    html = post.compiled_content(snapshot: :body_html).strip
    html = html.gsub(%r{(\b(?:src|href)=["'])/(?!/)}) { "#{Regexp.last_match(1)}#{publication_url('/')}" }
    html.include?("image-figure") ? LightboxFigures.transform_fragment(html) : html
  end

  def xml_escape(value)
    CGI.escapeHTML(value.to_s)
  end
end

use_helper SitePublishingHelpers
