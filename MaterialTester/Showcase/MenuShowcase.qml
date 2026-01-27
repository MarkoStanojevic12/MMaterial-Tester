import QtQuick
import QtQuick.Controls.Material

import MMaterial.UI as UI
import MMaterial.Controls as Controls
import MMaterial.Media as Media

Item {
    id: _root

	UI.B1 {
        text: qsTr("Right click anywhere")
        anchors.fill: _root
        verticalAlignment: Qt.AlignVCenter
        horizontalAlignment: Qt.AlignHCenter
		color: UI.Theme.text.primary
    }

    TapHandler {
        acceptedButtons: Qt.RightButton
        onTapped: (eventPoint, button) => _menu.popup(eventPoint)
    }

	Controls.Menu {
        id: _menu

		Action {
            text: "Action"
        }

		Controls.MenuItem {
            text: "Menu Item"
        }

		Controls.MenuItem {
            enabled: false
            text: "Disabled Menu Item"
        }

		Controls.MenuItem {
            text: "Icon Menu Item"
			iconData: Media.Icons.light.bluetooth
        }

		Controls.MenuItem {
            enabled: false
            text: "Disabled Media.Icon Menu Item"
			iconData: Media.Icons.light.bluetooth
        }

		Controls.MenuSeparator {}

		Controls.MenuItem {
            text: "Menu Item Checked"
            checked: true
            checkable: true
        }

		Controls.MenuItem {
            text: "Icon Menu Item Checked"
			iconData: Media.Icons.light.bluetooth
            checkable: true
            checked: true
        }

		Controls.MenuItem {
            text: "Disabled Media.Icon Menu Item Checked"
			iconData: Media.Icons.light.bluetooth
            checkable: true
            checked: true
            enabled: false
        }

		Controls.MenuSeparator {}

		Controls.Menu {
            title: "Nested menu"

			Controls.MenuItem {
                text: "Nested item"
            }
        }

		Controls.Menu {
            title: "Double Nested menu"

			Controls.Menu {
                title: "First Layer"

				Controls.MenuItem {
                    text: "Nested item"
                }
            }
        }
    }
}
