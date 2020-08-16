#include "tgadgetborder.h"

class TGadgetBorderPrivate
{
    Q_DECLARE_PUBLIC(TGadgetBorder)
public:
    TGadgetBorderPrivate() {}

    bool hasValid();

    TGadgetBorder *q_ptr;
    QColor m_color = "#5D5D5D";
    int m_width = 0;
    int m_leftWidth = 1;
    int m_rightWidth = 1;
    int m_topWidth = 1;
    int m_bottomWidth = 1;
    bool m_isValid = false;
};

bool TGadgetBorderPrivate::hasValid()
{
    bool bValid = m_width > 0 || m_bottomWidth > 0 || m_topWidth > 0 || m_leftWidth > 0 || m_rightWidth > 0;
    if (bValid != m_isValid) {
        m_isValid = bValid;
        emit q_ptr->validChanged();
    }
    return bValid;
}


TGadgetBorder::TGadgetBorder(QObject *parent) : QObject(parent), d_ptr(new TGadgetBorderPrivate)
{
    d_ptr->q_ptr = this;
}

TGadgetBorder::~TGadgetBorder()
{
    delete d_ptr;
    d_ptr = nullptr;
}

QColor TGadgetBorder::getColor() const
{
    return d_ptr->m_color;
}

int TGadgetBorder::getWidth() const
{
    return d_ptr->m_width;
}

int TGadgetBorder::getLeftWidth() const
{
    return d_ptr->m_leftWidth;
}

int TGadgetBorder::getRightWidth() const
{
    return d_ptr->m_rightWidth;
}

int TGadgetBorder::getTopWidth() const
{
    return d_ptr->m_topWidth;
}

int TGadgetBorder::getBottomWidth() const
{
    return d_ptr->m_bottomWidth;
}

bool TGadgetBorder::isValid() const
{
    return d_ptr->m_isValid;
}

void TGadgetBorder::setLeftWidth(const int &iLeftWidth)
{
    if (iLeftWidth != d_ptr->m_leftWidth) {
        d_ptr->m_leftWidth = iLeftWidth;
        emit this->leftWidthChanged();
        d_ptr->hasValid();
    }
}

void TGadgetBorder::setRightWidth(const int &iRightWidth)
{
    if (iRightWidth != d_ptr->m_rightWidth) {
        d_ptr->m_rightWidth = iRightWidth;
        emit this->rightWidthChanged();
        d_ptr->hasValid();
    }
}

void TGadgetBorder::setTopWidth(const int &iTopWidth)
{
    if (iTopWidth != d_ptr->m_topWidth) {
        d_ptr->m_topWidth = iTopWidth;
        emit this->topWidthChanged();
        d_ptr->hasValid();
    }
}

void TGadgetBorder::setBottomWidth(const int &iBottomWidth)
{
    if (iBottomWidth != d_ptr->m_bottomWidth) {
        d_ptr->m_bottomWidth = iBottomWidth;
        emit this->bottomWidthChanged();
        d_ptr->hasValid();
    }
}

void TGadgetBorder::setColor(const QColor color)
{
    if (color != d_ptr->m_color) {
        d_ptr->m_color = color;
        emit this->colorChanged();
        d_ptr->hasValid();
    }
}

void TGadgetBorder::setWidth(const int &iWidth)
{
    if (iWidth != d_ptr->m_width) {
        d_ptr->m_width = iWidth;
        emit this->widthChanged();
        d_ptr->hasValid();
    }
}
