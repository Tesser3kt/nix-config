import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components.modules.bar
import qs.components.modules.popups

RowLayout {
    id: root

    spacing: Appearance.itemSpacing
    anchors.verticalCenter: parent.verticalCenter

    Clock {
        id: clockModule

        backgroundColor: Theme.nord7
        iconColor: Theme.nord0
        textColor: Theme.nord0
        hoverEnabled: true
    }
}
