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

#include "tgadgetbackground.h"

class TGadgetBackgroundPrivate
{
    Q_DECLARE_PUBLIC(TGadgetBackground)
public:
    TGadgetBackgroundPrivate() {}

    TGadgetBackground *q_ptr;
    QColor m_color = "#FFF";
    int m_iRadius = 0;
    int m_iWidth = 0;
    int m_iHeight = 0;
    float m_fOpacity = 1;
    float m_fScale = 1;
    bool m_bVisible = true;
};

TGadgetBackground::TGadgetBackground(QObject *parent) : QObject(parent), d_ptr(new TGadgetBackgroundPrivate)
{
    d_ptr->q_ptr = this;
}

TGadgetBackground::~TGadgetBackground()
{
    delete d_ptr;
    d_ptr = nullptr;
}

float TGadgetBackground::getScale() const
{
    return d_ptr->m_fScale;
}

int TGadgetBackground::getRadius() const
{
    return d_ptr->m_iRadius;
}

QColor TGadgetBackground::getColor() const
{
    return d_ptr->m_color;
}

bool TGadgetBackground::isVisible() const
{
    return d_ptr->m_bVisible;
}

int TGadgetBackground::getWidth() const
{
    return d_ptr->m_iWidth;
}

int TGadgetBackground::getHeight() const
{
    return d_ptr->m_iHeight;
}

float TGadgetBackground::getOpacity() const
{
    return d_ptr->m_fOpacity;
}

void TGadgetBackground::setWidth(const int &iWidth)
{
    if (iWidth != d_ptr->m_iWidth) {
        d_ptr->m_iWidth = iWidth;
        emit this->widthChanged();
    }
}

void TGadgetBackground::setHeight(const int &iHeight)
{
    if (iHeight != d_ptr->m_iHeight) {
        d_ptr->m_iHeight = iHeight;
        emit this->heightChanged();
    }
}

void TGadgetBackground::setOpacity(const float &fOpacity)
{
    if (!qFuzzyCompare(d_ptr->m_fOpacity, fOpacity)) {
        d_ptr->m_fOpacity = fOpacity;
        emit this->opacityChanged();
    }
}

void TGadgetBackground::setScale(const float &fScale)
{
    if (!qFuzzyCompare(d_ptr->m_fScale, fScale)) {
        d_ptr->m_fScale = fScale;
        emit this->scaleChanged();
    }
}

void TGadgetBackground::setRadius(const int &iRadius)
{
    if (iRadius != d_ptr->m_iRadius) {
        d_ptr->m_iRadius = iRadius;
        emit this->radiusChanged();
    }
}

void TGadgetBackground::setColor(const QColor &color)
{
    if (color != d_ptr->m_color) {
        d_ptr->m_color = color;
        emit this->colorChanged();
    }
}

void TGadgetBackground::setVisible(const bool &bVisible)
{
    if (bVisible != d_ptr->m_bVisible) {
        d_ptr->m_bVisible = bVisible;
        emit this->visibleChanged();
    }
}
