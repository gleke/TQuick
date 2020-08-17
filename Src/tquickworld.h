#ifndef TQUICKWORLD_H
#define TQUICKWORLD_H

#include <QObject>
#include <QQuickItem>

/***
 * the class is very important in TQuick
 * class can do some setup work:
 *  1.add theme file dir
 *  2.set app start up theme
 *  3.enable generate theme template json file to make some different theme file
 *
 * TQuickWorld initilize the whole application system, so it must created in App ApplicationWindow.
 *
 * QML:
 * TQuickWorld{
 *       appStartupTheme: "dark"
 *       appThemePaths:[
 *           "qrc:/themes/"
 *       ]
 * }
 * */
class TQuickWorldPrivate;
class TQuickWorld : public QQuickItem
{
    Q_OBJECT
    Q_DECLARE_PRIVATE(TQuickWorld)
    Q_DISABLE_COPY(TQuickWorld)

    Q_PROPERTY(QString startupTheme READ getStartupTheme WRITE setStartupTheme)
    Q_PROPERTY(QStringList themeDirs READ getThemeDirs WRITE setThemeDirs)
    Q_PROPERTY(int mouseAreaCursorShape READ getMouseAreaCursorShape WRITE setMouseAreaCursorShape)
    Q_PROPERTY(bool generateThemeTemplateEnable READ isGenerateThemeTemplateEnable WRITE setGenerateThemeTemplateEnable)

public:
    TQuickWorld(QQuickItem* parent = nullptr);
    ~TQuickWorld();

    QStringList getThemeDirs() const;
    void setThemeDirs(const QStringList &strDirs);

    QString getStartupTheme() const;
    void setStartupTheme(const QString &strThemeName);

    int getMouseAreaCursorShape() const;
    void setMouseAreaCursorShape(const int &iShape);

    bool isGenerateThemeTemplateEnable() const;
    void setGenerateThemeTemplateEnable(const bool &bEnable);

private:
    TQuickWorldPrivate *d_ptr;
};

#endif // TQUICKWORLD_H
