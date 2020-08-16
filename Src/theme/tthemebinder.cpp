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

#include "tthemebinder.h"
#include "tthememanager.h"
#include "tthemeconstant.h"

#include <QMap>
#include <QDebug>
#include <QJsonArray>
#include <QMapIterator>
#include <QMetaMethod>

class TThemeBinderPrivate
{
    Q_DECLARE_PUBLIC(TThemeBinder)

public:
    TThemeBinderPrivate();
    ~TThemeBinderPrivate() {}

    QVariant getPropertyData(const QString &strKey);
    QString getBinderFieldKey();

    static QList<TThemeBinder *> sm_listAllBinders;
    static int sm_iCount;
    const int m_iId;
    TThemeBinder *q_ptr;
    bool m_bEnabled = false;
    QString m_strGroup;
    QString m_strClass;
    QString m_strChild;
    QString m_strState;
    QObject *m_pTarget = nullptr;

    QMap<QString, QVariant> m_mapBindingNameToProperty;
    QStringList m_listPropertyInitfilter;
    QStringList m_listFilterPropertyName;
    QStringList m_listDynamicListener;
    bool m_bStateAsynchronous = true;

    QList<TThemeBinder *> m_listChilds;
    TThemeBinder *m_pParent = nullptr;
};

QList<TThemeBinder *> TThemeBinderPrivate::sm_listAllBinders;
int TThemeBinderPrivate::sm_iCount = 0;

TThemeBinderPrivate::TThemeBinderPrivate() : m_iId(++sm_iCount)
{

}

QVariant TThemeBinderPrivate::getPropertyData(const QString &strKey)
{
    QString strPropertyFieldKey = this->getBinderFieldKey() + strKey;
    //    qDebug() << "strPropertyFieldKey=" << strPropertyFieldKey;

    if(!m_bEnabled || m_listFilterPropertyName.contains(strPropertyFieldKey)) {
        qWarning() << "Warning: !m_bEnabled || m_listFilterPropertyName.contains(strPropertyFieldKey).";
        return QVariant();
    }

    if(m_strClass.isEmpty()){
        qWarning() << "Warning: Binder className cannot be empty." << strKey;
        return QVariant();
    }

    QStringList listFieldKey = TThemeBinder::generateFieldKeyList(m_strClass, m_strGroup, m_strState);
    foreach (QString strFieldKey, listFieldKey) {
        QVariant propertyData = TThemeManager::getInstance()->getPropertyData(strFieldKey, strPropertyFieldKey);
        if (propertyData.isValid()) {
            return propertyData;
        }
    }
    return QVariant();
}

QString TThemeBinderPrivate::getBinderFieldKey()
{
    QString strFieldKey;
    if (nullptr != m_pParent) {
        strFieldKey = m_pParent->d_ptr->getBinderFieldKey();
    }
    if (!m_strChild.isEmpty()) {
        strFieldKey += m_strChild + ".";
    }
    return strFieldKey;
}


TThemeBinder::TThemeBinder(QObject *parent)
    : QObject(parent), d_ptr(new TThemeBinderPrivate)
{
    d_ptr->q_ptr = this;
    d_ptr->m_listDynamicListener << "width" << "height" << "x" << "y";
    this->setEnabled(true);
    const QMetaObject *pMetaObj = this->metaObject();
    int iPropertyCount = pMetaObj->propertyCount();
    for (int i = 0; i < iPropertyCount; ++i) {
        QMetaProperty metaProperty = pMetaObj->property(i);
        d_ptr->m_listFilterPropertyName.append(metaProperty.name());
    }

    connect(this, &TThemeBinder::stateChanged, this, [=]() {
            if(d_ptr->m_bStateAsynchronous && TThemeManager::getInstance()->isCurrentThemeValid()){
                this->onRefreshPropertys();
            }
        }, Qt::QueuedConnection);
    TThemeBinderPrivate::sm_listAllBinders.append(this);
    TThemeManager::getInstance()->newThemeBinder(this);
}

TThemeBinder::~TThemeBinder()
{
    TThemeBinderPrivate::sm_listAllBinders.removeOne(this);
    delete d_ptr;
    d_ptr = nullptr;
}

void TThemeBinder::initialize()
{
    Q_D(TThemeBinder);
    //    qDebug() << "TThemeBinder::initialize()--------------------";
    //    qDebug() << "id = " << d->m_iId;
    //    qDebug() << "m_strClass = " << d->m_strClass;
    //    qDebug() << "m_strGroup = " << d->m_strGroup;
    //    qDebug() << "m_strChild = " << d->m_strChild;
    //    qDebug() << "m_strState = " << d->m_strState;
    //    qDebug() << "m_pParent = " << d->m_pParent;
    //    qDebug() << "m_listChilds.size() = " << d->m_listChilds.size();
    if(!d->m_bEnabled) {
        return;
    }
    const QMetaObject *pMetaObj = this->metaObject();

    //[1 step]
    int iPropertyCount = pMetaObj->propertyCount();
    for (int i = 0; i < iPropertyCount; ++i) {
        QMetaProperty metaProperty = pMetaObj->property(i);
        if(!d->m_listPropertyInitfilter.contains(metaProperty.name()) && !d->m_listFilterPropertyName.contains(metaProperty.name())) {
            QVariant property(metaProperty.type());
            property.setValue(this->property(metaProperty.name()));
            d->m_mapBindingNameToProperty.insert(metaProperty.name(), property);
            //            qDebug() << "metaProperty=" << metaProperty.name() << " , property=" << property;
        }
    }

    //[2 step]
    QList<int> listBindingMethodIndex;
    int iBinderSlotIndex = -1;
    int iMethodCount = pMetaObj->methodCount();
    for (int i = 0; i < iMethodCount; ++i) {
        QMetaMethod method = pMetaObj->method(i);
        QString strMethodName = QString::fromUtf8(method.name());
        if (method.methodType() == QMetaMethod::Signal && strMethodName.contains("Changed")){
            QString strBindingName = QString(strMethodName.mid(0, strMethodName.indexOf("Changed")));
            if(d->m_mapBindingNameToProperty.contains(strBindingName) && d->m_listDynamicListener.contains(strBindingName)) {
                listBindingMethodIndex.append(method.methodIndex());
            }
        } else if(method.methodType() == QMetaMethod::Slot && strMethodName == "onPropertyChanged") {
            iBinderSlotIndex = method.methodIndex();
        }
    }

    //[3 step]
    if(-1 != iBinderSlotIndex && listBindingMethodIndex.length() > 0) {
        foreach (int iKey, listBindingMethodIndex) {
            QMetaObject::connect(this, iKey, this, iBinderSlotIndex);
        }
    }

    //[4 step]
    foreach (TThemeBinder *pChildBinder, d->m_listChilds) {
        pChildBinder->setStateAsynchronous(d->m_bStateAsynchronous);
        pChildBinder->setFilterPropertyName(d->m_listFilterPropertyName);
        pChildBinder->setClassName(d->m_strClass);
        pChildBinder->setGroupName(d->m_strGroup);
        pChildBinder->setEnabled(d->m_bEnabled);
        pChildBinder->setState(d->m_strState);
        pChildBinder->setParent(this);
        pChildBinder->initialize();
    }

    if(TThemeManager::getInstance()->isCurrentThemeValid()){
        this->onRefreshPropertys();
    }

    emit this->initialized();
}

int TThemeBinder::getId() const
{
    Q_D(const TThemeBinder);
    return d->m_iId;
}

bool TThemeBinder::isEnabled() const
{
    Q_D(const TThemeBinder);
    return d->m_bEnabled;
}

const QString &TThemeBinder::getGroupName() const
{
    Q_D(const TThemeBinder);
    return d->m_strGroup;
}

const QString &TThemeBinder::getClassName() const
{
    Q_D(const TThemeBinder);
    return d->m_strClass;
}

const QString &TThemeBinder::getChildName() const
{
    Q_D(const TThemeBinder);
    return d->m_strChild;
}

const QString &TThemeBinder::getStateName() const
{
    Q_D(const TThemeBinder);
    return d->m_strState;
}

QObject *TThemeBinder::getTarget() const
{
    Q_D(const TThemeBinder);
    return d->m_pTarget;
}

QStringList TThemeBinder::getFilterPropertyName() const
{
    Q_D(const TThemeBinder);
    return d->m_listFilterPropertyName;
}

QStringList TThemeBinder::getDynamicListener() const
{
    Q_D(const TThemeBinder);
    return d->m_listDynamicListener;
}

bool TThemeBinder::getStateAsynchronous() const
{
    Q_D(const TThemeBinder);
    return d->m_bStateAsynchronous;
}

QMap<QString, QVariant> TThemeBinder::getBindingPropertyMap() const
{
    Q_D(const TThemeBinder);
    return d->m_mapBindingNameToProperty;
}

int TThemeBinder::getChildsCount() const
{
    Q_D(const TThemeBinder);
    return d->m_listChilds.count();
}

QList<TThemeBinder *> TThemeBinder::getAllBinders()
{
    return TThemeBinderPrivate::sm_listAllBinders;
}

QString TThemeBinder::generateFieldKey(const QString &strClass, const QString &strGroup, const QString &strState)
{
    QString strKey = strClass;
    if (!strGroup.isEmpty()) {
        strKey += "#" + strGroup;
    }
    if (!strState.isEmpty()) {
        strKey += ":" + strState;
    }
    return strKey;
}

QStringList TThemeBinder::generateFieldKeyList(const QString &strClass, const QString &strGroup, const QString &strState)
{
    QStringList listKey;
    listKey.append(TThemeBinder::generateFieldKey(strClass, strGroup, strState));
    listKey.append(TThemeBinder::generateFieldKey(strClass, strGroup, ""));
    listKey.append(TThemeBinder::generateFieldKey(strClass, "", strState));
    listKey.append(TThemeBinder::generateFieldKey(strClass, "", ""));
    listKey.removeDuplicates();
    return listKey;
}

TThemeBinder *TThemeBinder::getChild(const int &iIndex) const
{
    Q_D(const TThemeBinder);
    if (d->m_listChilds.count() <= iIndex) {
        qCritical() << "QTKStyleBinder::getChild():iIndex out of range!";
        return nullptr;
    }
    return d->m_listChilds.at(iIndex);
}

QQmlListProperty<TThemeBinder> TThemeBinder::getQmlChilds()
{
    Q_D(TThemeBinder);
    return QQmlListProperty<TThemeBinder>(this, d->m_listChilds);
}

QList<TThemeBinder *> TThemeBinder::getChilds()
{
    Q_D(TThemeBinder);
    return d->m_listChilds;
}

void TThemeBinder::addChild(TThemeBinder *pChild)
{
    Q_D(TThemeBinder);
    if (!d->m_listChilds.contains(pChild)) {
        d->m_listChilds.append(pChild);
        connect(pChild, &TThemeBinder::destroyed, [=](){
            if (TThemeBinderPrivate::sm_listAllBinders.contains(this)) {
                d->m_listChilds.removeOne(pChild);
            }
        });
        pChild->setParent(this);
    }
}

TThemeBinder *TThemeBinder::getParent() const
{
    Q_D(const TThemeBinder);
    return d->m_pParent;
}

void TThemeBinder::setEnabled(const bool &bEnabled)
{
    Q_D(TThemeBinder);
    static QMetaObject::Connection connection;
    if(bEnabled != d->m_bEnabled) {
        d->m_bEnabled = bEnabled;
        if (d->m_bEnabled) {
            connection = connect(TThemeManager::getInstance(), &TThemeManager::currentThemeChanged, this, &TThemeBinder::onRefreshPropertys);
        } else {
            disconnect(connection);
        }
        emit this->enabledChanged();
    }
}

void TThemeBinder::setGroupName(const QString &strName)
{
    Q_D(TThemeBinder);
    if (strName != d->m_strGroup) {
        d->m_strGroup = strName;
        emit this->groupNameChanged();
    }
}

void TThemeBinder::setClassName(const QString &strName)
{
    Q_D(TThemeBinder);
    if (strName != d->m_strClass) {
        d->m_strClass = strName;
        emit this->classNameChanged();
    }
}

void TThemeBinder::setChildName(const QString &strName)
{
    Q_D(TThemeBinder);
    if (strName != d->m_strChild) {
        d->m_strChild = strName;
        emit this->childNameChanged();
    }
}

void TThemeBinder::setState(const QString &strState)
{
    Q_D(TThemeBinder);
    if (strState != d->m_strState) {
        d->m_strState = strState;
        TThemeManager::getInstance()->generateThemeTemplateFile(this);
        if(!d->m_bStateAsynchronous && TThemeManager::getInstance()->isCurrentThemeValid()){
            this->onRefreshPropertys();
        }
        emit this->stateChanged();
    }
}

void TThemeBinder::setTarget(QObject *pTarget)
{
    Q_D(TThemeBinder);
    if (pTarget != d->m_pTarget) {
        d->m_pTarget = pTarget;
        emit this->targetChanged();
    }
}

void TThemeBinder::setFilterPropertyName(const QStringList &listName)
{
    Q_D(TThemeBinder);
    if (listName != d->m_listFilterPropertyName) {
        d->m_listFilterPropertyName += listName;
        emit this->filterPropertyNameChanged();
    }
}

void TThemeBinder::setDynamicListener(const QStringList &listListener)
{
    Q_D(TThemeBinder);
    if (listListener != d->m_listDynamicListener) {
        d->m_listDynamicListener = listListener;
        emit this->dynamicListenerChanged(listListener);
    }
}

void TThemeBinder::setStateAsynchronous(const bool &bAsynchronous)
{
    Q_D(TThemeBinder);
    if (bAsynchronous != d->m_bStateAsynchronous) {
        d->m_bStateAsynchronous = bAsynchronous;
        emit this->stateAsynchronousChanged();
    }
}

void TThemeBinder::setParent(TThemeBinder *pParent)
{
    Q_D(TThemeBinder);
    if (nullptr != d->m_pParent || pParent == d->m_pParent) {
        return;
    }
    if (!TThemeBinderPrivate::sm_listAllBinders.contains(pParent)) {
        return;
    }

    d->m_pParent = pParent;
    pParent->addChild(this);

    this->setFilterPropertyName(d->m_pParent->getFilterPropertyName());
    this->setClassName(d->m_pParent->getClassName());
    this->setGroupName(d->m_pParent->getGroupName());
    this->setEnabled(d->m_pParent->isEnabled());
    this->setState(d->m_pParent->getStateName());
    this->setStateAsynchronous(d->m_pParent->getStateAsynchronous());

    connect(d->m_pParent, &TThemeBinder::classNameChanged, this, [this]() {
        Q_D(TThemeBinder);
        this->setClassName(d->m_pParent->getClassName());
    });
    connect(d->m_pParent, &TThemeBinder::groupNameChanged, this, [this]() {
        Q_D(TThemeBinder);
        this->setGroupName(d->m_pParent->getGroupName());
    });
    connect(d->m_pParent, &TThemeBinder::stateChanged, this, [this]() {
        Q_D(TThemeBinder);
        this->setState(d->m_pParent->getStateName());
    });
    connect(d->m_pParent, &TThemeBinder::enabledChanged, this, [this]() {
        Q_D(TThemeBinder);
        this->setEnabled(d->m_pParent->isEnabled());
    });
    connect(d->m_pParent, &TThemeBinder::stateAsynchronousChanged, this, [this]() {
        Q_D(TThemeBinder);
        this->setStateAsynchronous(d->m_pParent->getStateAsynchronous());
    });

    emit this->parentChanged();
}

void TThemeBinder::onRefreshPropertys()
{
    qDebug() << "TThemeBinderPrivate::onRefreshPropertys()-------------------";
    Q_D(TThemeBinder);
    if(!d->m_bEnabled) {
        return;
    }

    QObject *pTarget = (nullptr == d->m_pTarget) ? this : d->m_pTarget;
    QMapIterator<QString, QVariant> mapIter(d->m_mapBindingNameToProperty);

    while (mapIter.hasNext()) {
        mapIter.next();
        if(!TThemeManager::getInstance()->isCurrentThemeValid()){
            //send default to qml property
            QVariant result(mapIter.value());
            pTarget->setProperty(mapIter.key().toStdString().c_str(), result);
        } else {
            QVariant result(mapIter.value().type());
            result.setValue(d->getPropertyData(mapIter.key()));
            if(result.isValid()){
                pTarget->setProperty(mapIter.key().toStdString().c_str(), result);
            }
        }
    }
}

void TThemeBinder::onPropertyChanged()
{
    //    qDebug() << "TThemeBinderPrivate::onPropertyChanged()-----------------";
    Q_D(TThemeBinder);
    QString strMethodName = this->metaObject()->method(this->senderSignalIndex()).name();
    if(strMethodName.contains("Changed")) {
        QString strBindingName = QString(strMethodName.mid(0, strMethodName.indexOf("Changed")));

        QVariant result(this->property(strBindingName.toStdString().c_str()).type());
        QVariant change(this->property(strBindingName.toStdString().c_str()));

        if(TThemeManager::getInstance()->isCurrentThemeValid()){
            result.setValue(d->getPropertyData(strBindingName));
            if(result.isValid() && result == change) {
                return; //don't need change
            }
        }
        d->m_mapBindingNameToProperty[strBindingName] = this->property(strBindingName.toStdString().c_str());
    }
}
