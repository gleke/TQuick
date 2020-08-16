###########################################################################
#
#  Library: TQuick
#
#  MIT License
#
#  Copyright (c) 2020 chengxuewen <1398831004@qq.com>
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in all
#  copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#  SOFTWARE.
#
###########################################################################
##-------------------------------------------------------------------------
# Prevent duplicate include Examples.pri
!isEmpty(EXAMPLES_PRI_INCLUDED):error("Examples.pri already included")
EXAMPLES_PRI_INCLUDED = 1

include(../TQuick.pri)

# EXAMPLESs.pri test
EXAMPLES_TEST = false
isEqual(EXAMPLES_TEST, "true") {
    message("Examples.pri -------------------------------------------------")
    message("_PRO_FILE_PWD_=" $$_PRO_FILE_PWD_)
}

QT += quick
CONFIG += c++11

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

!isEqual(QML_SHARED_BUILD, "true") {
    QML_LIB_NAME = $$tLibraryTargetName($$TQUICK_NAME)

    # Additional import path used to resolve QML modules in Qt Creator's code model
    QML_IMPORT_PATH = $$TQUICK_QML_DIR/

    # Additional import path used to resolve QML modules just for Qt Quick Designer
    QML_DESIGNER_IMPORT_PATH = $$TQUICK_QML_DIR/

    INCLUDEPATH += $$TQUICK_QML_DIR/$${TQUICK_NAME}/
    DEPENDPATH += $$TQUICK_QML_DIR/$${TQUICK_NAME}/
    DEFINES += STATICLIB

    LIBS += -L$$TQUICK_QML_DIR/$${TQUICK_NAME}/ -l$${QML_LIB_NAME}

    isEqual(EXAMPLES_TEST, "true") {
        message(QML_LIB_NAME= $${QML_LIB_NAME})
        message(QML_IMPORT_PATH= $${QML_IMPORT_PATH})
        message(QML_DESIGNER_IMPORT_PATH= $${QML_DESIGNER_IMPORT_PATH})
        message(INCLUDEPATH= $${INCLUDEPATH})
        message(DEPENDPATH= $${DEPENDPATH})
        message(LIBS= $${LIBS})
        message(PRE_TARGETDEPS= $${PRE_TARGETDEPS})
    }
}


