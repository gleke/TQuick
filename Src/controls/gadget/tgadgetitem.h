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

#ifndef TGADGETITEM_H
#define TGADGETITEM_H

#include <QObject>

class TGadgetItemPrivate;
class TGadgetItem : public QObject
{
    Q_OBJECT
    Q_DECLARE_PRIVATE(TGadgetItem)
    Q_DISABLE_COPY(TGadgetItem)

    Q_PROPERTY(int width READ getWidth WRITE setWidth NOTIFY widthChanged)
    Q_PROPERTY(int height READ getHeight WRITE setHeight NOTIFY heightChanged)

public:
    explicit TGadgetItem(QObject *parent = nullptr);
    ~TGadgetItem();

    int getWidth() const;
    int getHeight() const;

signals:
    void widthChanged(const int &iWidth);
    void heightChanged(const int &iHeight);

private slots:
    void setWidth(const int &iWidth);
    void setHeight(const int &iHeight);

private:
    TGadgetItemPrivate *d_ptr;
};

#endif // TGADGETITEM_H
