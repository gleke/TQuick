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

#ifndef TCOLOR_H
#define TCOLOR_H

#include <QObject>
#include <QColor>
#include <QDebug>
#include <QQmlEngine>

class TColorPrivate;
class TColor : public QObject
{
    Q_OBJECT
    Q_DECLARE_PRIVATE(TColor)
    Q_DISABLE_COPY(TColor)

    Q_PROPERTY(QColor random READ getRandom NOTIFY randomChanged)
    Q_PROPERTY(QColor primary READ getPrimary NOTIFY primaryChanged)
    Q_PROPERTY(QColor primaryLight READ getPrimaryLight NOTIFY primaryLightChanged)
    Q_PROPERTY(QColor success READ getSuccess NOTIFY successChanged)
    Q_PROPERTY(QColor successLight READ getSuccessLight NOTIFY lightChanged)
    Q_PROPERTY(QColor warning READ getWarning NOTIFY warningChanged)
    Q_PROPERTY(QColor warningLight READ getWarningLight NOTIFY warningLightChanged)
    Q_PROPERTY(QColor danger READ getDanger NOTIFY dangerChanged)
    Q_PROPERTY(QColor dangerLight READ getDangerLight  NOTIFY dangerLightChanged)
    Q_PROPERTY(QColor info READ getInfo NOTIFY infoChanged)
    Q_PROPERTY(QColor infoLight READ getInfoLight NOTIFY infoLightChanged)

public:
    static TColor *getInstance();
    static QObject *qmlSingletonTypeProvider(QQmlEngine *engine, QJSEngine *scriptEngine);
    ~TColor();

    QColor getRandom() const;
    QColor getPrimary() const;
    QColor getPrimaryLight() const;
    QColor getSuccess() const;
    QColor getSuccessLight() const;
    QColor getWarning() const;
    QColor getWarningLight() const;
    QColor getDanger() const;
    QColor getDangerLight() const;
    QColor getInfo() const;
    QColor getInfoLight() const;

signals:
    void randomChanged();
    void primaryChanged();
    void primaryLightChanged();
    void successChanged();
    void lightChanged();
    void warningChanged();
    void warningLightChanged();
    void dangerChanged();
    void dangerLightChanged();
    void infoChanged();
    void infoLightChanged();

private:
    explicit TColor(QObject *parent = nullptr);
    TColorPrivate *d_ptr;
};


#endif // TCOLOR_H
