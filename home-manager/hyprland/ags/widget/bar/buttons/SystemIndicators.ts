import PanelButton from "../PanelButton"
import icons from "lib/icons"

const network = await Service.import("network")
const audio = await Service.import("audio")
const battery = await Service.import("battery")

const NetworkIndicator = () => Widget.Icon()
  .hook(network, self => {
    const icon = network[network.primary || "wifi"]?.icon_name
    self.icon = icon || ""
    self.visible = !!icon
    self.size = 22
  })

const AudioIndicator = () => Widget.Icon()
  .hook(audio.speaker, self => {
    const vol = audio.speaker.is_muted ? 0 : audio.speaker.volume
    const { muted, low, medium, high, overamplified } = icons.audio.volume
    const cons = [[101, overamplified], [67, high], [34, medium], [1, low], [0, muted]] as const
    self.icon = cons.find(([n]) => n <= vol * 100)?.[1] || ""
    self.size = 22
  })

const BatteryIndicator = () => Widget.Icon()
  .hook(battery, self => {
    self.icon = battery.icon_name
    self.size = 22
  })

export default () => PanelButton({
  /*window: "quicksettings",
  on_clicked: () => App.toggleWindow("quicksettings"),*/
  on_scroll_up: () => audio.speaker.volume += 0.02,
  on_scroll_down: () => audio.speaker.volume -= 0.02,
  class_name: "sysindicators",
  child: Widget.Box([
    NetworkIndicator(),
    AudioIndicator(),
    BatteryIndicator(),
  ]),
})