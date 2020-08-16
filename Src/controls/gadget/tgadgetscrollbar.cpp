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

#include "tgadgetscrollbar.h"

class TGadgetScrollbarPrivate
{
    Q_DECLARE_PUBLIC(TGadgetScrollbar)
public:
    TGadgetScrollbarPrivate() {}

    TGadgetScrollbar *q_ptr;
    bool m_horizontal = true;
    bool m_vertical = true;
    bool m_autoHide = true;
};

TGadgetScrollbar::TGadgetScrollbar(QObject *parent) : QObject(parent), d_ptr(new TGadgetScrollbarPrivate)
{
    d_ptr->q_ptr = this;
}

TGadgetScrollbar::~TGadgetScrollbar()
{
    delete d_ptr;
    d_ptr = nullptr;
}

bool TGadgetScrollbar::isHorizontal() const
{
    return d_ptr->m_horizontal;
}

bool TGadgetScrollbar::isVertical() const
{
    return d_ptr->m_vertical;
}

bool TGadgetScrollbar::isAutoHide() const
{
    return d_ptr->m_autoHide;
}

void TGadgetScrollbar::setHorizontal(const bool &bHorizontal)
{
    if (bHorizontal != d_ptr->m_horizontal) {
        d_ptr->m_horizontal = bHorizontal;
        emit this->horizontalChanged();
    }
}

void TGadgetScrollbar::setVertical(const bool &bVertical)
{
    if (bVertical != d_ptr->m_vertical) {
        d_ptr->m_vertical = bVertical;
        emit this->verticalChanged();
    }
}

void TGadgetScrollbar::setAutoHide(const bool &bAutoHide)
{
    if (bAutoHide != d_ptr->m_autoHide) {
        d_ptr->m_autoHide = bAutoHide;
        emit this->autoHideChanged();
    }
}
