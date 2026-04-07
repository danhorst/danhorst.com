#!/usr/bin/env ruby
# Renumbers [^keyword] footnotes to [^1], [^2], ... in order of first appearance.
#
# Usage:
#   ruby util/number_footnotes.rb           # write changes in place
#   ruby util/number_footnotes.rb --dry-run # print diffs, make no changes

require "tempfile"

DRY_RUN = ARGV.include?("--dry-run")

def number_footnotes(path)
  src = File.read(path)

  # Parse all definitions: each [^key]: block runs until the next [^key]: or EOF
  defs = {}
  src.scan(/^\[\^([^\]]+)\]:(.*?)(?=\n\[\^[^\]]+\]:|\z)/m) do
    key, content = $1, $2.strip
    defs[key] = content
  end

  return nil if defs.empty?

  # Find reference order by scanning non-definition lines
  key_to_num = {}
  counter = 0
  src.each_line do |line|
    next if line =~ /^\[\^[^\]]+\]:/
    line.scan(/\[\^([^\]]+)\]/) do |m|
      key = m[0]
      next unless defs.key?(key)
      key_to_num[key] ||= (counter += 1)
    end
  end

  return nil if key_to_num.empty?

  # Strip trailing definitions block from body
  body = src.sub(/\n\n\[\^[^\]]+\]:.*\z/m, "")

  # Replace references in body
  result = body.gsub(/\[\^([^\]]+)\]/) do
    num = key_to_num[$1]
    num ? "[^#{num}]" : $&
  end

  # Build numbered definitions in reference order
  defs_section = key_to_num.sort_by { |_, n| n }.map do |key, num|
    "[^#{num}]: #{defs[key]}"
  end.join("\n")

  result.rstrip + "\n\n" + defs_section + "\n"
end

def show_diff(path, new_content)
  Tempfile.open(["number_footnotes", ".md"]) do |tmp|
    tmp.write(new_content)
    tmp.flush
    system("diff -u #{path} #{tmp.path} | sed 's|#{tmp.path}|#{path} (numbered)|'")
  end
end

changed = 0

Dir.glob("src/**/*.md").sort.each do |path|
  result = number_footnotes(path)
  next unless result

  changed += 1

  if DRY_RUN
    puts "\n#{"=" * 60}"
    puts path
    puts "=" * 60
    show_diff(path, result)
  else
    File.write(path, result)
    puts "#{path}: renumbered"
  end
end

puts "\n#{changed} file#{"s" unless changed == 1} #{DRY_RUN ? "would be" : ""} changed."
