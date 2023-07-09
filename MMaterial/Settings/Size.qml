import QtQuick 2.15

pragma Singleton

Item {
    property real scale: 1.0
    readonly property real pixel1: 1 * scale
    readonly property real pixel4: 4 * scale
    readonly property real pixel6: 6 * scale
    readonly property real pixel8: 8 * scale
    readonly property real pixel10: 10 * scale
    readonly property real pixel11: 11 * scale
    readonly property real pixel12: 12 * scale
    readonly property real pixel13: 13 * scale
    readonly property real pixel14: 14 * scale
    readonly property real pixel15: 15 * scale
    readonly property real pixel16: 16 * scale
    readonly property real pixel18: 18 * scale
    readonly property real pixel20: 20 * scale
    readonly property real pixel22: 22 * scale
    readonly property real pixel24: 24 * scale
    readonly property real pixel30: 30 * scale
    readonly property real pixel32: 32 * scale
    readonly property real pixel36: 36 * scale
    readonly property real pixel40: 40 * scale
    readonly property real pixel46: 46 * scale
    readonly property real pixel48: 48 * scale
    readonly property real pixel64: 64 * scale

    enum Grade {
        S,
        M,
        L,
        Custom
    }

    enum Format {
        Extended,
        Compact
    }

    property int format: Size.Format.Extended

}
