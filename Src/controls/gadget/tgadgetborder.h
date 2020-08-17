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

#ifndef TGADGETBORDER_H
#define TGADGETBORDER_H

#include <QColor>
#include <QObject>

class TGadgetBorderPrivate;
class TGadgetBorder : public QObject
{
    Q_OBJECT
    Q_DECLARE_PRIVATE(TGadgetBorder)
    Q_DISABLE_COPY(TGadgetBorder)

    Q_PROPERTY(int width READ getWidth WRITE setWidth NOTIFY widthChanged)
    Q_PROPERTY(QColor color READ getColor WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(int leftWidth READ getLeftWidth WRITE setLeftWidth NOTIFY leftWidthChanged)
    Q_PROPERTY(int rightWidth READ getRightWidth WRITE setRightWidth NOTIFY rightWidthChanged)
    Q_PROPERTY(int topWidth READ getTopWidth WRITE setTopWidth NOTIFY topWidthChanged)
    Q_PROPERTY(int bottomWidth READ getBottomWidth WRITE setBottomWidth NOTIFY bottomWidthChanged)
    Q_PROPERTY(bool valid READ isValid NOTIFY validChanged)

public:
    explicit TGadgetBorder(QObject *parent = nullptr);
    ~TGadgetBorder();

    QColor getColor() const;
    int getWidth() const;
    int getLeftWidth() const;
    int getRightWidth() const;
    int getTopWidth() const;
    int getBottomWidth() const;
    bool isValid() const;

signals:
    void colorChanged();
    void widthChanged();
    void leftWidthChanged();
    void rightWidthChanged();
    void topWidthChanged();
    void bottomWidthChanged();
    void validChanged();

private slots:
    void setColor(const QColor color);
    void setWidth(const int &iWidth);
    void setLeftWidth(const int &iLeftWidth);
    void setRightWidth(const int &iRightWidth);
    void setTopWidth(const int &iTopWidth);
    void setBottomWidth(const int &iBottomWidth);

private:
    TGadgetBorderPrivate *d_ptr;
};

#endif // TGADGETBORDER_H
