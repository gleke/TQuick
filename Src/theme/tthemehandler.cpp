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

#include "tthemehandler.h"
#include "tthemebinder.h"
#include "tthemeconstant.h"

#include <tquickinfo.h>

#include <QVariantMap>
#include <QDebug>
#include <QFile>
#include <QByteArray>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonDocument>
#include <QTextStream>

/**
 * @brief The TThemeHandlerPrivate class
 */
class TThemeHandlerPrivate
{
    friend class TThemeHandler;
public:
    TThemeHandlerPrivate() {}

    TThemeHandler *q_ptr;
    QString m_strName;
    QString m_strPath;
    QString m_strLastError;
    QVariantMap m_mapThemeInfo;
    QMap<QString, QVariantMap> m_mapThemeData;
    bool m_bValid = false;
};


/**
 * @brief TThemeHandler::TThemeHandler
 * @param strName
 * @param strPath
 */
TThemeHandler::TThemeHandler(const QString &strName, const QString &strPath) : QObject()
{
    d_ptr = new TThemeHandlerPrivate();
    d_ptr->q_ptr = this;
    d_ptr->m_strName = strName;
    d_ptr->m_strPath = strPath;
}

TThemeHandler::~TThemeHandler()
{
    delete d_ptr;
    d_ptr = nullptr;
}

QString TThemeHandler::getThemeName()
{
    return d_ptr->m_strName;
}

QString TThemeHandler::getThemePath()
{
    return d_ptr->m_strPath;
}

QString TThemeHandler::getLastError()
{
    return d_ptr->m_strLastError;
}

bool TThemeHandler::isValid()
{
    return d_ptr->m_bValid;
}

bool TThemeHandler::isLoad()
{
    return !d_ptr->m_mapThemeData.isEmpty();
}

QVariant TThemeHandler::getPropertyData(const QString &strFieldKey, const QString &strPropertyKey)
{
    if (d_ptr->m_mapThemeData.contains(strFieldKey)) {
        QVariantMap mapField = d_ptr->m_mapThemeData.value(strFieldKey);
        if (mapField.contains(strPropertyKey)) {
            return mapField.value(strPropertyKey);
        }
    }
    return QVariant();
}

const QMap<QString, QVariantMap> TThemeHandler::getThemeData()
{
    return d_ptr->m_mapThemeData;
}

const QVariantMap TThemeHandler::getThemeInfo()
{
    return d_ptr->m_mapThemeData.value(TThemeConstant::THEME_INFO_KEY);
}

void TThemeHandler::setLastError(const QString &strText)
{
    if (strText != d_ptr->m_strLastError) {
        d_ptr->m_strLastError = strText;
    }
}

void TThemeHandler::setThemeData(const QMap<QString, QVariantMap> &data)
{
    if (data != d_ptr->m_mapThemeData) {
        d_ptr->m_mapThemeData = data;
        d_ptr->m_bValid = !data.isEmpty();
        emit this->themeDataChanged();
    }
}
