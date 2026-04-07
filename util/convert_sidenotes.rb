#!/usr/bin/env ruby
# Converts hand-authored HTML sidenote/marginnote literals in Markdown files
# to native Markdown footnote syntax ([^id] / [^id]: content).
#
# Usage:
#   ruby util/convert_sidenotes.rb           # write changes in place
#   ruby util/convert_sidenotes.rb --dry-run # print diffs, make no changes

require "tempfile"

DRY_RUN = ARGV.include?("--dry-run")

# ---------------------------------------------------------------------------
# Two variants of the sidenote HTML pattern:
#
# Block-style (label/input/span each on their own line, closing </span> on
# its own line — safe against nested spans inside the content):
#
#   <label for="ID" class="margin-toggle sidenote-number"></label>
#   <input type="checkbox" id="ID" class="margin-toggle"/>
#   <span class="sidenote">
#   content (may contain nested tags)
#   </span>
#
# Inline-style (all on one run of lines, no nested spans in content):
#
#   <label for="ID" ...></label><input .../><span class="sidenote">content</span>
# ---------------------------------------------------------------------------

SIDENOTE_BLOCK_RE = /
  (<label[^>]+class="margin-toggle\s+sidenote-number"[^>]*><\/label>)\n
  [ \t]*<input[^>]+class="margin-toggle"[^>]*\/>\n
  [ \t]*<span\ class="sidenote">\n
  (.*?)
  \n[ \t]*<\/span>
/xm

SIDENOTE_INLINE_RE = /
  (<label[^>]+class="margin-toggle\s+sidenote-number"[^>]*><\/label>)
  [ \t]*<input[^>]+class="margin-toggle"[^>]*\/>
  [ \t]*<span\ class="sidenote">(.*?)<\/span>
/xm

# Marginnote: label may be multi-line; input and span may be on the same line
# or separate lines.
MARGINNOTE_RE = /
  (<label[^>]+class="margin-toggle"[^>]*>.*?<\/label>)\n?
  [ \t]*<input[^>]+class="margin-toggle"[^>]*\/>\n?
  [ \t]*<span\ class="marginnote">\n?
  (.*?)
  \n?[ \t]*<\/span>
/xm

# ---------------------------------------------------------------------------

def extract_id(label_tag)
  label_tag[/for="([^"]+)"/, 1]
end

def html_to_md(html)
  html
    .gsub(/<span class="hidden">.*?<\/span>/m, "") # strip decorative wrappers
    .gsub(/<a href="([^"]+)">([^<]+)<\/a>/, '[\2](\1)')
    .gsub(/<em>(.*?)<\/em>/m, '*\1*')
    .gsub(/<strong>(.*?)<\/strong>/m, '**\1**')
    .gsub(/<code>(.*?)<\/code>/, '`\1`')
    .gsub(/\n[ \t]+/, " ")   # collapse indented continuation lines
    .strip
end

def unique_id(base, used)
  return base unless used.key?(base)
  suffix = 2
  suffix += 1 while used.key?("#{base}-#{suffix}")
  "#{base}-#{suffix}"
end

def apply_pattern(src, pattern, footnotes)
  src.gsub(pattern) do |_match|
    base    = extract_id($1)
    id      = unique_id(base, footnotes)
    content = html_to_md($2)
    footnotes[id] = content
    "[^#{id}]"
  end
end

def convert(path)
  src = File.read(path)
  footnotes = {}

  result = apply_pattern(src,    SIDENOTE_BLOCK_RE,  footnotes)
  result = apply_pattern(result, SIDENOTE_INLINE_RE, footnotes)
  result = apply_pattern(result, MARGINNOTE_RE,      footnotes)

  return nil if footnotes.empty?

  definitions = footnotes.map { |id, content| "[^#{id}]: #{content}" }.join("\n\n")
  result      = result.rstrip + "\n\n" + definitions + "\n"

  [result, footnotes]
end

def show_diff(path, new_content)
  Tempfile.open(["convert_sidenotes", ".md"]) do |tmp|
    tmp.write(new_content)
    tmp.flush
    system("diff -u #{path} #{tmp.path} | sed 's|#{tmp.path}|#{path} (converted)|'")
  end
end

changed = 0

Dir.glob("src/**/*.md").sort.each do |path|
  outcome = convert(path)
  next unless outcome

  new_content, footnotes = outcome
  changed += 1

  if DRY_RUN
    puts "\n#{"=" * 60}"
    puts "#{path}  (#{footnotes.size} footnote#{"s" unless footnotes.size == 1})"
    puts "=" * 60
    show_diff(path, new_content)
  else
    File.write(path, new_content)
    puts "#{path}: #{footnotes.size} footnote#{"s" unless footnotes.size == 1} converted"
  end
end

puts "\n#{changed} file#{"s" unless changed == 1} #{DRY_RUN ? "would be" : ""} changed."
