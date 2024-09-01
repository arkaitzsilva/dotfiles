import { opt, mkOptions } from "lib/option"

const options = mkOptions(OPTIONS, {
  bar: {
    flatButtons: opt(true),
    position: opt<"top" | "bottom">("top"),
    corners: opt(50),
    transparent: opt(false),
    layout: {
        start: opt<Array<import("widget/bar/Bar").BarWidget>>([
            
        ]),
        center: opt<Array<import("widget/bar/Bar").BarWidget>>([
          "date",
        ]),
        end: opt<Array<import("widget/bar/Bar").BarWidget>>([

        ]),
    },
    date: {
      format: opt("%A %d %b - %H:%M"),
      /*action: opt(() => App.toggleWindow("datemenu")),*/
    },
  },
})

globalThis["options"] = options
export default options
