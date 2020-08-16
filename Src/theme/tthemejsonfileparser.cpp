/****************************************************************************
**
** Library: TQuick
**
** MIT License
**
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

#include "tthemejsonfileparser.h"

#include <tquickinfo.h>

#include <QFile>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>
#include <QSharedPointer>

void retrievalProperty(TThemeBinder *pBinder, QMap<QString, QVariant> &mapNameToProperty, QString strParentName = QString())
{
    //    qDebug() << "retrievalProperty()-------------------------";
    if (pBinder->getClassName().isEmpty()) {
        return;
    }
    if (!pBinder->getChildName().isEmpty()) {
        if (!strParentName.isEmpty()) {
            strParentName += "." + pBinder->getChildName();
        } else {
            strParentName = pBinder->getChildName();
        }
    }
    QString strDot;
    QMap<QString, QVariant> bindingPropertyMap = pBinder->getBindingPropertyMap();
    if (!bindingPropertyMap.isEmpty() && !strParentName.isEmpty()) {
        strDot = ".";
    }

    QMapIterator<QString, QVariant> mapIter(bindingPropertyMap);
    while (mapIter.hasNext()) {
        mapIter.next();
        QString strKey = strParentName + strDot + mapIter.key();
        QVariant value = mapIter.value();
        mapNameToProperty.insert(strKey, value);
    }

    foreach (TThemeBinder *pChild, pBinder->getChilds()) {
        retrievalProperty(pChild, mapNameToProperty, strParentName);
    }

    return;
}

void writeBinderData(TThemeBinder *pBinder, QJsonObject &jsonObject) {
    //    qDebug() << "writeBinderData()-------------------------";
    if (nullptr == pBinder->getParent()) {
        QJsonObject binderJsonObject;
        QString strBinderKey = TThemeBinder::generateFieldKey(pBinder->getClassName(), pBinder->getGroupName(), pBinder->getStateName());
        if (jsonObject.contains(strBinderKey) && jsonObject[strBinderKey].isObject()) {
            binderJsonObject = jsonObject[strBinderKey].toObject();
        }

        // get Low priority theme json obj
        QStringList listAllFieldKey = TThemeBinder::generateFieldKeyList(pBinder->getClassName(), pBinder->getGroupName(), pBinder->getStateName());
        QList<QJsonObject> listLowPriorityBinderJsonObject;
        for (int i = listAllFieldKey.size() - 1; i > 0; --i) {
            QString strKey = listAllFieldKey.at(i);
            if (strKey != strBinderKey) {
                if (jsonObject.contains(strKey)) {
                    if (jsonObject[strKey].isObject()) {
                        listLowPriorityBinderJsonObject.append(jsonObject[strKey].toObject());
                    }
                }
            } else {
                break;
            }
        }

        // add property
        QMap<QString, QVariant> mapNameToProperty;
        retrievalProperty(pBinder, mapNameToProperty);
        if (!mapNameToProperty.isEmpty()) {
            QMapIterator<QString, QVariant> mapIter(mapNameToProperty);
            while (mapIter.hasNext()) {
                mapIter.next();
                QString strKey = mapIter.key();
                QVariant value = mapIter.value();
                if (strKey.contains(TThemeConstant::THEME_PROPERTY_COLOR)) {
                    binderJsonObject[strKey] = QJsonValue(value.toString());
                } else {
                    binderJsonObject[strKey] = value.toJsonValue();
                }

                // remove data equal to low priority theme binder json obj
                foreach (QJsonObject jsonObject, listLowPriorityBinderJsonObject) {
                    if (jsonObject.contains(strKey)) {
                        if (jsonObject.value(strKey) == value) {
                            binderJsonObject.remove(strKey);
                            break;
                        }
                    }
                }
            }

            // add binder item
            jsonObject[strBinderKey] = binderJsonObject;
        }
    }
}

bool TThemeJsonFileParser::parseThemeFile(const QString &strPath, QMap<QString, QVariantMap> &themeDataMap, QString &strError)
{
    QFile themeFile(strPath);
    if (!themeFile.exists()) {
        strError = QString("Theme file %1 not exist!").arg(strPath);
        return false;
    }

    if (!themeFile.open(QIODevice::ReadOnly)) {
        strError = QString("Theme file %1 open failed!").arg(strPath);
        return false;
    }

    QByteArray themeData = themeFile.readAll();
    themeFile.close();

    QJsonDocument themeJsonDoc(QJsonDocument::fromJson(themeData));
    QJsonObject themeJsonObject = themeJsonDoc.object();

    // parse INFO data
    if (themeJsonObject.contains(TThemeConstant::THEME_INFO_KEY) && themeJsonObject[TThemeConstant::THEME_INFO_KEY].isObject()) {
        QJsonObject jsonObjectInfo = themeJsonObject[TThemeConstant::THEME_INFO_KEY].toObject();
        QString strVersion = jsonObjectInfo[TThemeConstant::THEME_INFO_VERSION_KEY].toString();
        QString strAbout = jsonObjectInfo[TThemeConstant::THEME_INFO_ABOUT_KEY].toString();
        QString strName = jsonObjectInfo[TThemeConstant::THEME_INFO_NAME_KEY].toString();
        QString strAuthor = jsonObjectInfo[TThemeConstant::THEME_INFO_AUTHOR_KEY].toString();
        QVariantMap themeInfoMap;
        themeInfoMap.insert(QLatin1String(TThemeConstant::THEME_INFO_VERSION_KEY), strVersion);
        themeInfoMap.insert(QLatin1String(TThemeConstant::THEME_INFO_ABOUT_KEY), strAbout);
        themeInfoMap.insert(QLatin1String(TThemeConstant::THEME_INFO_NAME_KEY), strName);
        themeInfoMap.insert(QLatin1String(TThemeConstant::THEME_INFO_AUTHOR_KEY), strAuthor);
        themeDataMap.insert(TThemeConstant::THEME_INFO_KEY, themeInfoMap);

        if (QLatin1String(TQUICK_LIB_VERSION_NUMBER) != strVersion) {
            strError = QString("Theme file %1 version number %2 mismatch, valid version number is %3!")
                           .arg(strPath).arg(strVersion).arg(QLatin1String(TQUICK_LIB_VERSION_NUMBER));
        }
    } else {
        strError = QString("Theme file %1 Format error, INFO not found!").arg(strPath);
        return false;
    }

    // parse ITEM data
    if (themeJsonObject.contains(TThemeConstant::THEME_THEME_KEY) && themeJsonObject[TThemeConstant::THEME_THEME_KEY].isObject()) {
        QJsonObject jsonObjectClass = themeJsonObject[TThemeConstant::THEME_THEME_KEY].toObject();
        QStringList listThemeFieldKey = jsonObjectClass.keys();
        foreach (QString strFieldKey, listThemeFieldKey) {
            QVariantMap mapField = themeDataMap.value(strFieldKey);
            QJsonObject jsonObjectBinder = jsonObjectClass.value(strFieldKey).toObject();
            QStringList listPropertyKey = jsonObjectBinder.keys();
            foreach (QString strPropertyKey, listPropertyKey) {
                mapField.insert(strPropertyKey, jsonObjectBinder.value(strPropertyKey).toVariant());
            }
            themeDataMap.insert(strFieldKey, mapField);
        }
    } else {
        strError = QString("Theme file %1 Format error, ITEM not found!").arg(strPath);
        return false;
    }

    return true;
}

bool TThemeJsonFileParser::generateThemeTemplateFile(QString &strError, TThemeBinder *pBinder)
{
    //    qDebug() << "TThemeJsonFileParser::generateThemeTemplateFile()------------------------";
    QFile file(QStringLiteral("themeTemplate.json"));
    if (!file.open(QIODevice::ReadWrite)) {
        strError = QString("themeTemplate.json file open failed!");
        return false;
    }

    QByteArray fileData = file.readAll();
    QJsonDocument jsonReadDoc(QJsonDocument::fromJson(fileData));
    QJsonObject oldJsonObject = jsonReadDoc.object();

    QJsonObject newJsonObject;
    QJsonObject newInfoJsonObject;
    QJsonObject newThemeJsonObject = oldJsonObject[TThemeConstant::THEME_THEME_KEY].toObject();
    newInfoJsonObject[TThemeConstant::THEME_INFO_VERSION_KEY] = QLatin1String(TQUICK_LIB_VERSION_NUMBER);
    newInfoJsonObject[TThemeConstant::THEME_INFO_ABOUT_KEY] = QLatin1String("TQuick theme template file");
    newInfoJsonObject[TThemeConstant::THEME_INFO_NAME_KEY] = QLatin1String("Template");
    newInfoJsonObject[TThemeConstant::THEME_INFO_AUTHOR_KEY] = QLatin1String("TQuick");
    newJsonObject[TThemeConstant::THEME_INFO_KEY] = newInfoJsonObject;

    if (nullptr != pBinder) {
        writeBinderData(pBinder, newThemeJsonObject);
    } else {
        foreach (TThemeBinder *pBinderItem, TThemeBinder::getAllBinders()) {
            if (nullptr != pBinderItem && nullptr == pBinderItem->getParent() && pBinderItem->isEnabled()) {
                if (!pBinderItem->getClassName().isEmpty()) {
                    if (pBinderItem->getChildName().isEmpty()) {
                        writeBinderData(pBinderItem, newThemeJsonObject);
                    }
                }
            }
        }
    }
    newJsonObject[TThemeConstant::THEME_THEME_KEY] = newThemeJsonObject;

    QJsonDocument jsonSaveDoc(newJsonObject);
    file.resize(0);
    file.write(jsonSaveDoc.toJson());
    file.close();
    return true;
}
