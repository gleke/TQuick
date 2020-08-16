#ifndef TQUICKWORLD_H
#define TQUICKWORLD_H

#include <QObject>
#include <QQuickItem>

/***
 * 整个框架中非常重要的一个类。
 * 除了可以初始化皮肤路径及设置启动皮肤外
 * TQuickWorld还对整个应用系统进行了初始化设置。
 * 并且他必须要创建在App ApplicationWindow 下面。
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
