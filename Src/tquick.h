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

#ifndef TQUICK_H
#define TQUICK_H

#include <QQmlEngine>
#include <QQuickWindow>
#include <QObject>
#include <QScopedPointer>

class TQuickWorld;
class TQuickPrivate;
class TQuick : public QObject
{
    Q_OBJECT
    Q_DECLARE_PRIVATE(TQuick)
    Q_DISABLE_COPY(TQuick)

public:
    ~TQuick();
    static QObject *qmlSingletonTypeProvider(QQmlEngine *engine, QJSEngine *scriptEngine);
    static TQuick *getInstance();

    Q_INVOKABLE QString version() const;
    Q_INVOKABLE QString awesomeFromKey(const QString &strKey);
    Q_INVOKABLE QString awesomeFromValue(int type);
    Q_INVOKABLE QStringList awesomelist();

    void registerTypes(const char *uri);
    void initializeEngine(QQmlEngine *pEngine, const char *uri);
    void initQuickRoot(QQuickWindow *pRoot);
    void initWorld(TQuickWorld *pWorld);

    void setStartupTheme(const QString &strName);
    void addThemeDir(const QString &strDir);
    void addTheme(const QString &strPath);

    Q_INVOKABLE int mouseAreaCursorShape();
    void setMouseAreaCursorShape(const Qt::CursorShape &eCursor);

private:
    TQuick();
    QScopedPointer<TQuickPrivate> d_ptr;
};

#endif // TQUICK_H
