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

#ifndef TGADGETBACKGROUND_H
#define TGADGETBACKGROUND_H

#include <QColor>
#include <QObject>

class TGadgetBackgroundPrivate;
class TGadgetBackground : public QObject
{
    Q_OBJECT
    Q_DECLARE_PRIVATE(TGadgetBackground)
    Q_DISABLE_COPY(TGadgetBackground)

    Q_PROPERTY(int width READ getWidth WRITE setWidth NOTIFY widthChanged)
    Q_PROPERTY(int height READ getHeight WRITE setHeight NOTIFY heightChanged)
    Q_PROPERTY(float scale READ getScale WRITE setScale NOTIFY scaleChanged)
    Q_PROPERTY(QColor color READ getColor WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(int radius READ getRadius WRITE setRadius NOTIFY radiusChanged)
    Q_PROPERTY(float opacity READ getOpacity WRITE setOpacity NOTIFY opacityChanged)
    Q_PROPERTY(bool visible READ isVisible WRITE setVisible NOTIFY visibleChanged)

public:
    explicit TGadgetBackground(QObject *parent = nullptr);
    ~TGadgetBackground();

    QColor getColor() const;
    float getScale() const;
    float getOpacity() const;
    bool isVisible() const;
    int getRadius() const;
    int getWidth() const;
    int getHeight() const;

signals:
    void scaleChanged();
    void radiusChanged();
    void colorChanged();
    void visibleChanged();
    void widthChanged();
    void heightChanged();
    void opacityChanged();

private slots:
    void setWidth(const int &iWidth);
    void setHeight(const int &iHeight);
    void setOpacity(const float &fOpacity);
    void setScale(const float &fScale);
    void setRadius(const int &iRadius);
    void setColor(const QColor &color);
    void setVisible(const bool &bVisible);

private:
    TGadgetBackgroundPrivate *d_ptr;
};

#endif // TGADGETBACKGROUND_H
