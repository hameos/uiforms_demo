#include <QQmlEngine>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>
#include <QScreen>
#include <QQuickItem>
#include <QQmlProperty>

#include "mytablemodel.h"

void centerWindow(const QQmlApplicationEngine& engine);

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<MyTableModel>("MyTableModel", 0, 1, "Roles");

    QQmlApplicationEngine engine;

    MyTableModel *tb = new MyTableModel();
    engine.rootContext()->setContextProperty("tb", tb);

    const QUrl url(u"qrc:/uiforms/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.load(url);

    centerWindow(engine);

    return app.exec();
}


void centerWindow(const QQmlApplicationEngine& engine) {
    // Get screen width and height
    QScreen *screen = QGuiApplication::primaryScreen();
    QRect screenGeometry = screen->geometry();
    int height = screenGeometry.height();
    int width = screenGeometry.width();

    // Get window frame width and height
    QObject* toplevel = engine.rootObjects().first();
    int appHeight = 0;
    int appWidth = 0;
    QVariant qw = qvariant_cast<QVariant>(QQmlProperty::read(toplevel, "width"));
    QVariant qh = qvariant_cast<QVariant>(QQmlProperty::read(toplevel, "height"));
    if ((qw.typeId() == QMetaType::Int) && (qh.typeId() == QMetaType::Int)) {
        appHeight = qh.toInt();
        appWidth = qw.toInt();
    }

    // Move window frame to the center of screen
    int x = (width - appWidth)/2;
    int y = (height - appHeight)/2;

    QQmlProperty::write(toplevel, "x", QVariant(x));
    QQmlProperty::write(toplevel, "y", QVariant(y));
}


