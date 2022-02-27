#!/usr/bin/env ruby
require "humanize"

classes = [
  "e",
  "d",
  "a",
  "b",
  "c",
  "d",
  "f",
  "d",
  "e",
  "a",
  "b",
  "f",
  "c",
  "d",
  "f",
  "b",
  "e",
  "a",
  "d",
  "c",
  "f",
  "b",
  "f",
  "d",
  "a",
  "b"
]

color_table = {
  a: [
    "#ff5200",
    [19, 100, 100]
  ],
  b: [
    "#008215",
    [130, 100, 51]
  ],
  c: [
    "#ffcb00",
    [48, 100, 100]
  ],
  d: [
    "#005a9f",
    [206, 100, 62]
  ],
  e: [
    "#c6001c",
    [352, 100, 78]
  ],
  f: [
    "#41266b",
    [263, 64, 42]
  ],
  z: [
    "#000000",
    [0, 0, 0]
  ]
}

keyframes = ""
css_rules = ""
html = ""

classes.each_with_index do |letter, index|
  sequence = (index + 1).humanize
  css_class = "band-#{sequence}"
  html << "<div class=\"color-band #{css_class}\"></div>\n"

  delay = index * 500
  css_rule = ".#{css_class} { animation-delay: #{delay}ms }\n"
  css_rules << css_rule

  color = color_table[letter.to_sym].first
  frame = index * 4
  keyframe = "#{frame}% { background-color: #{color}; }\n"
  keyframes << keyframe
end

puts html
puts
puts css_rules
puts
puts keyframes
