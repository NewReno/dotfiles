import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Io
import qs.CustomTheme

FloatingWindow {
    id: root
    visible: false
    title: "Settings"
    implicitWidth: 600
    implicitHeight: 480
    color: Theme.background

    IpcHandler {
        target: "settings"
        function toggle(): void { root.visible = !root.visible }
    }

    Shortcut {
        sequence: "Escape"
        onActivated: { root.visible = false }
    }

    component AppRow: RowLayout {
        property string label: ""
        property string settingScript: ""
        property string currentValue: ""

        Layout.fillWidth: true
        spacing: 10

        Text {
            text: label
            color: Theme.on_background
            font.family: Theme.fontFamily
            font.pixelSize: 14
            Layout.preferredWidth: 100
        }

        Rectangle {
            Layout.fillWidth: true
            implicitHeight: 36
            radius: 6
            color: "transparent"
            border.color: Theme.primary
            border.width: 1

            Text {
                anchors { fill: parent; margins: 8 }
                text: currentValue
                color: Theme.primary
                font.family: Theme.fontFamily
                font.pixelSize: 13
                verticalAlignment: Text.AlignVCenter
            }
        }

        Button {
            text: "Change"
            implicitWidth: 70
            implicitHeight: 36
            background: Rectangle { color: "transparent"; border.color: Theme.primary; border.width: 1; radius: 6 }
            contentItem: Text {
                text: parent.text; color: Theme.primary; font.family: Theme.fontFamily
                font.pixelSize: 13; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter
            }
            onClicked: {
                Quickshell.execDetached(["gnome-text-editor", Quickshell.env("HOME") + "/.config/ml4w/settings/" + settingScript])
            }
        }
    }

    component FlavorButton: Button {
        property string flavorName: ""
        property string flavorIcon: ""

        implicitWidth: 100
        implicitHeight: 60
        background: Rectangle {
            color: "transparent"
            border.color: Theme.primary
            border.width: 1
            radius: 8
        }
        contentItem: ColumnLayout {
            spacing: 2
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: flavorIcon
                font.family: "monospace"
                font.pixelSize: 22
                color: Theme.primary
            }
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: flavorName
                font.family: Theme.fontFamily
                font.pixelSize: 12
                color: Theme.primary
            }
        }
        onClicked: {
            Quickshell.execDetached(["bash", "-c", Quickshell.env("HOME") + "/.config/catppuccin/theme-switcher.sh " + flavorName.toLowerCase()])
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "Settings"
            font.family: Theme.fontFamily
            font.pixelSize: 22
            font.bold: true
            color: Theme.primary
        }

        Rectangle { Layout.fillWidth: true; implicitHeight: 1; color: Theme.primary; opacity: 0.3 }

        Text {
            text: "Default Applications"
            font.family: Theme.fontFamily
            font.pixelSize: 16
            font.bold: true
            color: Theme.on_background
        }

        Text {
            text: "Edit these files to change default apps. Save and reload Hyprland to apply."
            color: Theme.on_background
            font.family: Theme.fontFamily
            font.pixelSize: 11
            opacity: 0.6
        }

        AppRow { label: "Terminal"; settingScript: "terminal.sh"; currentValue: "alacritty" }
        AppRow { label: "Browser"; settingScript: "browser.sh"; currentValue: "firefox" }
        AppRow { label: "Files"; settingScript: "filemanager"; currentValue: "thunar" }
        AppRow { label: "Editor"; settingScript: "editor.sh"; currentValue: "gnome-text-editor" }

        Rectangle { Layout.fillWidth: true; implicitHeight: 1; color: Theme.primary; opacity: 0.3 }

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "Catppuccin Theme"
            font.family: Theme.fontFamily
            font.pixelSize: 16
            font.bold: true
            color: Theme.on_background
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

        FlavorButton { flavorName: "Latte"; flavorIcon: "─" }
        FlavorButton { flavorName: "Frappe"; flavorIcon: "─" }
        FlavorButton { flavorName: "Macchiato"; flavorIcon: "─" }
        FlavorButton { flavorName: "Mocha"; flavorIcon: "─" }
        FlavorButton {
            flavorName: "Wallust"
            flavorIcon: "󰸉"
                implicitWidth: 100
                onClicked: {
                    Quickshell.execDetached(["bash", "-c", Quickshell.env("HOME") + "/.config/catppuccin/theme-switcher.sh wallust"])
                }
            }
        }

        Item { Layout.fillHeight: true }

        Text {
            text: "Changes to default apps require reload (Super+Ctrl+R)"
            color: Theme.on_background
            font.family: Theme.fontFamily
            font.pixelSize: 11
            opacity: 0.5
        }
    }
}
