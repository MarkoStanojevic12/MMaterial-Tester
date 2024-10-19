cmake_minimum_required(VERSION 3.16)

project(MaterialTester VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appMaterialTester
    main.cpp
)

qt_add_qml_module(appMaterialTester
    URI MaterialTester
    VERSION 1.0
    QML_FILES
        Main.qml
        MainWindow.qml
        Showcase/FontShowcase.qml
        Showcase/ColorShowcase/ColorShowcase.qml
        Showcase/ColorShowcase/PaletteBasicView.qml
        Showcase/ColorShowcase/ColorRect.qml
        Showcase/BadgeShowcase.qml
        Showcase/AccordionShowcase.qml
        Showcase/ButtonShowcase/ButtonShowcase.qml
        Showcase/ButtonShowcase/ButtonGroup.qml
        Showcase/AlertShowcase/AlertShowcase.qml
        Showcase/AlertShowcase/CustomAlert.qml
        Components/AppSettings/AppSettings.qml
        Showcase/ButtonShowcase/ToggleButtonShowcase.qml
        Components/Common/TitleRow.qml
        Showcase/AlertShowcase/AlertContainer.qml
        Components/AppSettings/SubTitle.qml
        Components/AppSettings/TwoChoices.qml
        Components/AppSettings/PresetButton.qml
        Showcase/ButtonShowcase/FabButtonShowcase.qml
        Showcase/ButtonShowcase/FABButtonGroup.qml
        Components/Sidebar/SimpleSidebar.qml
        Showcase/ButtonShowcase/CheckboxShowcase.qml
        Showcase/ListItemShowcase/ListItemShowcase.qml
        Showcase/ListItemShowcase/ListBorders.qml
        Showcase/ProjectInfo.qml
        Showcase/Placeholder.qml
        Showcase/PaginationShowcase/PaginationShowcase.qml
        Showcase/PaginationShowcase/CustomSwipeView.qml
        Showcase/PaginationShowcase/PaginatorArrowsShowcase.qml
        Showcase/PaginationShowcase/PaginatorBubbleShowcase.qml
        Showcase/PaginationShowcase/PaginatorSimpleShowcase.qml
        Showcase/ButtonShowcase/RadioButtonShowcase.qml
        Showcase/ProgressShowcase.qml
        Showcase/ButtonShowcase/SwitchShowcase.qml
        Showcase/TextFieldShowcase/TextFieldShowcase.qml
        Showcase/TextFieldShowcase/TextFieldGroup.qml
        Showcase/TextFieldShowcase/DropdownShowcase.qml
        Showcase/TextFieldShowcase/DropdownGroup.qml
        Showcase/IconShowcase/IconShowcase.qml
        Showcase/IconShowcase/IconSpeedComparison.qml
        Showcase/IconShowcase/IconOverview.qml
        Showcase/IconShowcase/IconGeneratorTimer.qml
        Showcase/SliderShowcase.qml
        Showcase/RectangleShowcase.qml
        Showcase/TabShowcase/TabShowcase.qml
        Showcase/MenuShowcase.qml
        Components/Sidebar/CustomSidebar.qml
        Showcase/AvatarShowcase.qml
        Showcase/DialogShowcase.qml
        Showcase/DateTimeShowcase.qml
        Showcase/ChartShowcase/BarChartShowcase.qml
        Showcase/ChartShowcase/WaterfallChartShowcase.qml

    SOURCES
        DevTools/FileWatcher.h
        DevTools/FileWatcher.cpp
        DevTools/CustomEngine.h
        DevTools/CustomEngine.cpp
        src/Icons/IconList.h
        src/Icons/IconList.cpp
        DevTools/Clipboard.h
)
set(QML_IMPORT_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../" ${CMAKE_BINARY_DIR}/imports CACHE STRING "MMaterial imports" FORCE)

# Add the QML import path to the QML_IMPORT_PATH environment variable
list(APPEND ENV{QML_IMPORT_PATH} "${QML_IMPORT_PATH}")

# Add the QML import path to the CMake include directories
include_directories(${QML_IMPORT_PATH})

add_subdirectory(../MMaterial ./MMaterial)

target_include_directories(appMaterialTester PUBLIC
                ${CMAKE_CURRENT_SOURCE_DIR}/src/Icons
            )

target_link_libraries(appMaterialTester
    PRIVATE Qt6::Quick Qt::Gui MMaterialLibplugin
)

set_target_properties(appMaterialTester PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

if (EMSCRIPTEN)

    set(MM_INSTALL_FILES
        "$<TARGET_FILE_DIR:appMaterialTester>/appMaterialTester.js"
        "$<TARGET_FILE_DIR:appMaterialTester>/appMaterialTester.wasm"
        "$<TARGET_FILE_DIR:appMaterialTester>/appMaterialTester.html"
        "$<TARGET_FILE_DIR:appMaterialTester>/qtloader.js"
    )

    # if (MM_ENABLE_THREADING)
    #     list(APPEND ALP_INSTALL_FILES "$<TARGET_FILE_DIR:alpineapp>/alpineapp.worker.js")
    # endif()
    install(FILES ${MM_INSTALL_FILES} DESTINATION ${CMAKE_INSTALL_PREFIX})
else()
    install(TARGETS appMaterialTester
        BUNDLE DESTINATION .
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    )

    install(TARGETS appMaterialTester
        BUNDLE DESTINATION .
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    )
endif()

