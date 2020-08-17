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

#ifndef TTHEMEBINDER_H
#define TTHEMEBINDER_H

#include <QObject>
#include <QScopedPointer>
#include <QJsonObject>
#include <QQmlListProperty>

class TThemeBinderPrivate;
class TThemeBinder : public QObject
{
    Q_OBJECT
    Q_DECLARE_PRIVATE(TThemeBinder)
    Q_DISABLE_COPY(TThemeBinder)

    Q_PROPERTY(bool enabled READ isEnabled WRITE setEnabled NOTIFY enabledChanged)
    Q_PROPERTY(QString groupName READ getGroupName WRITE setGroupName NOTIFY groupNameChanged)
    Q_PROPERTY(QString className READ getClassName WRITE setClassName NOTIFY classNameChanged)
    Q_PROPERTY(QString childName READ getChildName WRITE setChildName NOTIFY childNameChanged)
    Q_PROPERTY(QString state READ getStateName WRITE setState NOTIFY stateChanged)
    Q_PROPERTY(QObject* target READ getTarget WRITE setTarget NOTIFY targetChanged)
    Q_PROPERTY(QStringList filterPropertyName READ getFilterPropertyName WRITE setFilterPropertyName NOTIFY filterPropertyNameChanged)
    Q_PROPERTY(QStringList dynamicListener READ getDynamicListener WRITE setDynamicListener NOTIFY dynamicListenerChanged)
    Q_PROPERTY(bool stateAsynchronous READ getStateAsynchronous WRITE setStateAsynchronous NOTIFY stateAsynchronousChanged)
    Q_PROPERTY(TThemeBinder* parent READ getParent WRITE setParent NOTIFY parentChanged)
    Q_PROPERTY(QQmlListProperty<TThemeBinder> childs READ getQmlChilds)
    Q_CLASSINFO("DefaultProperty", "childs")

public:
    explicit TThemeBinder(QObject *parent = nullptr);
    virtual ~TThemeBinder();

    /**
     * @brief initialize
     * binding trigger styledata
     * must init in Component.onCompleted: {}
     * such as Component.onCompleted: initialize()
     */
    Q_INVOKABLE void initialize();

    int getId() const;
    bool isEnabled() const;
    const QString &getGroupName() const;
    const QString &getClassName() const;
    const QString &getChildName() const;
    const QString &getStateName() const;
    QObject *getTarget() const;
    QStringList getFilterPropertyName() const;
    QStringList getDynamicListener() const;
    bool getStateAsynchronous() const;
    QMap<QString, QVariant> getBindingPropertyMap() const;

    TThemeBinder *getParent() const;
    TThemeBinder *getChild(const int &iIndex) const;
    QQmlListProperty<TThemeBinder> getQmlChilds();
    QList<TThemeBinder *> getChilds();
    void addChild(TThemeBinder *pChild);
    int getChildsCount() const;

    static QList<TThemeBinder *> getAllBinders();
    static QString generateFieldKey(const QString &strClass,
                                    const QString &strGroup,
                                    const QString &strState);
    static QStringList generateFieldKeyList(const QString &strClass,
                                            const QString &strGroup,
                                            const QString &strState);

Q_SIGNALS:
    void enabledChanged();
    void groupNameChanged();
    void classNameChanged();
    void childNameChanged();
    void stateChanged();
    void targetChanged();
    void filterPropertyNameChanged();
    void dynamicListenerChanged(const QStringList &listListener);
    void stateAsynchronousChanged();
    void parentChanged();
    void initialized();

public Q_SLOTS:
    void setEnabled(const bool &bEnabled);
    void setGroupName(const QString &strName);
    void setClassName(const QString &strName);
    void setChildName(const QString &strName);
    void setState(const QString &strState);
    void setTarget(QObject *pTarget);
    void setFilterPropertyName(const QStringList &listName);
    void setDynamicListener(const QStringList &listListener);
    void setStateAsynchronous(const bool &bAsynchronous);
    void setParent(TThemeBinder *pParent);

    void onRefreshPropertys();
    void onPropertyChanged();

protected:
    TThemeBinderPrivate *d_ptr;
};

#endif // TTHEMEBINDER_H
