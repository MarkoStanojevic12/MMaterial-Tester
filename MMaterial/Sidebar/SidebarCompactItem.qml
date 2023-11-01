import QtQuick
import QtQuick.Controls

import MMaterial

Checkable {
    id: _root

    required property string category

    property alias icon: _icon
    property alias text: _title.text
    property bool isOpen: false
    property alias list: _listView
    property var model: []

    function selectItem() : void {
        if(typeof index !== "undefined")
            ListView.view.currentIndex = index;
        else if(typeof ObjectModel.index !== "undefined")
            ListView.view.currentIndex = ObjectModel.index;
    }

    implicitWidth: ListView.view ? ListView.view.width : 0
    implicitHeight: 54 * Size.scale

    radius: 8
    checked: ListView.isCurrentItem
    customCheckImplementation: true
    state: "checked"

    onVisibleChanged: { if(_contextMenu.opened){ _contextMenu.close(); }}
    onCheckedChanged: if(!checked){ _listView.currentIndex = -1; }
    onClicked: {
        if(_root.model.length > 0)
            _contextMenu.open();
        else
            selectItem();
    }

    states: [
        State {
            name: "disabled"
            when: !_root.enabled
            PropertyChanges{ target: _root; color: "transparent"; opacity: 0.64; }
            PropertyChanges { target: _title; font.family: PublicSans.regular; color: Theme.text.secondary }
            PropertyChanges{ target: _icon; color: Theme.text.secondary }
            PropertyChanges{ target: _arrow; color: Theme.text.secondary }
        },
        State {
            name: "checked"
            when: _root.checked
            PropertyChanges{ target: _root; color: _root.mouseArea.containsMouse ? Theme.primary.transparent.p16 : Theme.primary.transparent.p8; opacity: 1;}
            PropertyChanges { target: _title; font.family: PublicSans.semiBold; color: Theme.primary.main; }
            PropertyChanges{ target: _icon; color: Theme.primary.main }
            PropertyChanges{ target: _arrow; color: Theme.primary.main; }
        },
        State {
            name: "unchecked"
            when: !_root.checked
            PropertyChanges{ target: _root; color: _root.mouseArea.containsMouse ? Theme.background.neutral : "transparent"; opacity: 1;}
            PropertyChanges { target: _title; font.family: PublicSans.regular; color: Theme.text.secondary }
            PropertyChanges{ target: _icon; color: Theme.text.secondary }
            PropertyChanges{ target: _arrow; color: Theme.text.secondary }
        }
    ]

    Icon {
        id: _icon

        anchors {
            horizontalCenter: _root.horizontalCenter
            top: _root.top; topMargin: Size.pixel8
        }

        sourceSize.width: Size.pixel22
        color: Theme.primary.main
        path: IconList.star
    }

    B2 {
        id: _title

        anchors {
            horizontalCenter: _root.horizontalCenter
            bottom: _root.bottom; bottomMargin: Size.pixel4
        }

        width: _root.width
        height: Size.pixel16

        verticalAlignment: Qt.AlignVCenter
        horizontalAlignment: Qt.AlignHCenter

        font.pixelSize: Size.pixel10
    }

    Icon {
        id: _arrow

        anchors {
            verticalCenter: _icon.verticalCenter
            left: _icon.right; leftMargin: Size.pixel6
        }

        visible: _root.model ? _root.model.length > 0 : 0
        path: IconList.arrow
        rotation: -90

        sourceSize {
            height: Size.pixel6
            width: Size.pixel6
        }
    }

    //Popup
    Menu {
        id: _contextMenu

        x: _root.x + _root.width

        Repeater {
            model: _root.model

            ListItem {
                property var modelItem: _root.model[index]

                text: modelItem.text
                width: _listView.width

                onClicked: {
                    _root.selectItem();
                    modelItem.onClicked();
                    _contextMenu.close();
                }
            }

        }

        background: Rectangle {
            radius: 12
            color: Theme.background.main
            implicitWidth: 200
            implicitHeight: 0
            border.color: Theme.action.disabledBackground
        }

        contentItem: Item {
            id: _contentItem

            implicitHeight: _listView.contentHeight + Size.pixel8

            ListView {
                id: _listView

                anchors.centerIn: _contentItem

                width: _contentItem.width - Size.pixel8
                implicitHeight: contentHeight

                model: _contextMenu.contentModel
                interactive: Window.window
                             ? contentHeight + _contextMenu.topPadding + _contextMenu.bottomPadding > Window.window.height
                             : false
                clip: true
                currentIndex: _contextMenu.currentIndex

                ScrollIndicator.vertical: ScrollIndicator {}
            }
        }
    }
}
