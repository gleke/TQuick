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

#include "tquickworld.h"
#include "tquick.h"
#include "theme/tthememanager.h"

class TQuickWorldPrivate
{
    Q_DECLARE_PUBLIC(TQuickWorld)
public:
    TQuickWorldPrivate() {}

    void onParentChanged();

    TQuickWorld *q_ptr;
    QMetaObject::Connection m_connection;
};

void TQuickWorldPrivate::onParentChanged()
{
    QObject::disconnect(m_connection);
    TQuick::getInstance()->initQuickRoot((QQuickWindow*)q_ptr->parent());
    TQuick::getInstance()->initWorld(q_ptr);
}


TQuickWorld::TQuickWorld(QQuickItem *parent) : QQuickItem(parent), d_ptr(new TQuickWorldPrivate)
{
    d_ptr->q_ptr = this;
    static bool bInited = false;
    if(bInited){
        //        qErrnoWarning("Error:There is only one world :)");
        //        throw;
    } else {
        bInited = true;
        this->setVisible(false);
        this->setEnabled(false);
        d_ptr->m_connection = connect(this, &TQuickWorld::parentChanged, [=]() {d_ptr->onParentChanged();});
    }
}

TQuickWorld::~TQuickWorld()
{
    delete d_ptr;
    d_ptr = nullptr;
}

QStringList TQuickWorld::getThemeDirs() const
{
    qWarning() << "Please call: TThemeManager.themeList";
    return QStringList();
}

void TQuickWorld::setStartupTheme(const QString &strThemeName)
{
    TQuick::getInstance()->setStartupTheme(strThemeName);
}

QString TQuickWorld::getStartupTheme() const
{
    qWarning() << "Please call: TThemeManager.appTheme";
    return QString();
}

void TQuickWorld::setThemeDirs(const QStringList &strDirs)
{
    foreach (QString strDir, strDirs) {
        TQuick::getInstance()->addThemeDir(strDir);
    }
}

int TQuickWorld::getMouseAreaCursorShape() const
{
    return TQuick::getInstance()->mouseAreaCursorShape();
}

void TQuickWorld::setMouseAreaCursorShape(const int &iShape)
{
    TQuick::getInstance()->setMouseAreaCursorShape((Qt::CursorShape)iShape);
}

bool TQuickWorld::isGenerateThemeTemplateEnable() const
{
    return TThemeManager::getInstance()->isGenerateThemeTemplateEnable();
}

void TQuickWorld::setGenerateThemeTemplateEnable(const bool &bEnable)
{
    TThemeManager::getInstance()->setGenerateThemeTemplateEnable(bEnable);
}
