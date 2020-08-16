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

#include "tgadgeticon.h"

class TGadgetIconPrivate
{
    Q_DECLARE_PUBLIC(TGadgetIcon)
public:
    TGadgetIconPrivate() {}

    TGadgetIcon *q_ptr;
    int m_iWidth = 18;
    int m_iHeight = 18;
    int m_iType = 0;
    int m_iPosition = 0;
    float m_fScale;
    QColor m_color;
    QString m_strSource;
};

TGadgetIcon::TGadgetIcon(QObject *parent) : QObject(parent), d_ptr(new TGadgetIconPrivate)
{
    d_ptr->q_ptr = this;
}

TGadgetIcon::~TGadgetIcon()
{
    delete d_ptr;
    d_ptr = nullptr;
}

int TGadgetIcon::getWidth() const
{
    return d_ptr->m_iWidth;
}

int TGadgetIcon::getHeight() const
{
    return d_ptr->m_iHeight;
}

QColor TGadgetIcon::getColor() const
{
    return d_ptr->m_color;
}

float TGadgetIcon::getScale() const
{
    return d_ptr->m_fScale;
}

QString TGadgetIcon::getSource() const
{
    return d_ptr->m_strSource;
}

int TGadgetIcon::getType() const
{
    return d_ptr->m_iType;
}

int TGadgetIcon::getPosition() const
{
    return d_ptr->m_iPosition;
}

void TGadgetIcon::setWidth(const int &iWidth)
{
    if (iWidth != d_ptr->m_iWidth) {
        d_ptr->m_iWidth = iWidth;
        emit this->widthChanged();
    }
}

void TGadgetIcon::setPosition(const int &iPosition)
{
    if (iPosition != d_ptr->m_iPosition) {
        d_ptr->m_iPosition = iPosition;
        emit this->positionChanged(iPosition);
    }
}

void TGadgetIcon::setHeight(const int &iHeight)
{
    if (iHeight != d_ptr->m_iHeight) {
        d_ptr->m_iHeight = iHeight;
        emit this->heightChanged();
    }
}

void TGadgetIcon::setColor(const QColor &color)
{
    if (color != d_ptr->m_color) {
        d_ptr->m_color = color;
        emit this->colorChanged();
    }
}

void TGadgetIcon::setScale(const float &fScale)
{
    if (!qFuzzyCompare(d_ptr->m_fScale, fScale)) {
        d_ptr->m_fScale = fScale;
        emit this->scaleChanged();
    }
}

void TGadgetIcon::setSource(const QString &strSource)
{
    if (strSource != d_ptr->m_strSource) {
        d_ptr->m_strSource = strSource;
        emit this->sourceChanged();
    }
}

void TGadgetIcon::setType(const int &iType)
{
    if (iType != d_ptr->m_iType) {
        d_ptr->m_iType = iType;
        emit this->typeChanged(iType);
    }
}
