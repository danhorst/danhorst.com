module LlmsTxt
  COLLECTION_ORDER = %w[writing rum health lists food].freeze

  SECTION_LABELS = {
    "writing" => "Writing",
    "rum"     => "Rum",
    "health"  => "Health",
    "lists"   => "Lists",
    "food"    => "Food",
  }.freeze

  def self.run(site)
    base_url      = site.config.url.chomp("/")
    content       = header(base_url)
    optional_lines = []

    COLLECTION_ORDER.each do |name|
      collection = site.collections[name]
      next unless collection

      active   = []
      archived = []

      resources = collection.resources
        .select { |r| r.output_ext == ".html" && r.relative_path.to_s.end_with?(".md") && r.data.published != false }
        .sort_by { |r| r.data.date || Time.at(0) }
        .reverse

      resources.each do |resource|
        slug  = slug_for(resource)
        title = resource.data.title || slug
        line  = "- [#{title}](#{base_url}/#{name}/#{slug}.txt)"

        if resource.data.categories&.include?("Archived")
          archived << line
        else
          active << line
        end
      end

      unless active.empty?
        content += "## #{SECTION_LABELS[name]}\n\n"
        content += active.join("\n") + "\n\n"
      end

      optional_lines.concat(archived)
    end

    all_optional = [
      "- [Colophon](#{base_url}/colophon/): How the site is built and hosted",
      "- [Contact](#{base_url}/contact/): Ways to reach Dan",
    ] + optional_lines

    content += "## Optional\n\n"
    content += all_optional.join("\n") + "\n"

    File.write(File.join(site.config.destination, "llms.txt"), content)
  end

  def self.header(base_url)
    <<~MD
      # Dan Brubaker Horst

      > Personal website of Dan Brubaker Horst — Principal Engineer, technical writer, and hobbyist rocketeer based in South Bend, IN.

      Dan writes about software engineering, enterprise architecture, DevOps, product design, and personal interests. He has been building software professionally since 2007. Everything on this site is written in his own voice; he does not use AI to generate prose.

      ## Core

      - [About](#{base_url}/about/): Background, current role, and interests
      - [Work With Me](#{base_url}/work-with-me/): Professional background, skills inventory, and availability for staff engineer or engineering lead roles
      - [Writing](#{base_url}/writing/): Long-form technical and personal essays
      - [AI](#{base_url}/ai/): How Dan uses AI on this site and his personal ethics statement

    MD
  end

  def self.slug_for(resource)
    resource.destination.output_path.sub(%r{/index\.html$}, "").split("/").last
  end

  private_class_method :header, :slug_for
end
