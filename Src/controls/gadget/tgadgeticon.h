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

#ifndef TGADGETICON_H
#define TGADGETICON_H

#include <QColor>
#include <QObject>

class TGadgetIconPrivate;
class TGadgetIcon : public QObject
{
    Q_OBJECT
    Q_DECLARE_PRIVATE(TGadgetIcon)
    Q_DISABLE_COPY(TGadgetIcon)

    Q_PROPERTY(int type READ getType WRITE setType NOTIFY typeChanged)
    Q_PROPERTY(QString source READ getSource WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(int width READ getWidth WRITE setWidth NOTIFY widthChanged)
    Q_PROPERTY(int height READ getHeight WRITE setHeight NOTIFY heightChanged)
    Q_PROPERTY(QColor color READ getColor WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(float scale READ getScale WRITE setScale NOTIFY scaleChanged)
    Q_PROPERTY(int position READ getPosition WRITE setPosition NOTIFY positionChanged)

public:
    explicit TGadgetIcon(QObject *parent = nullptr);
    ~TGadgetIcon();

    int getWidth() const;
    int getHeight() const;
    QColor getColor() const;
    float getScale() const;
    QString getSource() const;
    int getType() const;
    int getPosition() const;

signals:
    void widthChanged();
    void heightChanged();
    void colorChanged();
    void scaleChanged();
    void sourceChanged();
    void typeChanged(const int &iType);
    void positionChanged(const int &iPosition);

private slots:
    void setWidth(const int &iWidth);
    void setHeight(const int &iHeight);
    void setColor(const QColor &color);
    void setScale(const float &fScale);
    void setSource(const QString &strSource);
    void setType(const int &iType);
    void setPosition(const int &iPosition);

private:
    TGadgetIconPrivate *d_ptr;
};

#endif // TGADGETICON_H
