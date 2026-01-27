pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import MMaterial.UI as UI
import MMaterial.Controls as Controls
import MMaterial.Controls.Inputs as Inputs

Item {
    objectName: "SegmentedField"

    ListView {
        id: listView

        anchors.fill: parent

        spacing: 80 * UI.Size.scale
        clip: true

        model: [
            { "category": "basic" },
            { "category": "interactive" }
        ]

        delegate: Item {
            id: del

            required property int index

            width: listView.width
            height: del.index === 0 ? segmentedFieldGroup.height : interactiveDemo.height

            SegmentedFieldGroup {
                id: segmentedFieldGroup
                visible: del.index === 0
                width: parent.width
                title: qsTr("Basic Examples")
            }

            ColumnLayout {
                id: interactiveDemo
                visible: del.index === 1
                width: parent.width
                spacing: UI.Size.pixel32

                UI.Subtitle1 {
                    text: qsTr("Interactive Demo")
                }

                RowLayout {
                    spacing: UI.Size.pixel32

                    ColumnLayout {
                        spacing: UI.Size.pixel12

                        UI.Caption {
                            text: qsTr("6-digit Verification Code")
                            color: UI.Theme.text.secondary
                        }

                        Inputs.SegmentedField {
                            id: codeField
                            length: 6
                            accent: UI.Theme.primary
                            validator: RegularExpressionValidator { regularExpression: /^[0-9]$/ }

                            onEditingFinished: statusText.text = qsTr("Code submitted: %1").arg(text)
                        }

                        Controls.MButton {
                            type: Controls.MButton.Type.Text
                            text: qsTr("Clear")
                            accent: UI.Theme.primary
                            onClicked: {
                                codeField.clear()
                                statusText.text = qsTr("Cleared")
                            }
                        }
                    }

                    ColumnLayout {
                        spacing: UI.Size.pixel12

                        UI.Caption {
                            text: qsTr("4-digit PIN")
                            color: UI.Theme.text.secondary
                        }

                        Inputs.SegmentedField {
                            id: pinField
                            length: 4
                            accent: UI.Theme.success
                            validator: RegularExpressionValidator { regularExpression: /^[0-9]$/ }

                            onEditingFinished: statusText.text = qsTr("PIN submitted: %1").arg(text)
                        }

                        Controls.MButton {
                            type: Controls.MButton.Type.Text
                            text: qsTr("Clear")
                            accent: UI.Theme.success
                            onClicked: {
                                pinField.clear()
                                statusText.text = qsTr("Cleared")
                            }
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: statusLayout.implicitHeight + UI.Size.pixel24
                    Layout.maximumWidth: 500 * UI.Size.scale

                    color: UI.Theme.background.paper
                    border.color: UI.Theme.other.divider
                    border.width: 1
                    radius: UI.Size.pixel8

                    ColumnLayout {
                        id: statusLayout
                        anchors {
                            fill: parent
                            margins: UI.Size.pixel12
                        }
                        spacing: UI.Size.pixel8

                        UI.Caption {
                            text: qsTr("Code: \"%1\" (%2/%3 characters)").arg(codeField.text).arg(codeField.text.length).arg(codeField.length)
                            color: UI.Theme.text.secondary
                        }

                        UI.Caption {
                            text: qsTr("PIN: \"%1\" (%2/%3 characters)").arg(pinField.text).arg(pinField.text.length).arg(pinField.length)
                            color: UI.Theme.text.secondary
                        }

                        UI.Caption {
                            id: statusText
                            text: qsTr("Enter a code or PIN above")
                            color: UI.Theme.primary.main
                        }
                    }
                }

                Item { Layout.fillHeight: true }
            }
        }
    }
}
