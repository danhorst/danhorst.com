import { build, context } from "esbuild"
import { readdir, rename, unlink, writeFile } from "node:fs/promises"
import path from "node:path"

const outdir = "tmp/frontend"
const options = {
  entryPoints: { site: "frontend/javascript/index.js" },
  entryNames: "[name].[hash]",
  bundle: true,
  sourcemap: true,
  target: "es2020",
  external: ["/font/*", "/svg/*"],
  outdir,
  metafile: true,
  plugins: [{
    name: "asset-manifest",
    setup(builder) {
      builder.onEnd(async result => {
        if (result.errors.length) return
        const outputs = Object.keys(result.metafile.outputs)
        const script = outputs.find(file => result.metafile.outputs[file].entryPoint)
        const stylesheet = result.metafile.outputs[script].cssBundle
        const manifest = {
          css: "/assets/" + path.basename(stylesheet),
          js: "/assets/" + path.basename(script),
        }
        const manifestPath = path.join(outdir, "manifest.json")
        // Publish the manifest once both bundles exist, including during live reloads.
        await writeFile(manifestPath + ".tmp", JSON.stringify(manifest))
        await rename(manifestPath + ".tmp", manifestPath)
        const current = new Set(outputs.map(file => path.basename(file)))
        for (const file of await readdir(outdir)) {
          if (/^site\.[\w-]+\.(js|css)(\.map)?$/.test(file) && !current.has(file)) {
            await unlink(path.join(outdir, file))
          }
        }
      })
    },
  }],
}

if (process.argv.includes("--watch")) {
  const builder = await context(options)
  await builder.watch()
} else {
  await build(options)
}
