#ifndef TGADGETBORDER_H
#define TGADGETBORDER_H

#include <QColor>
#include <QObject>

class TGadgetBorderPrivate;
class TGadgetBorder : public QObject
{
    Q_OBJECT
    Q_DECLARE_PRIVATE(TGadgetBorder)
    Q_DISABLE_COPY(TGadgetBorder)

    Q_PROPERTY(int width READ getWidth WRITE setWidth NOTIFY widthChanged)
    Q_PROPERTY(QColor color READ getColor WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(int leftWidth READ getLeftWidth WRITE setLeftWidth NOTIFY leftWidthChanged)
    Q_PROPERTY(int rightWidth READ getRightWidth WRITE setRightWidth NOTIFY rightWidthChanged)
    Q_PROPERTY(int topWidth READ getTopWidth WRITE setTopWidth NOTIFY topWidthChanged)
    Q_PROPERTY(int bottomWidth READ getBottomWidth WRITE setBottomWidth NOTIFY bottomWidthChanged)
    Q_PROPERTY(bool valid READ isValid NOTIFY validChanged)

public:
    explicit TGadgetBorder(QObject *parent = nullptr);
    ~TGadgetBorder();

    QColor getColor() const;
    int getWidth() const;
    int getLeftWidth() const;
    int getRightWidth() const;
    int getTopWidth() const;
    int getBottomWidth() const;
    bool isValid() const;

signals:
    void colorChanged();
    void widthChanged();
    void leftWidthChanged();
    void rightWidthChanged();
    void topWidthChanged();
    void bottomWidthChanged();
    void validChanged();

private slots:
    void setColor(const QColor color);
    void setWidth(const int &iWidth);
    void setLeftWidth(const int &iLeftWidth);
    void setRightWidth(const int &iRightWidth);
    void setTopWidth(const int &iTopWidth);
    void setBottomWidth(const int &iBottomWidth);

private:
    TGadgetBorderPrivate *d_ptr;
};

#endif // TGADGETBORDER_H
