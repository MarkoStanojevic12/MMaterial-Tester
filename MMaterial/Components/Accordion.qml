import QtQuick 
import QtQuick.Layouts
import QtQuick.Effects

import "../Icons"
import "../Fonts/Texts"
import "../Colors"
import "../Settings"

Rectangle {
    id: _accordion

    property bool isOpen: false
    property real padding: Size.pixel20
    property string title: "Accordion Item"
    property string subtitle: "Donec id justo. Curabitur blandit mollis lacus. Vivamus quis mi. In ut quam vitae odio lacinia tincidunt. In consectetuer turpis ut velit."

    radius: 8
    clip: true
    color: Theme.background.paper

    layer{
        enabled: _accordion.isOpen
        effect: MultiEffect{
            shadowEnabled: true
            shadowBlur: 3
            shadowHorizontalOffset: 5
            shadowVerticalOffset: 5

        }
    }
    state: "closed"
    states: [
        State {
            name: "open"
            when: _accordion.isOpen
            PropertyChanges {
                target: _arrow
                rotation: 180
            }
            PropertyChanges {
                target: _accordion
                height: _title.contentHeight + _accordion.padding * 3 + _subtitle.contentHeight
            }
            PropertyChanges {
                target: _subtitle
                opacity: 1
            }

        },
        State {
            name: "closed"
            when: !_accordion.isOpen
            PropertyChanges {
                target: _arrow
                rotation: 0
            }
            PropertyChanges {
                target: _accordion
                height: _title.contentHeight + _accordion.padding * 2
            }
            PropertyChanges {
                target: _subtitle
                opacity: 0.0
            }
        }
    ]

    transitions: [
        Transition {
            from: "closed"
            to: "open"

            ParallelAnimation{
                NumberAnimation {
                    properties: "rotation"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    properties: "height"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    properties: "opacity"
                    duration: 200
                    easing.type: Easing.InExpo
                }
            }
        },
        Transition {
            from: "open"
            to: "closed"

            ParallelAnimation{
                NumberAnimation {
                    properties: "rotation"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    properties: "height"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    properties: "opacity"
                    duration: 200
                    easing.type: Easing.OutExpo
                }
            }
        }
    ]

    RowLayout {
        id: _titleLayout

        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
            margins: _accordion.padding
        }

        Subtitle1 {
            id: _title

            Layout.fillWidth: true

            verticalAlignment: Qt.AlignVCenter
            text: _accordion.title
            color: Theme.text.primary
            maximumLineCount: 1
        }

        Icon {
            id: _arrow

            sourceSize.width: Size.pixel14
            path: IconList.arrow
            interactive: true
            color: Theme.text.primary

            onClicked: _accordion.isOpen = !_accordion.isOpen
        }
    }

    B1{
        id: _subtitle

        anchors{
            top: _titleLayout.bottom; topMargin: _accordion.padding / 2
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            margins: _accordion.padding
        }

        verticalAlignment: Qt.AlignBottom
        color: Theme.text.primary
        text: _accordion.subtitle
        visible: opacity > 0
    }

    MouseArea {
        anchors.fill: parent

        cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
        hoverEnabled: true

        onClicked: _accordion.isOpen = !_accordion.isOpen
    }
}
