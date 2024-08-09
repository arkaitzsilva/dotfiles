import "lib/session"
import "style/style"
import { forMonitors } from "lib/utils"
import options from "options"
import Bar from "widget/bar/Bar"

App.config({
  windows: () => [
    ...forMonitors(Bar),
  ],
})
