import build from "./config/esbuild.defaults.js"
import path from "path"
import { fileURLToPath } from "url"

const __dirname = path.dirname(fileURLToPath(import.meta.url))

// You can customize this as you wish, perhaps to add new esbuild plugins.
//
// ```
// import { copy } from 'esbuild-plugin-copy'
//
// const esbuildOptions = {
//   plugins: [
//     copy({
//       resolveFrom: 'cwd',
//       assets: {
//         from: ['./node_modules/somepackage/files/*')],
//         to: ['./output/_bridgetown/somepackage/files')],
//       },
//       verbose: false
//     }),
//   ]
// }
// ```

/**
 * @typedef { import("esbuild").BuildOptions } BuildOptions
 * @type {BuildOptions}
 */
const esbuildOptions = {
  plugins: [
    // add new plugins here...
  ],
  globOptions: {
    excludeFilter: /\.(dsd|lit)\.css$/
  },
  entryPoints: { "site": "./frontend/javascript/index.js" },
  publicPath: "/assets",
  outdir: path.join(__dirname, "output/assets"),
}

build(esbuildOptions)
