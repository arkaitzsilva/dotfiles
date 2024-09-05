import DateTime from "./buttons/DateTime"
import Workspaces from "./buttons/Workspaces"
import options from "options"

const { start, center, end } = options.bar.layout
const { transparent, position } = options.bar

const widget = {
  date: DateTime,
  workspaces: Workspaces,
  expander: () => Widget.Box({ expand: true }),
}

export default (monitor: number) => Widget.Window({
  monitor,
  class_name: "bar",
  name: `bar${monitor}`,
  exclusivity: "exclusive",
  anchor: position.bind().as(pos => [pos, "right", "left"]),
  child: Widget.CenterBox({
      css: "min-width: 2px; min-height: 2px;",
      startWidget: Widget.Box({
        class_name: "bar-section",
        hpack: "start",
        children: start.bind().as(s => s.map(w => widget[w]())),
      }),
      centerWidget: Widget.Box({
        class_name: "bar-section",
        hpack: "center",
        children: center.bind().as(c => c.map(w => widget[w]())),
      }),
      endWidget: Widget.Box({
        hpack: "end",
        children: end.bind().as(e => e.map(w => widget[w]())),
      }),
  }),
  setup: self => self.hook(transparent, () => {
      self.toggleClassName("transparent", transparent.value)
  }),
})
