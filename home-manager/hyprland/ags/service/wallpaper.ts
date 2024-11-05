import { dependencies, sh } from "lib/utils"

const WP = `${Utils.HOME}/.local/share/animated_zelda_1_768p.gif`

class Wallpaper extends Service {
  static {
    Service.register(this, {}, {
      "wallpaper": ["string"],
    })
  }

  #blockMonitor = false

  #wallpaper() {
    if (!dependencies("swww")) {
      return
    }
    
    sh("hyprctl cursorpos").then(pos => {
      sh([
        "swww", "img",
        "--invert-y",
        "--transition-type", "grow",
        "--transition-pos", pos.replace(" ", ""),
        WP,
      ]).then(() => {
        this.changed("wallpaper")
      })
    })
  }

  async #setWallpaper(path: string) {
    this.#blockMonitor = true
    
    await sh(`cp ${path} ${WP}`)
    this.#wallpaper()

    this.#blockMonitor = false
  }

  readonly set = (path: string) => { this.#setWallpaper(path) }
  get wallpaper() { return WP }

  constructor() {
    super()

    if (!dependencies("swww")) {
      return this
    }

    // gtk portal
    Utils.monitorFile(WP, () => {
      if (!this.#blockMonitor)
        this.#wallpaper()
      })

    Utils.execAsync("swww-daemon -f xrgb")
        .then(this.#wallpaper)
        .catch(() => null)
  }
}

export default new Wallpaper
