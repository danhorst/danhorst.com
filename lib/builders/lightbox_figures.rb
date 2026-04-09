require "nokogiri"

module LightboxFigures
  def self.transform(html)
    doc = Nokogiri::HTML.parse(html)

    doc.css("image-figure").each do |el|
      href    = el["href"]
      src     = el["src"] || href
      alt     = el["alt"]
      aspect  = el["aspect"]
      id      = el["id"]

      caption_html = el.inner_html.strip
      caption_html = caption_html.sub(/\A<p>(.*)<\/p>\z/m, '\1') if caption_html.start_with?("<p>")
      figcaption = caption_html.empty? ? "" : %(<figcaption class="picture__caption marginnote">#{caption_html}</figcaption>\n)
      id_attr    = id ? %( id="#{id}") : ""
      aspect_cls = aspect ? " #{aspect}" : ""

      el.replace(Nokogiri::HTML.fragment(<<~HTML.chomp))
        <figure class="picture">
        #{figcaption}<div#{id_attr} class="lightbox">
        <a class="picture__anchor#{aspect_cls}" href="#{href}" data-turbo="false">
        <span class="placeholder"></span>
        <img loading="lazy" class="picture__content" src="#{src}" alt="#{alt}"/>
        </a>
        </div>
        </figure>
      HTML
    end

    doc.to_html
  end
end
