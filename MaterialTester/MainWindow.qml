import QtQuick
import QtQuick.Layouts

import MaterialTester.Showcase
import MaterialTester.Components

import MMaterial.Controls
import MMaterial.Controls.Sidebar
import MMaterial.Media as Media
import MMaterial.UI as UI

Rectangle {
	id: _root

	function setSizeFormat() {
		UI.Size.autoSetFormat(Window.width, Window.height)
	}

	color: UI.Theme.background.main

	onWidthChanged: sizeFormatTime.restart()
	onHeightChanged: sizeFormatTime.restart()

	Timer {
		id: sizeFormatTime
		interval: 150
		onTriggered: _root.setSizeFormat()
	}

	RowLayout {
		id: header

		anchors {
			top: parent.top
			horizontalCenter: parent.horizontalCenter
		}

		height: 56 * UI.Size.scale
		width: parent.width * 0.95

		spacing: UI.Size.pixel14

		UI.H6 {
			Layout.fillWidth: true

			text: showcaseLoader.currentItem ? showcaseLoader.currentItem.objectName : ""
			color: UI.Theme.main.p500
			font.capitalization: Font.AllUppercase
		}

		Media.Icon {
			iconData: Media.Icons.light.settings
			size: header.height / 2
			interactive: true
			color: UI.Theme.text.secondary.toString()

			onClicked: appSettings.toggle();
		}
	}

	MLoader {
		id: showcaseLoader
		objectName: "Main Loader"

		asynchronous: true
		sourceComponent: placeholder
	}

	Component { id: placeholder; Placeholder{ } }
	Component { id: projectInfo; ProjectInfo{ } }
	Component { id: iconShowcase; IconShowcase{ } }
	Component { id: fontShowcase; FontShowcase{ } }
	Component { id: colorShowcase; ColorShowcase{ } }
	Component { id: badgeShowcase; BadgeShowcase{ } }
	Component { id: accordionShowcase; AccordionShowcase{ } }
	Component { id: alertShowcase; AlertShowcase{ } }
	Component { id: listItemShowcase; ListItemShowcase{ } }
	Component { id: progressShowcase; ProgressShowcase{ } }
	Component { id: textFieldShowcase; TextFieldShowcase{ } }
	Component {id: segmentFieldShowcase; SegmentedFieldShowcase{ }}
	Component { id: comboboxShowcase; ComboBoxShowcase{ } }
	Component { id: sliderShowcase; SliderShowcase{ } }
	Component { id: rectangleShowcase; RectangleShowcase{ } }
	Component { id: menuShowcase; MenuShowcase{ } }
	Component { id: avatarShowcase; AvatarShowcase{ } }
	Component { id: dialogShowcase; DialogShowcase{ } }
	Component { id: dateShowcase; DateShowcase{ } }
	Component { id: timeShowcase; TimeShowcase{ } }
	Component { id: colorPickerShowcase; ColorPickerShowcase{ } }
	Component { id: busyIndicatorShowcase; BusyIndicatorShowcase{ } }

	// Charts
	Component { id: barChartShowcase; BarChartShowcase{ } }
	Component { id: waterfallChartShowcase; WaterfallChartShowcase{ } }

	// Buttons
	Component { id: buttonShowcase; ButtonShowcase{  } }
	Component { id: toggleButtonShowcase; ToggleButtonShowcase{ } }
	Component { id: fabButtonShowcase; FabButtonShowcase{ } }
	Component { id: checkboxShowcase; CheckboxShowcase{ } }
	Component { id: radioButtonShowcase; RadioButtonShowcase{ } }
	Component { id: switchShowcase; SwitchShowcase{ } }
	Component { id: tabShowcase; TabShowcase{ } }
	Component { id: multiStateButtonShowcase; MultiStateButtonShowcase{ } }
	Component { id: toggleButtonGroupShowcase; ToggleButtonGroupShowcase{ } }
	Component { id: spinBoxShowcase; SpinBoxShowcase{ } }

	// Pagination
	Component { id: paginationShowcase; PaginationShowcase{ } }
	Component { id: paginationArrowsShowcase; PaginatorArrowsShowcase{ } }
	Component { id: paginationBubbleShowcase; PaginatorBubbleShowcase{ } }
	Component { id: paginationSimpleShowcase; PaginatorSimpleShowcase{ } }

	// Network
	Component { id: downloadShowcase; DownloadShowcase{ } }

	AppSettings {
		id: appSettings
	}

	Sidebar {
		id: sidebar

		mainView: showcaseLoader
		name: "John Doe"
		role: "Admin"

		SidebarItem {
			text: "Project";
			icon: Media.Icons.light.info;
			category: "introduction"

			onClicked: () => { showcaseLoader.sourceComponent = projectInfo }
		}

		SidebarItem {
			text: "Core";
			icon: Media.Icons.light.dashboard;
			category: "components"

			model: [
				{text : "Icons", onClicked: function(){ showcaseLoader.sourceComponent = iconShowcase }},
				{text : "Fonts", onClicked: function(){ showcaseLoader.sourceComponent = fontShowcase }},
				{text : "Colors", onClicked: function(){ showcaseLoader.sourceComponent = colorShowcase }},
			];
		}

		SidebarItem {
			text: "Buttons";
			icon: Media.Icons.light.sportsEsports;
			category: "components"
			model: [
				{text : "Basic", onClicked: function(){ showcaseLoader.sourceComponent = buttonShowcase }},
				{text : "Fab", onClicked: function(){ showcaseLoader.sourceComponent = fabButtonShowcase }},
				{text : "Toggle", onClicked: function(){ showcaseLoader.sourceComponent = toggleButtonShowcase }},
				{text : "Checkbox", onClicked: function(){ showcaseLoader.sourceComponent = checkboxShowcase }},
				{text : "Radio", onClicked: function(){ showcaseLoader.sourceComponent = radioButtonShowcase }},
				{text : "Switch", onClicked: function(){ showcaseLoader.sourceComponent = switchShowcase }},
				{text : "Tab", onClicked: function(){ showcaseLoader.sourceComponent = tabShowcase }},
				{text : "MultiState", onClicked: function(){ showcaseLoader.sourceComponent = multiStateButtonShowcase }},
				{text : "ToggleButtonGroup", onClicked: function(){ showcaseLoader.sourceComponent = toggleButtonGroupShowcase }},
				{text : "SpinBox", onClicked: function(){ showcaseLoader.sourceComponent = spinBoxShowcase }}
			];
		}

		SidebarItem {
			text: "Pagination";
			icon: Media.Icons.light.fastForward;
			category: "components"
			model: [
				{text : "Basic", onClicked: function(){ showcaseLoader.sourceComponent = paginationShowcase }},
				{text : "Simple", onClicked: function(){ showcaseLoader.sourceComponent = paginationSimpleShowcase }},
				{text : "Bubble", onClicked: function(){ showcaseLoader.sourceComponent = paginationBubbleShowcase }},
				{text : "Arrows", onClicked: function(){ showcaseLoader.sourceComponent = paginationArrowsShowcase }}
			];
		}

		SidebarItem {
			text: "Controls";
			icon: Media.Icons.light.category;
			category: "components"
			model: [
				{text : "ListItems", onClicked: function(){ showcaseLoader.sourceComponent = listItemShowcase}},
				{text : "Progress", onClicked: function(){ showcaseLoader.sourceComponent = progressShowcase}},
				{text : "TextField", onClicked: function(){ showcaseLoader.sourceComponent = textFieldShowcase }},
				{text : "SegmentedField", onClicked: function(){ showcaseLoader.sourceComponent = segmentFieldShowcase }},
				{text : "ComboBox", onClicked: function(){ showcaseLoader.sourceComponent = comboboxShowcase }},
				{text : "Slider", onClicked: function(){ showcaseLoader.sourceComponent = sliderShowcase }},
				{text : "Menu", onClicked: function(){ showcaseLoader.sourceComponent = menuShowcase }},
				{text : "Date Picker", onClicked: function(){ showcaseLoader.sourceComponent = dateShowcase }},
				{text : "Time Picker", onClicked: function(){ showcaseLoader.sourceComponent = timeShowcase }},
				{text : "Color Picker", onClicked: function(){ showcaseLoader.sourceComponent = colorPickerShowcase }}
			];
		}

		SidebarItem {
			text: "Notifications";
			icon: Media.Icons.light.send;
			category: "components"
			model: [
				{text : "Alerts", onClicked: function(){ showcaseLoader.sourceComponent = alertShowcase}},
				{text : "Dialogs", onClicked: function(){ showcaseLoader.sourceComponent = dialogShowcase}},
			];
		}

		SidebarItem {
			text: "Charts";
			icon: Media.Icons.light.barChart;
			category: "components"
			model: [
				{text : "Bar Chart", onClicked: function(){ showcaseLoader.sourceComponent = barChartShowcase}},
				{text : "Waterfall Chart", onClicked: function(){ showcaseLoader.sourceComponent = waterfallChartShowcase}},
			];
		}

		SidebarItem {
			text: "Other";
			icon: Media.Icons.light.atr;
			category: "components"

			chip {
				text: qsTr("New")
				accent: UI.Theme.info
			}

			model: [
				{text : "Badge", onClicked: function(){ showcaseLoader.sourceComponent = badgeShowcase}},
				{text : "Accordion", onClicked: function(){ showcaseLoader.sourceComponent = accordionShowcase}},
				{text : "Avatar", onClicked: function(){ showcaseLoader.sourceComponent = avatarShowcase }, "chip" : Qt.platform.os === "wasm" ? { "text" : qsTr("Non-WASM"), "accent": UI.Theme.warning } : null},
				{text : "BusyIndicator", onClicked: function(){ showcaseLoader.sourceComponent = busyIndicatorShowcase }},
				{text : "Download", onClicked: function(){ showcaseLoader.sourceComponent = downloadShowcase }, "chip" : Qt.platform.os === "wasm" ? { "text" : qsTr("Non-WASM"), "accent": UI.Theme.warning } : null}
			];
		}
	}

	AlertGenerator {
		id: alertsController

		width: parent.width > 400 ? 400 * UI.Size.scale : parent.width * 0.9
		edgeOf: Item.BottomRight
	}
}

