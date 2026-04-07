# Markdown-aware paragraph wrapper.
# Port of https://github.com/danhorst/md-tools — mdwrap
#
# Wraps prose paragraphs to a column width (default 60) while leaving
# headings, code fences, list items, blockquotes, link/footnote reference
# definitions, and other structural Markdown elements unchanged.

module MdWrap
  DEFAULT_WIDTH = 60

  def self.wrap(content, width: DEFAULT_WIDTH)
    lines = content.split("\n", -1)
    result = []
    i = 0

    # Handle YAML frontmatter (two formats):
    #   1. --- / properties / ---
    #   2. property lines / ---  (no opening ---)
    if i < lines.length
      if lines[i].strip == "---" && i + 1 < lines.length &&
          looks_like_frontmatter_property?(lines[i + 1])
        result << lines[i]
        i += 1
        while i < lines.length && lines[i].strip != "---"
          result << lines[i]
          i += 1
        end
        if i < lines.length
          result << lines[i]
          i += 1
        end
      elsif looks_like_frontmatter_property?(lines[i])
        j = i + 1
        has_frontmatter = false
        while j < lines.length
          if lines[j].strip == "---"
            has_frontmatter = true
            break
          end
          break if lines[j].strip == ""
          j += 1
        end
        if has_frontmatter
          while i < lines.length && lines[i].strip != "---"
            result << lines[i]
            i += 1
          end
          if i < lines.length
            result << lines[i]
            i += 1
          end
        end
      end
    end

    while i < lines.length
      line    = lines[i]
      stripped = line.strip

      # Fenced code block (``` or ~~~)
      if stripped.start_with?("```") || stripped.start_with?("~~~")
        fence = stripped[0, 3]
        result << line
        i += 1
        while i < lines.length && !lines[i].strip.start_with?(fence)
          result << lines[i]
          i += 1
        end
        if i < lines.length
          result << lines[i]
          i += 1
        end
        next
      end

      # Indented code block (4 spaces or tab)
      if line.start_with?("    ") || line.start_with?("\t")
        result << line
        i += 1
        next
      end

      # Footnote definition  [^label]: ...
      if footnote_definition?(line)
        result << line
        i += 1
        next
      end

      # Link reference definition  [label]: URL
      if link_ref_definition?(line)
        result << line
        i += 1
        next
      end

      # Kramdown abbreviation definition  *[ABBR]: expansion
      if abbreviation_definition?(line)
        result << line
        i += 1
        next
      end

      # Blank line
      if stripped.empty?
        result << line
        i += 1
        next
      end

      # ATX heading
      if line.start_with?("#")
        result << line
        i += 1
        next
      end

      # List item
      if list_item?(line)
        result << line
        i += 1
        next
      end

      # Blockquote — collect consecutive > lines and wrap together
      if stripped.start_with?(">")
        bq_lines = []
        while i < lines.length && lines[i].strip.start_with?(">")
          bq_lines << lines[i]
          i += 1
        end
        result.concat(wrap_blockquote(bq_lines, width))
        next
      end

      # Horizontal rule
      if horizontal_rule?(line)
        result << line
        i += 1
        next
      end

      # Regular paragraph — collect until a structural break
      para_lines = []
      while i < lines.length
        l  = lines[i]
        sl = l.strip

        break if sl.empty?
        break if sl.start_with?("```") || sl.start_with?("~~~")
        break if l.start_with?("    ") || l.start_with?("\t")
        break if footnote_definition?(l)
        break if link_ref_definition?(l)
        break if abbreviation_definition?(l)
        break if l.start_with?("#")
        break if list_item?(l)
        break if sl.start_with?(">")
        break if horizontal_rule?(l)

        # Hard line break (two trailing spaces) ends this paragraph segment
        if l.end_with?("  ")
          para_lines << l
          i += 1
          break
        end

        para_lines << l
        i += 1
      end

      result.concat(wrap_paragraph(para_lines, width)) if para_lines.any?
    end

    result.join("\n").sub(/\n*\z/, "\n")
  end

  # --- wrapping helpers ---

  def self.wrap_paragraph(lines, width)
    has_hard_break = lines.last&.end_with?("  ")
    words = lines.join(" ").split
    return [] if words.empty?

    out = []
    cur = +""
    words.each do |word|
      if cur.empty?
        cur << word
      elsif cur.length + 1 + word.length <= width
        cur << " " << word
      else
        out << cur
        cur = +word
      end
    end
    cur << "  " if has_hard_break
    out << cur unless cur.empty?
    out
  end

  def self.wrap_blockquote(lines, width)
    prefix        = "> "
    content_width = width - prefix.length
    result        = []
    pending       = []

    lines.each do |line|
      content = line.strip.sub(/^>\s?/, "")

      # GFM alert syntax ([!NOTE], [!WARNING], etc.) — flush and preserve as-is
      if content.start_with?("[!") && content.include?("]")
        if pending.any?
          wrap_to_width(pending, content_width).each { |w| result << prefix + w }
          pending = []
        end
        result << prefix + content
        next
      end

      pending << content
    end

    wrap_to_width(pending, content_width).each { |w| result << prefix + w } if pending.any?
    result
  end

  def self.wrap_to_width(lines, width)
    words = lines.join(" ").split
    return [] if words.empty?

    out = []
    cur = +""
    words.each do |word|
      if cur.empty?
        cur << word
      elsif cur.length + 1 + word.length <= width
        cur << " " << word
      else
        out << cur
        cur = +word
      end
    end
    out << cur unless cur.empty?
    out
  end

  # --- detection helpers (ported from internal/markdown/detect.go) ---

  def self.looks_like_frontmatter_property?(line)
    trimmed = line.strip
    return false if trimmed.empty? || trimmed == "---"
    trimmed.index(":").to_i > 0
  end

  def self.footnote_definition?(line)
    line.match?(/^\[\^[^\]]+\]:/)
  end

  def self.link_ref_definition?(line)
    return false if footnote_definition?(line)
    line.match?(/^\[[^\]]+\]:\s*\S/)
  end

  # Kramdown-specific: *[ABBR]: expansion
  def self.abbreviation_definition?(line)
    line.match?(/^\*\[[^\]]+\]:/)
  end

  def self.list_item?(line)
    trimmed = line.strip
    return true if trimmed.length > 1 &&
                   %w[- * +].include?(trimmed[0]) &&
                   trimmed[1] == " "
    trimmed.match?(/^\d+\.\s/)
  end

  def self.horizontal_rule?(line)
    stripped = line.strip.delete(" ")
    return false if stripped.length < 3
    return false unless %w[- * _].include?(stripped[0])
    stripped.chars.all? { |c| c == stripped[0] }
  end
end
