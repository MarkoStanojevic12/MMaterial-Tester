import QtQuick
import QtQuick.Layouts

import MMaterial.UI as UI
import MMaterial.Controls.Inputs as Inputs
import MaterialTester.Components

ColumnLayout {
    id: root

    required property string title

    property int columnCount: Window.width > (1920 * UI.Size.scale) ? 3 : (Window.width > 1180 * UI.Size.scale ? 2 : 1)

    UI.Subtitle1 {
        text: root.title
    }

    TitleRow {
        title.text: qsTr("Default")
        grid.columns: root.columnCount

        Inputs.SegmentedField {
            length: 5
        }

        Inputs.SegmentedField {
            length: 6
        }

        Inputs.SegmentedField {
            length: 4
        }
    }

    TitleRow {
        title.text: qsTr("Accent Colors")
        grid.columns: root.columnCount

        Inputs.SegmentedField {
            length: 4
            accent: UI.Theme.primary
        }

        Inputs.SegmentedField {
            length: 4
            accent: UI.Theme.secondary
        }

        Inputs.SegmentedField {
            length: 4
            accent: UI.Theme.success
        }

        Inputs.SegmentedField {
            length: 4
            accent: UI.Theme.warning
        }

        Inputs.SegmentedField {
            length: 4
            accent: UI.Theme.error
        }

        Inputs.SegmentedField {
            length: 4
            accent: UI.Theme.info
        }
    }

    TitleRow {
        title.text: qsTr("With Text")
        grid.columns: root.columnCount

        Inputs.SegmentedField {
            length: 4
            text: "1234"
            accent: UI.Theme.primary
            validator: RegularExpressionValidator { regularExpression: /^[A-Z0-9]$/ }
        }

        Inputs.SegmentedField {
            length: 6
            text: "ABC123"
            accent: UI.Theme.secondary
            validator: RegularExpressionValidator { regularExpression: /^[A-Z0-9]$/ }
        }

        Inputs.SegmentedField {
            length: 5
            text: "99999"
            accent: UI.Theme.success
            validator: RegularExpressionValidator { regularExpression: /^[A-Z0-9]$/ }
        }
    }

    TitleRow {
        title.text: qsTr("Disabled")
        grid.columns: root.columnCount

        Inputs.SegmentedField {
            length: 4
            enabled: false
        }

        Inputs.SegmentedField {
            length: 5
            text: "12345"
            enabled: false
        }

        Inputs.SegmentedField {
            length: 6
            text: "ABCDEF"
            enabled: false
            validator: RegularExpressionValidator { regularExpression: /^[A-Z]$/ }
        }
    }

    TitleRow {
        title.text: qsTr("Error State")
        grid.columns: root.columnCount

        Inputs.SegmentedField {
            length: 4
            acceptableInput: false
            accent: UI.Theme.error
        }

        Inputs.SegmentedField {
            length: 4
            text: "ERR0"
            acceptableInput: false
            accent: UI.Theme.error
        }
    }

    TitleRow {
        title.text: qsTr("Custom Sizing")
        grid.columns: root.columnCount

        Inputs.SegmentedField {
            length: 4
            segmentSize: UI.Size.pixel40
            fontSize: UI.Size.pixel24
            spacing: UI.Size.pixel4
        }

        Inputs.SegmentedField {
            length: 3
            segmentSize: UI.Size.pixel54
            fontSize: UI.Size.pixel32
            spacing: UI.Size.pixel16
        }

        Inputs.SegmentedField {
            length: 6
            segmentSize: UI.Size.pixel36
            fontSize: UI.Size.pixel20
            spacing: UI.Size.pixel6
        }
    }

    TitleRow {
        title.text: qsTr("Custom Validators")
        grid.columns: root.columnCount

        Inputs.SegmentedField {
            length: 4
            accent: UI.Theme.primary
            validator: RegularExpressionValidator { regularExpression: /^[0-9]$/ }
        }

        Inputs.SegmentedField {
            length: 4
            accent: UI.Theme.secondary
            validator: RegularExpressionValidator { regularExpression: /^[A-Z]$/ }
            inputMethodHints: Qt.ImhUppercaseOnly | Qt.ImhNoPredictiveText
        }

        Inputs.SegmentedField {
            length: 6
            accent: UI.Theme.info
            validator: RegularExpressionValidator { regularExpression: /^[A-Za-z0-9]$/ }
            inputMethodHints: Qt.ImhNoPredictiveText
        }
    }

    Item { Layout.fillHeight: true }
}
