import QtQuick 
import QtQuick.Layouts

import MMaterial.Controls as Controls
import MMaterial.UI as UI
import MMaterial.Media as Media
import MaterialTester.Components

ColumnLayout {
    id: groupRoot

    required property int buttonType
    required property string title

	UI.Subtitle1 {
        text: groupRoot.title
    }

    TitleRow {
        title.text: qsTr("Color")

		Controls.MButton {
            Layout.alignment: Qt.AlignLeft

            type: groupRoot.buttonType
			accent: UI.Theme.primary
            text: "Primary"


            onClicked: isLoading = !isLoading
        }

		Controls.MButton {
            type: groupRoot.buttonType
			accent: UI.Theme.secondary
            text: "Secondary"

            onClicked: isLoading = !isLoading
        }

		Controls.MButton {
            type: groupRoot.buttonType
			accent: UI.Theme.info
            text: "Info"

            onClicked: isLoading = !isLoading
        }

		Controls.MButton {
            type: groupRoot.buttonType
			accent: UI.Theme.success
            text: "Success"

            onClicked: isLoading = !isLoading
        }

		Controls.MButton {
            type: groupRoot.buttonType
			accent: UI.Theme.warning
            text: "Warning"

            onClicked: isLoading = !isLoading
        }

		Controls.MButton {
            type: groupRoot.buttonType
			accent: UI.Theme.error
            text: "Error"

            onClicked: isLoading = !isLoading
        }

        Controls.MButton {
            type: groupRoot.buttonType
            accent: UI.Theme.passive
            text: "Passive"

            onClicked: isLoading = !isLoading
        }
    }

    TitleRow {
        title.text: qsTr("States")

		Controls.MButton {
            type: groupRoot.buttonType
			accent: UI.Theme.primary
            text: mouseArea.containsMouse ? "Hovered" : "Enabled"
        }

		Controls.MButton {
            enabled: false
            type: groupRoot.buttonType
			accent: UI.Theme.primary
            text: "Disabled"
        }
    }

    TitleRow {
        title.text: qsTr("Icon")

		Controls.MButton {
            type: groupRoot.buttonType
			accent: UI.Theme.primary
			text: "Left Media.Icon"
            leftIcon.iconData: Media.Icons.heavy.logo
        }

		Controls.MButton {
            type: groupRoot.buttonType
			accent: UI.Theme.primary
			text: "Left and Right Media.Icon"
            leftIcon.iconData: Media.Icons.heavy.logo
            rightIcon.iconData: Media.Icons.heavy.logo
        }

		Controls.MButton {
            type: groupRoot.buttonType
			accent: UI.Theme.primary
			text: "Right Media.Icon"
            rightIcon.iconData: Media.Icons.heavy.logo
        }
    }

    TitleRow {
        title.text: qsTr("Size")

		Controls.MButton {
            type: groupRoot.buttonType
			accent: UI.Theme.primary
            size: UI.Size.Grade.L
            text: "Large"
        }

		Controls.MButton {
            type: groupRoot.buttonType
			accent: UI.Theme.primary
            size: UI.Size.Grade.M
            text: "Medium"
        }

		Controls.MButton {
            type: groupRoot.buttonType
			accent: UI.Theme.primary
            size: UI.Size.Grade.S
            text: "Small"
        }
    }

    Item { Layout.fillHeight: true; }
}
