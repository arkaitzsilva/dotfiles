const hyprland = await Service.import("hyprland")
const network = await Service.import('network')
const audio = await Service.import("audio")
const battery = await Service.import("battery")
const systemtray = await Service.import('systemtray')

const date = Variable("", {
  poll: [1000, 'date "+%H:%M"'],
})

// widgets can be only assigned as a child in one container
// so to make a reuseable widget, make it a function
// then you can simply instantiate one by calling it
const dispatch = ws => hyprland.messageAsync(`dispatch workspace ${ws}`);

function Workspaces() { 
  return Widget.EventBox({
    onScrollUp: () => dispatch('+1'),
    onScrollDown: () => dispatch('-1'),
    child: Widget.Box({
      class_name: "workspaces",
      children: Array.from({ length: 20 }, (_, i) => i + 1).map(i => Widget.Button({
          attribute: i,
          label: `${i}`,
          onClicked: () => dispatch(i),
      })),

      setup: self => self.hook(hyprland, () => self.children.forEach(btn => {
          btn.visible = hyprland.workspaces.some(ws => ws.id === btn.attribute)
      })),
    }),
  })
}

function Clock() {
  return Widget.Label({
      class_name: "clock",
      label: date.bind(),
  })
}

function NetworkIndicator() {
  return Widget.Box({
    class_name: "indicator",
    child: Widget.Icon().hook(network, self => {
      const icon = network[network.primary || "wifi"]?.icon_name
      self.icon = "network-wireless-signal-good"
      self.size = 22
      self.visible = !!icon
    }),  
  })
}

function VolumeIndicator() {
  return Widget.Box({
    class_name: "indicator",
    child: Widget.Icon().hook(audio.speaker, self => {
        const vol = Math.round(audio.speaker.volume * 100)
        const icon = audio.speaker.is_muted ? 'muted' : [
            [101, 'overamplified'],
            [67, 'high'],
            [34, 'medium'],
            [1, 'low'],
            [0, 'muted'],
        ].find(([threshold]) => threshold <= vol)?.[1];

        self.icon = `audio-volume-${icon}`
        self.size = 22
        self.tooltip_text = `Volumen ${vol}%`
    }),
  })  
}

function BatteryIndicator() {
  return Widget.Box({
    class_name: "indicator",
    child: Widget.Icon().hook(battery, self => {
        const perc = battery.percent
        self.icon = 'battery-100-charging'
        /*
        if (battery.charging) {
          self.icon = `battery-level-${Math.floor(perc / 10) * 10}-charging-symbolic`;
        } else if (battery.charged) {
            self.icon = `battery-level-${Math.floor(perc / 10) * 10}-charged-symbolic`;
        } else {
            self.icon = `battery-level-${Math.floor(perc / 10) * 10}-symbolic`;
        }
            */

        self.size = 22
        self.tooltip_text = `Batería ${perc}%`
    }),
  })
}

function SysTray() {
  const SysTrayItem = item => Widget.Box({
    child: Widget.Icon().bind('icon', item, 'icon'),
    tooltipMarkup: item.bind('tooltip_markup'),
  });

  return Widget.Box({
      children: systemtray.bind('items').as(i => i.map(SysTrayItem))
  })
}

// layout of the bar
function Left() {
  return Widget.Box({
    class_name: "panel-section",
    hpack: "start",
    spacing: 4,
    children: [
      Workspaces(),
    ],
  })
}

function Center() {
  return Widget.Box({
    spacing: 4,
    children: [

    ],
  })
}

function Right() {
  return Widget.Box({
    class_name: "panel-section",
    hpack: "end",
    spacing: 4,
    children: [
      SysTray(),
      NetworkIndicator(),
      VolumeIndicator(),
      BatteryIndicator(),
      Clock(),
    ],
  })
}

function Bar(monitor = 0) {
  return Widget.Window({
    name: `bar-${monitor}`, // name has to be unique
    class_name: "bar",
    monitor,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: Left(),
      center_widget: Center(),
      end_widget: Right(),
    }),
  })
}

App.config({
  style: "./style.css",
  windows: [
    Bar(),
  ],
})

export { }
