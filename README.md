# danhorst.com

This repo is a [Bridgetown][1] site that generates [danhorst.com][2].
I've left it open in the spirit of working in public.

## Build locally

Install the pinned Ruby and Node.js versions with `mise install`, then run:

```sh
mise exec -- bundle install
mise exec -- bin/build
```

The build installs JavaScript dependencies from `package-lock.json` with
`npm ci`, bundles assets with esbuild, and generates the production site in
`output/`. It checks internal links, images, and publishing details including
the Atom feed and Markdown export. Netlify runs the same checks for production
and deploy previews.

[1]: https://www.bridgetownrb.com/
[2]: https://www.danhorst.com
