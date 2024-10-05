import "lib/session"
import "style/style"
import { forMonitors } from "lib/utils"
import Bar from "widget/bar/Bar"
import NotificationPopups from "widget/notifications/NotificationPopups"

App.config({
  windows: () => [
    ...forMonitors(Bar),
    ...forMonitors(NotificationPopups),
  ],
})
