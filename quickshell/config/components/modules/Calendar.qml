pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components

WrapperRectangle {
    id: root

    SystemClock {
        id: clock
        precision: SystemClock.Hours
    }

    implicitWidth: 300

    margin: 10

    property bool open: false
    property int expandedHeight: contentLayout.implicitHeight + 40

    Layout.preferredHeight: open ? expandedHeight : 0
    Layout.minimumHeight: 0
    Layout.maximumHeight: expandedHeight
    clip: true
    color: "transparent"

    Behavior on Layout.preferredHeight {
        NumberAnimation {
            duration: 250
            easing.type: Easing.OutCubic
        }
    }

    ColumnLayout {
        id: contentLayout

        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 20
        anchors.bottomMargin: 20

        spacing: 5

        RowLayout {
            id: monthYearRow
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.fillWidth: true
            Layout.fillHeight: false
            spacing: 8

            Text {
                id: monthYearText

                text: Qt.formatDateTime(clock.date, "MMMM")
                font {
                    family: Appearance.font.textFamily
                    pixelSize: Appearance.font.textPixelSize + 4
                    bold: true
                }
                color: Theme.nord7
            }

            Text {
                text: Qt.formatDateTime(clock.date, "yyyy")
                font {
                    family: Appearance.font.textFamily
                    pixelSize: Appearance.font.textPixelSize + 4
                }
                color: Theme.nord4
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: false
            implicitHeight: 10

            // A horizontal separator line
            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                implicitHeight: 2
                color: Theme.nord6
                opacity: 0.3
            }
        }

        RowLayout {
            id: weekdaysRow
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.fillWidth: true
            Layout.fillHeight: false
            spacing: 10

            Repeater {
                model: 7
                Layout.fillWidth: true

                WrapperRectangle {
                    required property int index

                    implicitWidth: 28
                    implicitHeight: 28
                    color: "transparent"

                    Text {
                        text: Qt.formatDateTime(new Date(2024, 0, parent.index + 1), "ddd")
                        font {
                            family: Appearance.font.textFamily
                            pixelSize: Appearance.font.textPixelSize
                        }
                        color: Theme.nord13
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }

        GridLayout {
            id: calendarGrid
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.fillWidth: true
            Layout.fillHeight: true
            columns: 7
            rowSpacing: 4
            columnSpacing: 10

            property int daysInMonth: {
                var year = clock.date.getFullYear();
                var month = clock.date.getMonth();
                return new Date(year, month + 1, 0).getDate();
            }

            property int firstDayOffset: {
                var year = clock.date.getFullYear();
                var month = clock.date.getMonth();
                return new Date(year, month, 1).getDay() - 1;
            }

            property int todayIndex: {
                var year = clock.date.getFullYear();
                var month = clock.date.getMonth();
                var today = new Date();
                if (year === today.getFullYear() && month === today.getMonth()) {
                    return today.getDate() - 1 + firstDayOffset;
                }
                return -1;
            }

            Repeater {
                model: parent.daysInMonth + parent.firstDayOffset

                WrapperRectangle {
                    required property int index

                    implicitWidth: 28
                    implicitHeight: 28
                    color: index === calendarGrid.todayIndex ? Theme.nord13 : "transparent"
                    radius: Appearance.itemRadius

                    Text {
                        text: {
                            var dayNumber = parent.index - calendarGrid.firstDayOffset + 1;
                            return (dayNumber > 0) ? dayNumber : "";
                        }
                        font {
                            family: Appearance.font.textFamily
                            pixelSize: Appearance.font.textPixelSize
                            bold: (parent.index === calendarGrid.todayIndex)
                        }
                        color: (parent.index === calendarGrid.todayIndex) ? Theme.nord3 : Theme.nord4
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }
}
