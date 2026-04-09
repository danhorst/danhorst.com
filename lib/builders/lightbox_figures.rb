require "nokogiri"

module LightboxFigures
  def self.transform(html)
    doc = Nokogiri::HTML.parse(html)

    doc.css("div.lightbox-figure").each do |div|
      href    = div["data-href"]
      src     = div["data-src"] || href
      alt     = div["data-alt"]
      aspect  = div["data-aspect"]
      caption = div["data-caption"]&.gsub('\n', "<br>\n")
      id      = div["data-id"]

      figcaption = caption ? %(<figcaption class="picture__caption marginnote">#{caption}</figcaption>\n) : ""
      id_attr    = id ? %( id="#{id}") : ""
      aspect_cls = aspect ? " #{aspect}" : ""

      div.replace(Nokogiri::HTML.fragment(<<~HTML.chomp))
        <figure class="picture">
        #{figcaption}<div#{id_attr} class="lightbox">
        <a class="picture__anchor#{aspect_cls}" href="#{href}" data-turbo="false">
        <div class="placeholder"></div>
        <img loading="lazy" class="picture__content" src="#{src}" alt="#{alt}"/>
        </a>
        </div>
        </figure>
      HTML
    end

    doc.to_html
  end
end
