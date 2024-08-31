#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "folderscanner.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<FolderScanner>("com.occ.FolderScanner", 1, 0, "FolderScanner");

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("OneClickCategorize", "Main");

    return app.exec();
}
