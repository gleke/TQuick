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

#ifndef TTHEMEHANDLER_H
#define TTHEMEHANDLER_H

#include <QObject>

class TThemeHandlerPrivate;
class TThemeHandler : public QObject
{
    Q_OBJECT
    Q_DECLARE_PRIVATE(TThemeHandler)
    Q_DISABLE_COPY(TThemeHandler)

public:
    explicit TThemeHandler(const QString &strName, const QString &strPath);
    ~TThemeHandler();

    QString getThemeName();
    QString getThemePath();
    QString getLastError();
    bool isValid();
    bool isLoad();

    QVariant getPropertyData(const QString &strFieldKey, const QString &strPropertyKey);
    const QMap<QString, QVariantMap> getThemeData();
    const QVariantMap getThemeInfo();

signals:
    void themeDataChanged();

private:
    friend class TThemeManager;
    void setLastError(const QString &strText);
    void setThemeData(const QMap<QString, QVariantMap> &data);
    TThemeHandlerPrivate *d_ptr;
};

#endif // TTHEMEHANDLER_H
