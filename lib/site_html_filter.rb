require "htmlbeautifier"

class SiteHtmlFilter < Nanoc::Filter
  identifier :site_html

  def run(html, _params = {})
    html = Sidenotes.transform(html) if html.include?("footnotes")
    html = LightboxFigures.transform(html) if html.include?("image-figure")
    HtmlBeautifier.beautify(html)
  end
end
