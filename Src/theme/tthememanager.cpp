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

#include "tthememanager.h"
#include "tthemebinder.h"
#include "tthemehandler.h"
#include "tthemeconstant.h"
#include "tthemefileparser.h"
#include "tthemejsonfileparser.h"

#include <tquickinfo.h>

#include <QMutex>
#include <QMutexLocker>
#include <QQmlComponent>
#include <QQmlEngine>
#include <QTimer>
#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QFileInfoList>
#include <QFileSystemWatcher>


class TThemeManagerPrivate
{
    friend class TThemeManager;
public:
    TThemeManagerPrivate() {}
    ~TThemeManagerPrivate();

    TThemeManager *q_ptr = nullptr;
    QFileSystemWatcher *m_pFileSystemWatcher = nullptr;
    TThemeFileParser *m_pThemeFileParser = nullptr;
    QMap<QString, TThemeHandler *> m_mapThemeNameToHandler;
    QString m_strStartupThemeName;
    QString m_strCurrentThemeName;
    QString m_strLastError;
    bool m_bGenerateThemeTemplateEnable = false;
};

TThemeManagerPrivate::~TThemeManagerPrivate()
{
    qDeleteAll(m_mapThemeNameToHandler);
    m_mapThemeNameToHandler.clear();

    delete m_pThemeFileParser;
    m_pThemeFileParser = nullptr;
}

static TThemeManager *sm_pInstance = nullptr;


TThemeManager::TThemeManager(QObject *parent) : QObject(parent)
{
    d_ptr = new TThemeManagerPrivate();
    d_ptr->q_ptr = this;
    d_ptr->m_pThemeFileParser = new TThemeJsonFileParser();
    d_ptr->m_pFileSystemWatcher = new QFileSystemWatcher(this);
    connect(d_ptr->m_pFileSystemWatcher, &QFileSystemWatcher::fileChanged, [=](const QString &path) {
        qDebug() << "path:" << path;
        QFileInfo fileInfo(path);
        QTimer::singleShot(100, [=]() {
            this->addTheme(fileInfo.absoluteFilePath());
        });
    });
}

void TThemeManager::newThemeBinder(TThemeBinder *pBinder)
{
    connect(pBinder, &TThemeBinder::initialized, [=]() {
        this->generateThemeTemplateFile();
    });
    connect(pBinder, &TThemeBinder::parentChanged, [=]() {
        this->generateThemeTemplateFile();
    });
}

TThemeManager::~TThemeManager()
{
    delete d_ptr;
    d_ptr = nullptr;
}

QObject *TThemeManager::qmlSingletonTypeProvider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    return TThemeManager::getInstance();
}

TThemeManager *TThemeManager::getInstance()
{
    static QMutex mutex;
    QMutexLocker mutexLocker(&mutex);
    if (nullptr == sm_pInstance) {
        sm_pInstance = new TThemeManager();
    }
    return sm_pInstance;
}

bool TThemeManager::isGenerateThemeTemplateEnable() const
{
    return d_ptr->m_bGenerateThemeTemplateEnable;
}

bool TThemeManager::isCurrentThemeValid() const
{
    return d_ptr->m_mapThemeNameToHandler.contains(d_ptr->m_strCurrentThemeName);
}

bool TThemeManager::addThemeDir(const QString &strDir)
{
    QDir dir(strDir);
    if (!dir.exists()) {
        d_ptr->m_strLastError = QString("add theme dir failed for %1 dir not exist!").arg(strDir);
        qWarning() << d_ptr->m_strLastError;
        return false;
    }

    bool bRet = true;
    QStringList listFileFilters;
    listFileFilters << "*.json";
    QFileInfoList listFileInfo = dir.entryInfoList(listFileFilters, QDir::Files | QDir::NoSymLinks | QDir::NoDotAndDotDot);
    foreach (QFileInfo fileInfo, listFileInfo) {
        bRet = bRet && this->addTheme(fileInfo.absoluteFilePath());
        if (bRet) {
            d_ptr->m_pFileSystemWatcher->addPath(fileInfo.filePath());
        }
    }
    if(!d_ptr->m_strStartupThemeName.isEmpty() && d_ptr->m_mapThemeNameToHandler.contains(d_ptr->m_strStartupThemeName)){
        this->setCurrentTheme(d_ptr->m_strStartupThemeName);
    }
    return bRet;
}

bool TThemeManager::addTheme(const QString &strPath)
{
    QString strError;
    QMap<QString, QVariantMap> data;
    bool bRet = d_ptr->m_pThemeFileParser->parseThemeFile(strPath, data, strError);
    if (!bRet) {
        qWarning() << "Theme file strPath parse failed for " << strError;
        return false;
    }

    QString strName = data.value(TThemeConstant::THEME_INFO_KEY).value(TThemeConstant::THEME_INFO_NAME_KEY).toString();
    TThemeHandler *pHandler = new TThemeHandler(strName, strPath);
    pHandler->setThemeData(data);
    if (d_ptr->m_mapThemeNameToHandler.contains(strName)) {
        d_ptr->m_mapThemeNameToHandler.value(strName)->deleteLater();
        d_ptr->m_mapThemeNameToHandler.remove(strName);
    }
    d_ptr->m_mapThemeNameToHandler.insert(strName, pHandler);
    if (strName == d_ptr->m_strCurrentThemeName) {
        emit this->currentThemeChanged();
    }
    emit this->themeListChanged();
    return true;
}

QVariantList TThemeManager::getThemeList() const
{
    QVariantList list;
    foreach (TThemeHandler *pThemeHandler, d_ptr->m_mapThemeNameToHandler.values()) {
        list.append(pThemeHandler->getThemeInfo());
    }
    return list;
}

QString TThemeManager::getCurrentTheme() const
{
    return d_ptr->m_strCurrentThemeName;
}

QString TThemeManager::getStartupTheme() const
{
    return d_ptr->m_strStartupThemeName;
}

QString TThemeManager::getLastError() const
{
    return d_ptr->m_strLastError;
}

QVariant TThemeManager::getPropertyData(const QString &strFieldKey, const QString &strProperty)
{
    if (!this->isCurrentThemeValid()) {
        qWarning() << "Current theme is invalid, can not get property data!";
        return QVariant();
    }
    TThemeHandler *pHandler = d_ptr->m_mapThemeNameToHandler.value(d_ptr->m_strCurrentThemeName);
    if (nullptr == pHandler) {
        qCritical() << "Current theme handler pointer is nullptr, can not get property data!";
        return QVariant();
    }
    return pHandler->getPropertyData(strFieldKey, strProperty);
}

void TThemeManager::generateThemeTemplateFile(TThemeBinder *pBinder)
{
    if (!d_ptr->m_bGenerateThemeTemplateEnable) {
        return;
    }
    static QString strError;
    static bool bRet = true;
    if (!bRet) {
        return;
    }
    bRet = d_ptr->m_pThemeFileParser->generateThemeTemplateFile(strError, pBinder);
    if (!bRet) {
        qWarning() << "Generate theme template file for " << strError;
        return;
    }
}

void TThemeManager::setCurrentTheme(const QString &strTheme)
{
    if (strTheme != d_ptr->m_strCurrentThemeName) {
        if (d_ptr->m_mapThemeNameToHandler.contains(strTheme)) {
            d_ptr->m_strCurrentThemeName = strTheme;
            emit this->currentThemeChanged();
        }
    }
}

void TThemeManager::setStartupTheme(const QString &strTheme)
{
    if (!d_ptr->m_strCurrentThemeName.isEmpty()) {
        qWarning() << "App startup theme has been set as " << d_ptr->m_strCurrentThemeName;
        return;
    }
    d_ptr->m_strCurrentThemeName = strTheme;
    this->setCurrentTheme(strTheme);
}

void TThemeManager::setGenerateThemeTemplateEnable(const bool &bEnable)
{
    if (bEnable != d_ptr->m_bGenerateThemeTemplateEnable) {
        d_ptr->m_bGenerateThemeTemplateEnable = bEnable;
    }
}
