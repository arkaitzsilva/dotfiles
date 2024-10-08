import { opt, mkOptions } from "lib/option"

const options = mkOptions(OPTIONS, {
  transition: opt(200),
  bar: {
    flatButtons: opt(true),
    position: opt<"top" | "bottom">("top"),
    corners: opt(50),
    transparent: opt(false),
    layout: {
        start: opt<Array<import("widget/bar/Bar").BarWidget>>([
          "workspaces",
        ]),
        center: opt<Array<import("widget/bar/Bar").BarWidget>>([
          "datetime",
        ]),
        end: opt<Array<import("widget/bar/Bar").BarWidget>>([
          "systray",
          "systemindicators",
        ]),
    },
    dateTime: {
      timeFormat: opt("%H:%M"),
      dateFormat: opt("%A, %d/%m"),
      /*action: opt(() => App.toggleWindow("datemenu")),*/
    },
    workspaces: {
      workspaces: opt(8),
    },
    systray: {
      ignore: opt([
          "KDE Connect Indicator",
          "spotify-client",
      ]),
    },
  },
  notifications: {
    position: opt<Array<"top" | "bottom" | "left" | "right">>(["top", "right"]),
    blacklist: opt(["Spotify"]),
    width: opt(440),
  },
})

globalThis["options"] = options
export default options
