import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

import MMaterial

import "./Showcase"
import "./Showcase/ColorShowcase"
import "./Showcase/IconShowcase"
import "./Showcase/AvatarShowcase"
import "./Showcase/ButtonShowcase"
import "./Showcase/AlertShowcase"
import "./Showcase/ListItemShowcase"
import "./Showcase/PaginationShowcase"
import "./Showcase/TextFieldShowcase"

import "./Components/AppSettings"
import "./Components/Sidebar"

Rectangle {
    id: _root

    color: Theme.background.main

    onWidthChanged: Size.format = Window.width > 800 ? Size.Format.Extended : Size.Format.Compact

    RowLayout {
        id: header

        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }

        height: 56 * Size.scale
        width: parent.width* 0.95

        spacing: Size.pixel14

        H6 {
            Layout.fillWidth: true

            text: showcaseLoader.currentItem ? showcaseLoader.currentItem.objectName : ""
            color: Theme.main.p500
            font.capitalization: Font.AllUppercase
        }

        Icon {
            iconData: Icons.light.settings
            size: header.height / 2
            interactive: true
            color: Theme.text.secondary

            onClicked: appSettings.toggle();
        }
    }

    Rectangle {
        anchors.bottom: _root.bottom

        height: 1
        width: _root.width

        color: Theme.other.divider
    }

    Loader {
        id: showcaseLoader

        anchors{
            margins: Size.pixel32
            leftMargin: Size.pixel46
            top: header.bottom
            bottom: _root.bottom
            left: sidebar.right
            right: _root.right
        }

        asynchronous: true
        sourceComponent: placeholder

        BusyIndicator{
            anchors.centerIn: showcaseLoader

            height: Size.pixel48 * 2
            width: height

            visible: showcaseLoader.status == Loader.Loading
            Material.accent: Theme.primary.main
        }
    }

    Component { id: placeholder; Placeholder{ } }
    Component { id: projectInfo; ProjectInfo{ } }
    Component { id: iconShowcase;  IconShowcase{ } }
    Component { id: fontShowcase;  FontShowcase{ } }
    Component { id: colorShowcase; ColorShowcase{ } }
    Component { id: avatarShowcase; AvatarShowcase{ } }
    Component { id: badgeShowcase; BadgeShowcase{ } }
    Component { id: accordionShowcase; AccordionShowcase{ } }
    Component { id: alertShowcase; AlertShowcase{ } }
    Component { id: listItemShowcase; ListItemShowcase{ } }
    Component { id: progressShowcase; ProgressShowcase{ } }
    Component { id: textFieldShowcase; TextFieldShowcase{ } }
    Component { id: dropdownShowcase; DropdownShowcase{ } }

    // Buttons
    Component { id: buttonShowcase; ButtonShowcase{  } }
    Component { id: toggleButtonShowcase; ToggleButtonShowcase{ } }
    Component { id: fabButtonShowcase; FabButtonShowcase{ } }
    Component { id: checkboxShowcase; CheckboxShowcase{ } }
    Component { id: radioButtonShowcase; RadioButtonShowcase{ } }
    Component { id: switchShowcase; SwitchShowcase{ } }

    // Pagination
    Component { id: paginationShowcase; PaginationShowcase{ } }
    Component { id: paginationArrowsShowcase; PaginatorArrowsShowcase{ } }
    Component { id: paginationBubbleShowcase; PaginatorBubbleShowcase{ } }
    Component { id: paginationSimpleShowcase; PaginatorSimpleShowcase{ } }

    AppSettings {
        id: appSettings
    }

    CustomSidebar {
        id: sidebar
    }
}

