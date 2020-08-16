/****************************************************************************
**
** Library: TQuick
**
** MIT License
**
** Copyright (c) 2019 toou http://www.toou.net
** Copyright (c) 2020 chengxuewen <1398831004@qq.com>
**
** Permission is hereby granted, free of charge, to any person obtaining a copy
** of this software and associated documentation files (the "Software"), to deal
** in the Software without restriction, including without limitation the rights
** to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
** copies of the Software, and to permit persons to whom the Software is
** furnished to do so, subject to the following conditions:
**
** The above copyright notice and this permission notice shall be included in all
** copies or substantial portions of the Software.
**
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
** IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
** AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
** OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
** SOFTWARE.
**
****************************************************************************/

#ifndef QTKSTYLEFRAMEWORK_H
#define QTKSTYLEFRAMEWORK_H

#include <QObject>
#include <QQmlEngine>
#include <QQuickWindow>

class TThemeBinder;
class TThemeHandler;
class TThemeManagerPrivate;
class TThemeManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool generateThemeTemplateEnable READ isGenerateThemeTemplateEnable WRITE setGenerateThemeTemplateEnable)
    Q_PROPERTY(bool currentThemeValid READ isCurrentThemeValid NOTIFY currentThemeValidChanged)
    Q_PROPERTY(QVariantList themeList READ getThemeList NOTIFY themeListChanged)
    Q_PROPERTY(QString currentTheme READ getCurrentTheme WRITE setCurrentTheme NOTIFY currentThemeChanged)

public:
    ~TThemeManager();
    static QObject *qmlSingletonTypeProvider(QQmlEngine *engine, QJSEngine *scriptEngine);
    static TThemeManager *getInstance();

    bool isGenerateThemeTemplateEnable() const;
    bool isCurrentThemeValid() const;
    bool addThemeDir(const QString &strDir);
    bool addTheme(const QString &strPath);

    QVariantList getThemeList() const;
    QString getCurrentTheme() const;
    QString getStartupTheme() const;
    QString getLastError() const;
    QVariant getPropertyData(const QString &strFieldKey, const QString &strProperty);

    void generateThemeTemplateFile(TThemeBinder *pBinder = nullptr);

public Q_SLOTS:
    void setCurrentTheme(const QString &strTheme);
    void setStartupTheme(const QString &strTheme);
    void setGenerateThemeTemplateEnable(const bool &bEnable);

Q_SIGNALS:
    void themeListChanged();
    void currentThemeChanged();
    void currentThemeValidChanged();

private:
    friend class TThemeBinder;
    TThemeManagerPrivate *d_ptr;
    explicit TThemeManager(QObject *parent = nullptr);
    void newThemeBinder(TThemeBinder *pBinder);
};

#endif // QTKSTYLEFRAMEWORK_H
