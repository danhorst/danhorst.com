# danhorst.com

This repo is a [Nanoc][1] site that generates [danhorst.com][2].
I've left it open in the spirit of working in public.

## Build locally

Install the pinned Ruby and Node.js versions with `mise install`, then run:

```sh
mise exec -- bundle install
mise exec -- bin/build
```

The build installs JavaScript dependencies from `package-lock.json` with
`npm ci`, bundles assets with esbuild, and runs Nanoc to generate the site in
`output/`. It checks internal links, images, and publishing details including
the Atom feed and Markdown export. Netlify runs the same checks for production
and deploy previews.

## Write and preview

Edit Markdown in `content/`. For a new essay, add `content/writing/my-essay.md`
with a title and date in its YAML front matter. Its published URL is
`/writing/my-essay/`. ERB layouts live in `layouts/`, and `Rules` controls
how items are compiled and where their HTML and Markdown copies are written.

After the first build, run `bundle exec nanoc live --port 4000` for a writing
preview at <http://localhost:4000>. To also watch JavaScript and CSS, run
`npm run esbuild -- --watch` in a second terminal. The existing `bin/dev`
shortcut starts both watchers and the local Caddy proxy with Overmind.

[1]: https://nanoc.app/
[2]: https://www.danhorst.com
