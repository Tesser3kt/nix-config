pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: root

    // Main keyboard name from hyprctl devices -j
    property string mainKeyboard: ""

    property var layoutCodes: []
    property var variantCodes: []

    property var available: []
    property var displayNames: available.map(x => x.display)

    // Processes
    Process {
        id: hyprctl
        running: false
    }

    Process {
        id: getMainKeyboard
        command: ["hyprctl", "devices", "-j"]
        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const data = JSON.parse(this.text);
                    const kb = (data.keyboards || []).find(k => k.main) || (data.keyboards || [])[0];
                    root.mainKeyboard = kb?.name || "";
                } catch (e) {
                    // do nothing
                }
            }
        }
    }

    Process {
        id: getKeyboardLayout
        command: ["hyprctl", "-j", "getoption", "input:kb_layout"]
        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const data = JSON.parse(this.text);
                    const layouts = data?.str?.split(",") || [];
                    root.layoutCodes = layouts.map(l => l.trim());
                    root.rebuildAvailable();
                } catch (e) {
                    // do nothing
                }
            }
        }
    }

    Process {
        id: getKeyboardVariant
        command: ["hyprctl", "-j", "getoption", "input:kb_variant"]
        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const data = JSON.parse(this.text);
                    const variants = data?.str?.split(",") || [];
                    root.variantCodes = variants.map(v => v.trim());
                    root.rebuildAvailable();
                } catch (e) {
                    // do nothing
                }
            }
        }
    }

    // Load XKB rules for long layout display names
    //
    // TODO
    Process {
        id: loadXkbRules
    }
}
