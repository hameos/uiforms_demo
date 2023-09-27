cmake_minimum_required(VERSION 3.16)

project(uiforms VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appuiforms
    main.cpp
)

find_package(Qt6 REQUIRED COMPONENTS Sql)
target_link_libraries(appuiforms PRIVATE Qt6::Sql)

qt_add_qml_module(appuiforms
    URI uiforms
    VERSION 1.0
    QML_FILES Main.qml
    QML_FILES qml/History.qml qml/HistoryForm.ui.qml qml/Notes.qml qml/NotesForm.ui.qml qml/Settings.qml qml/SettingsForm.ui.qml
    RESOURCES icons/cut_icon.png
    QML_FILES MainForm.ui.qml
    QML_FILES
    SOURCES mytablemodel.h mytablemodel.cpp
    SOURCES person.h person.cpp
    SOURCES
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appuiforms PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appuiforms
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appuiforms
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appuiforms
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
