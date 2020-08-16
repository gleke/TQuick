INCLUDEPATH += $$PWD
DEPENDPATH += $$PWD

HEADERS += \
    $$PWD/tquick.h \
    $$PWD/tquickglobal.h \
    $$PWD/tquickloader.h \
    $$PWD/tquickqmlplugin.h \
    $$PWD/tquickworld.h

SOURCES += \
    $$PWD/tquick.cpp \
    $$PWD/tquickglobal.cpp \
    $$PWD/tquickloader.cpp \
    $$PWD/tquickqmlplugin.cpp \
    $$PWD/tquickworld.cpp

include($$PWD/theme/theme.pri)
include($$PWD/controls/gadget/gadget.pri)
include($$PWD/controls/interface/interface.pri)

RESOURCES += \
    $$PWD/TQuick.qrc
