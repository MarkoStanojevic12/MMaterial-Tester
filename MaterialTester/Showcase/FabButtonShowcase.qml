pragma ComponentBehavior: Bound

import QtQuick

import MMaterial.UI as UI
import MMaterial.Controls as Controls

Item {
    objectName: "FAB Button"

    ListView {
        id: listView

        anchors.fill: parent

        spacing: 80 * UI.Size.scale
        clip: true

        model: [
			{ "type": Controls.MButton.Type.Contained, "name" : "Contained Button" },
			{ "type": Controls.MButton.Type.Outlined, "name" : "Outlined Button" },
			{ "type": Controls.MButton.Type.Text, "name" : "Text Button" },
			{ "type": Controls.MButton.Type.Soft, "name" : "Soft Button" }

        ]

        delegate: Item {
			id: del

			required property int index

            width: listView.width
            height: buttonGroup.height

            FABButtonGroup {
                id: buttonGroup

                width: listView.width

				buttonType: listView.model[del.index].type
				title: listView.model[del.index].name
            }
        }
    }
}
