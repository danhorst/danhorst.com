class TaxonomyPages < SiteBuilder
  def build
    generator do
      writing = site.collections.writing.resources

      writing.flat_map { |r| Array(r.data.categories) }.uniq.each do |cat|
        slug = cat.downcase
        add_resource :pages, "categories/#{slug}.html" do
          layout "taxonomy_archive"
          title cat
          permalink "/categories/#{slug}/"
          taxonomy_type "category"
          taxonomy_slug slug
        end
      end

      writing.flat_map { |r| Array(r.data.tags) }.uniq.each do |tag|
        slug = tag.downcase.gsub(" ", "-")
        add_resource :pages, "tags/#{slug}.html" do
          layout "taxonomy_archive"
          title tag
          permalink "/tags/#{slug}/"
          taxonomy_type "tag"
          taxonomy_slug slug
        end
      end
    end
  end
end
