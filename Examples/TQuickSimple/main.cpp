#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QElapsedTimer>

#ifdef STATICLIB
#include <TQuickLoader>
#endif

int main(int argc, char *argv[])
{
    QElapsedTimer timer;
    timer.start();

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

#ifdef STATICLIB
    TQuickLoader::load(&engine);
#endif

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    qDebug() << "Startup time:"
             << timer.elapsed() << "ms";

    return app.exec();
}
