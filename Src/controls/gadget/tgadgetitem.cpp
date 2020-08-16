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

#include "tgadgetitem.h"

class TGadgetItemPrivate
{
    Q_DECLARE_PUBLIC(TGadgetItem)
public:
    TGadgetItemPrivate() {}

    TGadgetItem *q_ptr;
    int m_iWidth;
    int m_iHeight;
};

TGadgetItem::TGadgetItem(QObject *parent) : QObject(parent), d_ptr(new TGadgetItemPrivate)
{
    d_ptr->q_ptr = this;
}

TGadgetItem::~TGadgetItem()
{
    delete d_ptr;
    d_ptr = nullptr;
}

int TGadgetItem::getWidth() const
{
    return d_ptr->m_iWidth;
}

int TGadgetItem::getHeight() const
{
    return d_ptr->m_iHeight;
}

void TGadgetItem::setWidth(const int &iWidth)
{
    if (iWidth != d_ptr->m_iWidth) {
        d_ptr->m_iWidth = iWidth;
        emit this->widthChanged(iWidth);
    }
}

void TGadgetItem::setHeight(const int &iHeight)
{
    if (iHeight != d_ptr->m_iHeight) {
        d_ptr->m_iHeight = iHeight;
        emit this->heightChanged(iHeight);
    }
}
