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

#include "ttoastitem.h"
#include <QDebug>

class TToastItemPrivate
{
    Q_DECLARE_PUBLIC(TToastItem)
public:
    TToastItemPrivate() {}

    TToastItem *q_ptr;
    QString m_strMessage = "";
    int m_iType;
};

TToastItem::TToastItem(QQuickItem *parent) : QQuickItem(parent), d_ptr(new TToastItemPrivate)
{
    d_ptr->q_ptr = this;
}

TToastItem::~TToastItem()
{
    delete d_ptr;
    d_ptr = nullptr;
}

QString TToastItem::getMessage() const
{
    return d_ptr->m_strMessage;
}

int TToastItem::getType() const
{
    return d_ptr->m_iType;
}

void TToastItem::setMessage(const QString &strMessage)
{
    if (strMessage != d_ptr->m_strMessage) {
        d_ptr->m_strMessage = strMessage;
        emit this->messageChanged(strMessage);
    }
}

void TToastItem::setType(const int &iType)
{
    if (iType != d_ptr->m_iType) {
        d_ptr->m_iType = iType;
        emit this->typeChanged(iType);
    }
}
