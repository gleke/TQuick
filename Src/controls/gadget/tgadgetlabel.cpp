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

#include "tgadgetlabel.h"

class TGadgetLabelPrivate
{
    Q_DECLARE_PUBLIC(TGadgetLabel)
public:
    TGadgetLabelPrivate() {}

    TGadgetLabel *q_ptr;

    QString m_strText = "";
    QColor m_color = Qt::black;
    float m_fScale = 1;
    QFont m_font = QFont();
    int m_iFontSize = 12;
};


TGadgetLabel::TGadgetLabel(QObject *parent) : QObject(parent), d_ptr(new TGadgetLabelPrivate)
{
    d_ptr->q_ptr = this;
}

TGadgetLabel::~TGadgetLabel()
{
    delete d_ptr;
    d_ptr = nullptr;
}

QString TGadgetLabel::getText() const
{
    return d_ptr->m_strText;
}

QColor TGadgetLabel::getColor() const
{
    return d_ptr->m_color;
}

float TGadgetLabel::getScale() const
{
    return d_ptr->m_fScale;
}

QFont TGadgetLabel::getFont() const
{
    return d_ptr->m_font;
}

int TGadgetLabel::getFontSize() const
{
    return d_ptr->m_iFontSize;
}

void TGadgetLabel::setFontSize(const int &iSize)
{
    if (iSize != d_ptr->m_iFontSize) {
        d_ptr->m_iFontSize = iSize;
        emit this->fontSizeChanged(iSize);
    }
}

void TGadgetLabel::setText(const QString &strText)
{
    if (strText != d_ptr->m_strText) {
        d_ptr->m_strText = strText;
        emit this->textChanged();
    }
}

void TGadgetLabel::setColor(const QColor &color)
{
    if (color != d_ptr->m_color) {
        d_ptr->m_color = color;
        emit this->colorChanged();
    }
}

void TGadgetLabel::setScale(const float &fScale)
{
    if (!qFuzzyCompare(d_ptr->m_fScale, fScale)) {
        d_ptr->m_fScale = fScale;
        emit this->scaleChanged();
    }
}

void TGadgetLabel::setFont(const QFont &font)
{
    if (font != d_ptr->m_font) {
        d_ptr->m_font = font;
        emit this->fontChanged();
    }
}
