require "nokogiri"

module Sidenotes
  def self.transform(html)
    doc = Nokogiri::HTML.parse(html)

    # Build map: "fn:1" => inner HTML of footnote content (backlink stripped)
    footnotes = {}
    doc.css("div.footnotes li").each do |li|
      id = li["id"]
      li.css("a.reversefootnote").each(&:remove)
      footnotes[id] = li.css("p").map(&:inner_html).join(" ").strip
    end

    # Replace each inline <sup> reference with Tufte sidenote markup
    doc.css("sup[id^='fnref:']").each do |sup|
      ref_id   = sup["id"]                       # "fnref:1"
      fn_id    = ref_id.sub("fnref:", "fn:")      # "fn:1"
      label_id = ref_id.sub("fnref:", "sn-")      # "sn-1"
      content  = footnotes[fn_id]
      next unless content

      sup.replace(Nokogiri::HTML.fragment(<<~HTML.chomp))
        <label for="#{label_id}" class="margin-toggle sidenote-number"></label><input type="checkbox" id="#{label_id}" class="margin-toggle"/><span class="sidenote">#{content}</span>
      HTML
    end

    doc.css("div.footnotes").each(&:remove)

    doc.to_html
  end
end
