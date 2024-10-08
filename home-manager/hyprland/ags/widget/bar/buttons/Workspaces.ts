import options from "options"
import { sh, range } from "lib/utils"

const hyprland = await Service.import("hyprland")
const { workspaces } = options.bar.workspaces

const dispatch = (arg: string | number) => {
  sh(`hyprctl dispatch workspace ${arg}`)
}

const Workspaces = (ws: number) => Widget.Box({
  children: range(ws || 20).map(i => Widget.Button({
    class_name: "workspaces button",
    on_clicked: () => dispatch(i),
    child: Widget.Icon({
      attribute: i,
      setup: self => self.hook(hyprland, () => {
        self.size = 16;
        if (hyprland.active.workspace.id === i) {
          self.icon = "workspace-active";
        } else if (hyprland.getWorkspace(i)?.windows > 0) {
          self.icon = "workspace-occupied";
        } else {
          self.icon = "workspace-empty";
        }
      }),
    }),
  })),
  setup: box => {
    if (ws === 0) {
      box.hook(hyprland.active.workspace, () => box.children.map(btn => {
        btn.visible = hyprland.workspaces.some(ws => ws.id === btn.child.attribute);
      }));
    }
  },
});


export default () => Widget.EventBox({
  class_name: "workspaces",
  on_scroll_up: () => dispatch("+1"),
  on_scroll_down: () => dispatch("-1"),  
  child: workspaces.bind().as(Workspaces),
})
