import options from "options"
import { bash, dependencies } from "lib/utils"

const deps = [ ];

const $ = (name: string, value: string | Opt<any>) => `$${name}: ${value};`

const variables = () => [
  $("bar-font", "\"Gabarito\", \"Popins\", \"Readex Pro\", \"Lexend\", sans-serif"),
  $("bar-bg", "#2B2C31"),
  $("bar-fg", "#F5F5F5"),
  $("bar-border", "#52565C"), // #0E0E10

  $("spacer", "0 4px"),
]

async function resetCss() {
  if (!dependencies("sass", "fd")) {
    return
  }  

  try {
    const vars = `${TMP}/variables.scss`
    const scss = `${TMP}/main.scss`
    const css = `${TMP}/main.css`

    const fd = await bash(`fd ".scss" ${App.configDir}`)
    const files = fd.split(/\s+/)
    const imports = [vars, ...files].map(f => `@import '${f}';`)

    await Utils.writeFile(variables().join("\n"), vars)
    await Utils.writeFile(imports.join("\n"), scss)
    await bash`sass ${scss} ${css}`

    App.applyCss(css, true)
  } catch (error) {
    error instanceof Error
        ? logError(error)
        : console.error(error)
  }
}

Utils.monitorFile(`${App.configDir}/style`, resetCss)
options.handler(deps, resetCss)
await resetCss()
