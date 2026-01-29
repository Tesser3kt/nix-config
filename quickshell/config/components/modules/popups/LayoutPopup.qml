import Quickshell
import QtQuick.Layouts
import QtQuick
import QtQuick.Controls
import qs.components.modules.popups
import qs.components.modules
import qs.components.util
import qs.components
import qs.config

PopupWrapper {
    id: popup

    content: ColumnLayout {
        spacing: 4

        BarText {
            id: layoutText
            Layout.alignment: Qt.AlignHCenter

            icon: "󰌌"
            text: KeyboardLayout.layoutName
            iconColor: Theme.nord4
            textColor: Theme.nord4
        }

        LayoutSelector {
            id: layoutSelector
        }
    }
}
