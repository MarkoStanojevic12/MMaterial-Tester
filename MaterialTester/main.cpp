#include <QDirIterator>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QString>

#include "DevTools/Clipboard.h"
#include "DevTools/CustomEngine.h"

using namespace Qt::Literals::StringLiterals;

int main(int argc, char *argv[])
{
	// qputenv("QSG_VISUALIZE", "batches");
	// qputenv("QSG_VISUALIZE", "overdraw");

	qputenv("MAIN_DIR","../../../MaterialTester");

	QGuiApplication app(argc, argv);

	// output qrc files:
	// {
	// 	qDebug() << "qrc files:";
	// 	QDirIterator it(":", QDirIterator::Subdirectories);
	// 	while (it.hasNext()) {
	// 		const auto path = it.next();
	// 		const auto file = QFile(path);
	// 		qDebug() << QString("%1 kb - %2")
	// 					.arg(file.size() / 1024, 6)
	// 					.arg(path);
	// 	}
	// }

	CustomEngine engine;
	Clipboard clipboard;

	engine.rootContext()->setContextProperty("QmlEngine", &engine);

#if defined(__wasm__) || !defined(QT_DEBUG)
    const QUrl url(u"qrc:/qt/qml/MaterialTester/Main.qml"_s);
#else
	const QUrl url(qgetenv("MAIN_DIR") + "/Main.qml");
#endif
	QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
					 &app, []() { QCoreApplication::exit(-1); },
	Qt::QueuedConnection);
	engine.load(url);

	return app.exec();
}
