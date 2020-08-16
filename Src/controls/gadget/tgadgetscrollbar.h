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

#ifndef TGADGETSCROLLBAR_H
#define TGADGETSCROLLBAR_H

#include <QObject>

class TGadgetScrollbarPrivate;
class TGadgetScrollbar : public QObject
{
    Q_OBJECT
    Q_DECLARE_PRIVATE(TGadgetScrollbar)
    Q_DISABLE_COPY(TGadgetScrollbar)

    Q_PROPERTY(bool horizontal READ isHorizontal WRITE setHorizontal NOTIFY horizontalChanged)
    Q_PROPERTY(bool vertical READ isVertical WRITE setVertical NOTIFY verticalChanged)
    Q_PROPERTY(bool autoHide READ isAutoHide WRITE setAutoHide NOTIFY autoHideChanged)

public:
    explicit TGadgetScrollbar(QObject *parent = nullptr);
    ~TGadgetScrollbar();

    bool isHorizontal() const;
    bool isVertical() const;
    bool isAutoHide() const;

signals:
    void horizontalChanged();
    void verticalChanged();
    void autoHideChanged();

private slots:
    void setHorizontal(const bool &bHorizontal);
    void setVertical(const bool &bVertical);
    void setAutoHide(const bool &bAutoHide);

private:
    TGadgetScrollbarPrivate *d_ptr;
};

#endif // TGADGETSCROLLBAR_H
