import options from "options"
import { bash, dependencies } from "lib/utils"

const deps = [ ];

const $ = (name: string, value: string | Opt<any>) => `$${name}: ${value};`

const variables = () => [
  $("bar-font", "\"Gabarito\", \"Popins\", \"Readex Pro\", \"Lexend\", sans-serif"),
  $("bar-bg", "#1C1C1C"), // Bright: #2B2C31; dark: #0E0E10
  $("bar-fg", "#F5F5F5"),
  $("bar-border", "#404040"), // Bright: #52565C; Dark: #0E0E10
  $("bar-border-radius", "20px"),

  $("spacer-small", "0 2px"),
  $("spacer-medium", "0 4px"),
  $("spacer-big", "0 6px"),

  $("radius", "10px"),
  $("spacing", "4px"),
  $("padding", "4px"),
  $("bg", "#2B2C31"),
  $("fg", "#F5F5F5"),
  $("error-bg", "red"),
  $("border", "1px solid green"),
  $("shadow-color", "#000000"),
  $("popover-border-color", "#0E0E10"),
  $("popover-radius", "10px"),
  $("popover-padding", "10px"),
  $("shadows", "true"),
  $("border-width", "1px"),
  $("transition", "200ms"),
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
