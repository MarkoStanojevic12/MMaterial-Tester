qt_add_qml_module(ShowcaseLib
    URI MaterialTester.Showcase
    VERSION 1.0
    STATIC
    OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/../MaterialTester/Showcase"
    QML_FILES
        FontShowcase.qml
        ColorShowcase.qml
        PaletteBasicView.qml
        ColorRect.qml
        BadgeShowcase.qml
        AccordionShowcase.qml
        ButtonShowcase.qml
        ButtonGroup.qml
        AlertShowcase.qml
        CustomAlert.qml
        ToggleButtonShowcase.qml
        AlertContainer.qml
        FabButtonShowcase.qml
        FABButtonGroup.qml
        CheckboxShowcase.qml
        ListItemShowcase.qml
        ListBorders.qml
        ProjectInfo.qml
        PaginationShowcase.qml
        CustomSwipeView.qml
        PaginatorArrowsShowcase.qml
        PaginatorBubbleShowcase.qml
        PaginatorSimpleShowcase.qml
        RadioButtonShowcase.qml
        ProgressShowcase.qml
        SwitchShowcase.qml
        TextFieldShowcase.qml
        TextFieldGroup.qml
        ComboBoxShowcase.qml
        ComboBoxGroup.qml
        IconShowcase.qml
        IconSpeedComparison.qml
        IconOverview.qml
        IconGeneratorTimer.qml
        SliderShowcase.qml
        RectangleShowcase.qml
        TabShowcase.qml
        MenuShowcase.qml
        AvatarShowcase.qml
        DialogShowcase.qml
        DateShowcase.qml
        TimeShowcase.qml
        BarChartShowcase.qml
        WaterfallChartShowcase.qml
        ColorPickerShowcase.qml
        BusyIndicatorShowcase.qml
        DownloadShowcase.qml
        MultiStateButtonShowcase.qml
        ToggleButtonGroupShowcase.qml
        SpinBoxShowcase.qml
        SegmentedFieldGroup.qml
        SegmentedFieldShowcase.qml
)

set_target_properties(ShowcaseLib PROPERTIES AUTOMOC ON)
target_link_libraries(ShowcaseLib PRIVATE Qt6::Quick)

target_compile_definitions(ShowcaseLib PRIVATE QT_QUICKCONTROLS_MATERIAL_STYLE)
