cmake_minimum_required(VERSION 3.16)

project(OneClickCategorize VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appOneClickCategorize
    main.cpp
)

qt_add_qml_module(appOneClickCategorize
    URI OneClickCategorize
    VERSION 1.0
    QML_FILES
        Main.qml
        RESOURCES assets/fonts/Poppins-Black.ttf assets/fonts/Poppins-Bold.ttf assets/fonts/Poppins-Italic.ttf assets/fonts/Poppins-Medium.ttf assets/fonts/Poppins-Regular.ttf assets/fonts/Poppins-SemiBold.ttf assets/fonts/Poppins-Thin.ttf
        QML_FILES
        RESOURCES
        QML_FILES texts/HeadingText.qml
        QML_FILES texts/SubheadingText.qml
        QML_FILES components/InputArea.qml
        QML_FILES texts/InputText.qml
        RESOURCES assets/icons/icon_email.png assets/icons/icon_password.png
        RESOURCES assets/icons/icon_email.png assets/icons/icon_password.png
        RESOURCES assets/icons/icon_default.png
        RESOURCES assets/icons/icon_password_hidden.png assets/icons/icon_password_visible.png
        QML_FILES components/Button.qml
        QML_FILES texts/ButtonText.qml
        RESOURCES assets/buttons/button_auth_with_google.png
        QML_FILES screens/LoginScreen.qml
        QML_FILES screens/Dashboard.qml
        QML_FILES components/DashboardState_NoRecentRun.qml
        RESOURCES assets/logo/logo_placeholder.png
        QML_FILES components/DashboardState_HasRecentRun.qml
        QML_FILES components/Folder.qml
        QML_FILES components/FolderTextInput.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appOneClickCategorize PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appOneClickCategorize
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appOneClickCategorize
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appOneClickCategorize
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
