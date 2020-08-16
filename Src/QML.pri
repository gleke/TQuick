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
# Prevent duplicate include QML.pri
!isEmpty(QML_PRI_INCLUDED):error("QML.pri already included")
QML_PRI_INCLUDED = 1

include(../TQuick.pri)

# QMLs.pri test
QML_TEST = false
isEqual(QML_TEST, "true") {
    message("QML.pri -------------------------------------------------")
    message("_PRO_FILE_PWD_=" $$_PRO_FILE_PWD_)
}

DISTFILES += \
    $$PWD/qmldir \
    $$PWD/TQuickLoader

isEqual(QML_SHARED_BUILD, "true") {
    CONFIG += sharedlib
} else {
    CONFIG += staticlib
}
TARGET = $$TQUICK_NAME
QT += qml quick
TEMPLATE = lib
DEFINES += QT_QML_DEBUG_NO_WARNING
CONFIG += plugin plugin_with_soname
DESTDIR = $$TQUICK_QML_DIR/$$TARGET
TARGET = $$tLibraryTargetName($$TARGET)


TQUICK_QMLDIR_PATH = $$system_path($$clean_path($$PWD/qmldir))
TQUICK_INCLUDEFILE_PATH = $$system_path($$clean_path($$PWD/TQuickLoader))
TQUICK_HEADERFILE_PATH = $$system_path($$clean_path($$PWD/tquickloader.h))
TQUICK_LIB_VERSION = $${TQUICK_LIB_VERSION_MAJOR}.$${TQUICK_LIB_VERSION_MINOR}
TQUICK_LIB_OUTPUT_DIR = $$system_path($${TQUICK_QML_DIR}/$${TQUICK_NAME})
TQUICK_PLUGIN_INSTALL_DIR = $$system_path($$[QT_INSTALL_QML]/$${TQUICK_NAME})
TQUICK_PLUGIN_DUMP_PATH = $$system_path($$[QT_INSTALL_BINS]/qmlplugindump)

isEqual(QML_TEST, "true") {
    message("TQUICK_QMLDIR_PATH=" $$TQUICK_QMLDIR_PATH)
    message("TQUICK_INCLUDEFILE_PATH=" $$TQUICK_INCLUDEFILE_PATH)
    message("TQUICK_HEADERFILE_PATH=" $$TQUICK_HEADERFILE_PATH)
    message("TQUICK_LIB_VERSION=" $$TQUICK_LIB_VERSION)
    message("TQUICK_LIB_OUTPUT_DIR=" $$TQUICK_LIB_OUTPUT_DIR)
    message("TQUICK_PLUGIN_INSTALL_DIR=" $$TQUICK_PLUGIN_INSTALL_DIR)
    message("TQUICK_PLUGIN_DUMP_PATH=" $$TQUICK_PLUGIN_DUMP_PATH)
}

contains(QMAKE_HOST.os, Windows) {
    QMAKE_PRE_LINK += copy $${TQUICK_QMLDIR_PATH} $${TQUICK_LIB_OUTPUT_DIR} &&
    QMAKE_PRE_LINK += copy $${TQUICK_INCLUDEFILE_PATH} $${TQUICK_LIB_OUTPUT_DIR} &&
    QMAKE_PRE_LINK += copy $${TQUICK_HEADERFILE_PATH} $${TQUICK_LIB_OUTPUT_DIR}
    exists($${TQUICK_PLUGIN_INSTALL_DIR}) {
        QMAKE_PRE_LINK += && rd /s/q $${TQUICK_PLUGIN_INSTALL_DIR}
    }
    isEqual(QML_SHARED_BUILD, "true") {
        QMAKE_POST_LINK += md $${TQUICK_PLUGIN_INSTALL_DIR} &&
        QMAKE_POST_LINK += copy $${TQUICK_LIB_OUTPUT_DIR} $${TQUICK_PLUGIN_INSTALL_DIR} &&
        QMAKE_POST_LINK += $$system_path($$[QT_INSTALL_BINS]/qmlplugindump) -notrelocatable $${TQUICK_NAME} $${TQUICK_LIB_VERSION} $$system_path($$[QT_INSTALL_QML]) > $$system_path($${TQUICK_PLUGIN_INSTALL_DIR}/plugin.qmltypes) &&
        QMAKE_POST_LINK += copy $$system_path($${TQUICK_PLUGIN_INSTALL_DIR}/plugin.qmltypes) $${TQUICK_LIB_OUTPUT_DIR}
    }
} else {
    QMAKE_PRE_LINK += cp $$TQUICK_QMLDIR_PATH $${TQUICK_LIB_OUTPUT_DIR};
    QMAKE_PRE_LINK += cp $$TQUICK_INCLUDEFILE_PATH $${TQUICK_LIB_OUTPUT_DIR};
    QMAKE_PRE_LINK += cp $$TQUICK_HEADERFILE_PATH $${TQUICK_LIB_OUTPUT_DIR};
    QMAKE_PRE_LINK += rm -rf $${TQUICK_PLUGIN_INSTALL_DIR};
    isEqual(QML_SHARED_BUILD, "true") {
        QMAKE_POST_LINK += cp -rf $${TQUICK_LIB_OUTPUT_DIR} $$[QT_INSTALL_QML];
        QMAKE_POST_LINK += $$[QT_INSTALL_BINS]/qmlplugindump -notrelocatable $${TQUICK_NAME} $${TQUICK_LIB_VERSION} $$[QT_INSTALL_QML] > $${TQUICK_PLUGIN_INSTALL_DIR}/plugin.qmltypes;
        QMAKE_POST_LINK += cp $${TQUICK_PLUGIN_INSTALL_DIR}/plugin.qmltypes $${TQUICK_LIB_OUTPUT_DIR};
    }
}
