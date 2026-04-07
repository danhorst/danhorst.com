require "rack"

# Register .txt as text/markdown with UTF-8 charset for the local Puma dev
# server, matching the Content-Type header configured in netlify.toml.
# (Netlify headers don't apply locally; this file is loaded only by the
# Rack/Puma process, after the build-watcher fork.)
Rack::Mime::MIME_TYPES[".txt"] = "text/markdown; charset=utf-8"

class RodaApp < Roda
  plugin :bridgetown_server
  route(&:bridgetown)
end
