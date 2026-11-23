require "date"
require "json"
require "kramdown"

module SiteViewHelpers
  GUIDE_TITLES = {
    "health" => "Dan’s Health Guide",
    "rum" => "Dan’s Rum Guide"
  }.freeze

  def collection_items(name)
    members = @items.find_all do |item|
      item[:collection] == name && item[:published] != false
    end
    return members unless name == "writing" || GUIDE_TITLES.key?(name)

    ordered = members.sort_by { |item| [(item[:date] || Date.new(2000)).to_time, item.identifier.to_s] }
    name == "writing" ? ordered.reverse : ordered
  end

  def guide_neighbors(item)
    chapters = collection_items(item[:collection])
    position = chapters.index { |chapter| chapter.identifier == item.identifier }
    return [nil, nil] unless position

    previous = chapters[position - 1] if position.positive?
    [previous, chapters[position + 1]]
  end

  def guide_title(item)
    GUIDE_TITLES[item[:collection]]
  end

  def document_title(item)
    return item[:title] if item[:standalone_title]
    return @config[:title] unless item[:title]

    "#{item[:title]} | #{guide_title(item) || @config[:title]}"
  end

  def asset_path(kind)
    manifest = @items["/assets/manifest.json"]
    raise "Missing frontend asset manifest. Run npm run esbuild first." unless manifest

    JSON.parse(manifest.raw_content).fetch(kind.to_s)
  end

  def markdownify(source)
    Kramdown::Document.new(source.to_s, **@config[:kramdown]).to_html.strip
  end

  def self.taxonomy_slug(type, term)
    slug = term.downcase
    type == "tag" ? slug.tr(" ", "-") : slug
  end

  def taxonomy_url(type, term)
    "/#{type == "tag" ? "tags" : "categories"}/#{SiteViewHelpers.taxonomy_slug(type, term)}/"
  end

  def taxonomy_posts(item)
    type = item[:taxonomy_type]
    attribute = type == "category" ? :categories : :tags
    collection_items("writing").select do |post|
      Array(post[attribute]).any? { |term| SiteViewHelpers.taxonomy_slug(type, term) == item[:taxonomy_slug] }
    end
  end
end

use_helper Nanoc::Helpers::LinkTo
use_helper Nanoc::Helpers::Rendering
use_helper SiteViewHelpers
