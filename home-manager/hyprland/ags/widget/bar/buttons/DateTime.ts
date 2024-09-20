import { clock } from "lib/variables"
import PanelButton from "../PanelButton"
import Spacer from "../Spacer"
import options from "options"

const { timeFormat, dateFormat } = options.bar.dateTime
const date = Utils.derive([clock, dateFormat], (c, f) => c.format(f) || "")
const time = Utils.derive([clock, timeFormat], (c, f) => c.format(f) || "")


export default () => PanelButton({
    /*window: "datemenu",
    on_clicked: action.bind(),*/
    child: Widget.Box({
        class_name: "datetime",
        orientation: "horizontal",
        children: [
            Widget.Label({
                class_name: "time",
                justification: "center",
                label: time.bind(),
            }),
            Spacer("•"),
            Widget.Label({
                class_name: "date",
                justification: "center",
                label: date.bind(),
            })
        ],
    }),
})
