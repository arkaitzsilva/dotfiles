import Quickshell
import QtQuick

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      property var modelData
      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: 34

      SystemClock {
        id: clock
        precision: SystemClock.Seconds
      }

      Text {
        text: Qt.formatDateTime(clock.date, "hh:mm:ss - dd/MM/yyyy")
        anchors.centerIn: parent
      }
    }
  }
}
