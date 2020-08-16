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

#include "tcolor.h"

#include <QMutex>
#include <QMutexLocker>

#define crandom(a,b) (rand()%(b-a+1)+a)
static TColor *sg_pInstance = nullptr;

class TColorPrivate
{
    Q_DECLARE_PUBLIC(TColor)
public:
    TColorPrivate() {}

    TColor *q_ptr;
};


TColor::TColor(QObject *parent) : QObject(parent), d_ptr(new TColorPrivate)
{
    d_ptr->q_ptr = this;
}

TColor::~TColor()
{
    delete d_ptr;
    d_ptr = nullptr;
}

QColor TColor::getRandom() const
{
    return QColor (crandom(1,255),crandom(1,255),crandom(1,255),crandom(1,255));
}

QColor TColor::getPrimary() const
{
    return QColor("#409EFF");
}

QColor TColor::getPrimaryLight() const
{
    return QColor("#DAECFE");
}

QColor TColor::getSuccess() const
{
    return QColor("#67C23A");
}

QColor TColor::getSuccessLight() const
{
    return QColor("#E1F2D9");
}

QColor TColor::getWarning() const
{
    return QColor("#E6A23C");
}

QColor TColor::getWarningLight() const
{
    return QColor("#FAECD9");
}

QColor TColor::getDanger() const
{
    return QColor("#F56C6C");
}

QColor TColor::getDangerLight() const
{
    return QColor("#FCE2E2");
}

QColor TColor::getInfo() const
{
    return QColor("#909399");
}

QColor TColor::getInfoLight() const
{
    return QColor("#E9E9EB");
}

TColor *TColor::getInstance()
{
    static QMutex mutex;
    QMutexLocker mutexLOcker(&mutex);
    if(nullptr == sg_pInstance){
        sg_pInstance = new TColor;
    }
    return sg_pInstance;
}

QObject *TColor::qmlSingletonTypeProvider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    return TColor::getInstance();
}

