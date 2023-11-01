import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import MMaterial

Item {
    id: _root

    implicitWidth: _decrementButton.width + _incrementButton.width + (Math.min(visiblePageCount, _listView.count) * (Size.pixel40 + _listView.spacing) + _listView.spacing)
    implicitHeight: Size.pixel40

    required property SwipeView indexView

    property int visiblePageCount: 3
    property int numberOfPages: indexView.count

    property int selectedType: MFabButton.Type.Soft
    property int radius: 10

    MFabButton {
        id: _decrementButton

        anchors.left: _root.left

        height: _root.height
        width: height

        horizontalPadding: 0
        verticalPadding: 0

        radius: _root.radius
        type: MFabButton.Type.Text
        enabled: _listView.currentIndex > 0
        accent: Theme.defaultNeutral

        leftIcon {
            rotation: 90
            path: IconList.arrow
            sourceSize.height: _listView.height * 0.15
        }

        onClicked: _root.indexView.decrementCurrentIndex();
    }

    ListView {
        id: _listView

        anchors{
            left: _decrementButton.right
            right: _incrementButton.left
            margins: _listView.spacing
        }

        height: _root.height

        model: _root.numberOfPages
        currentIndex: _root.indexView.currentIndex
        spacing: Size.pixel6
        orientation: ListView.Horizontal
        clip: true

        onCurrentIndexChanged: positionViewAtIndex(currentIndex, ListView.Center);

        delegate: MFabButton {
            height: _root.height
            width: height

            radius: _root.radius
            text: (modelData+1)
            accent: ListView.isCurrentItem ? Theme.primary : Theme.defaultNeutral
            type: ListView.isCurrentItem ? _root.selectedType : MFabButton.Type.Text

            horizontalPadding: 0
            verticalPadding: 0

            title.font {
                bold: ListView.isCurrentItem
                family: ListView.isCurrentItem ? PublicSans.semiBold : PublicSans.regular
            }

            onClicked: _root.indexView.currentIndex = index;

        }
    }

    MFabButton {
        id: _incrementButton

        anchors.right: _root.right

        height: _root.height
        width: height

        horizontalPadding: 0
        verticalPadding: 0

        radius: _root.radius
        accent: Theme.defaultNeutral
        type: MFabButton.Type.Text
        enabled: _listView.currentIndex < _listView.count-1

        leftIcon {
            rotation: -90
            path: IconList.arrow
            sourceSize.height: _listView.height * 0.15
        }

        onClicked: _root.indexView.incrementCurrentIndex();
    }
}
