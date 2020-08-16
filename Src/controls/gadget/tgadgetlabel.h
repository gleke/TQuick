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

#ifndef TGADGETLABEL_H
#define TGADGETLABEL_H

#include <QColor>
#include <QFont>
#include <QObject>

class TGadgetLabelPrivate;
class TGadgetLabel : public QObject
{
    Q_OBJECT
    Q_DECLARE_PRIVATE(TGadgetLabel)
    Q_DISABLE_COPY(TGadgetLabel)

    Q_PROPERTY(QString text READ getText WRITE setText NOTIFY textChanged)
    Q_PROPERTY(QColor color READ getColor WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(float scale READ getScale WRITE setScale NOTIFY scaleChanged)
    Q_PROPERTY(QFont font READ getFont WRITE setFont NOTIFY fontChanged)
    Q_PROPERTY(int fontSize READ getFontSize WRITE setFontSize NOTIFY fontSizeChanged)

public:
    explicit TGadgetLabel(QObject *parent = nullptr);
    ~TGadgetLabel();

    QString getText() const;
    QColor getColor() const;
    float getScale() const;
    QFont getFont() const;
    int getFontSize() const;

public slots:
    void setText(const QString &strText);
    void setColor(const QColor &getColor);
    void setScale(const float &fScale);
    void setFont(const QFont &getFont);
    void setFontSize(const int &iSize);

signals:
    void textChanged();
    void colorChanged();
    void scaleChanged();
    void fontChanged();
    void fontSizeChanged(const int &iSize);

private:
    TGadgetLabelPrivate *d_ptr;
};

#endif // TGADGETLABEL_H
