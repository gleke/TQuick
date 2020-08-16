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
# Prevent duplicate include TQuick.pri
!isEmpty(TQUICK_PRI_INCLUDED):error("TQuick.pri already included")
TQUICK_PRI_INCLUDED = 1

# TQUICK.pri test
TQUICK_TEST = 0
isEqual(TQUICK_TEST, "true") {
    message("TQUICK.pri -------------------------------------------------")
    message("_PRO_FILE_PWD_=" $$_PRO_FILE_PWD_)
}

QML_SHARED_BUILD = true

##-------------------------------------------------------------------------
# defines TQUICK info
isEmpty(TQUICK_LIB_VERSION_MAJOR): TQUICK_LIB_VERSION_MAJOR = 1
isEmpty(TQUICK_LIB_VERSION_MINOR): TQUICK_LIB_VERSION_MINOR = 1
isEmpty(TQUICK_LIB_VERSION_PATCH): TQUICK_LIB_VERSION_PATCH = 0
isEmpty(TQUICK_LIB_VERSION_BUILD): TQUICK_LIB_VERSION_BUILD = 0
isEmpty(TQUICK_LIB_VERSION_STAGE): TQUICK_LIB_VERSION_STAGE = alpha
isEmpty(TQUICK_LIB_VERSION_BRANCH): TQUICK_LIB_VERSION_BRANCH = dev
isEmpty(TQUICK_LIB_VERSION_NUMBER): TQUICK_LIB_VERSION_NUMBER = $${TQUICK_LIB_VERSION_MAJOR}.$${TQUICK_LIB_VERSION_MINOR}.$${TQUICK_LIB_VERSION_PATCH}.$${TQUICK_LIB_VERSION_BUILD}
isEmpty(TQUICK_LIB_VERSION_DISPLAY): TQUICK_LIB_VERSION_DISPLAY = $${TQUICK_LIB_VERSION_NUMBER}_$${TQUICK_LIB_VERSION_STAGE}
isEmpty(TQUICK_COMPAT_VERSION): TQUICK_COMPAT_VERSION = 0.1
isEmpty(TQUICK_COPYRIGHT_YEAR): TQUICK_COPYRIGHT_YEAR = 2020
isEmpty(TQUICK_NAME): TQUICK_NAME = TQuick

isEqual(TQUICK_TEST, "true") {
    message("TQUICK_LIB_VERSION_MAJOR=" $$TQUICK_LIB_VERSION_MAJOR)
    message("TQUICK_LIB_VERSION_MINOR=" $$TQUICK_LIB_VERSION_MINOR)
    message("TQUICK_LIB_VERSION_PATCH=" $$TQUICK_LIB_VERSION_PATCH)
    message("TQUICK_LIB_VERSION_BUILD=" $$TQUICK_LIB_VERSION_BUILD)
    message("TQUICK_LIB_VERSION_STAGE=" $$TQUICK_LIB_VERSION_STAGE)
    message("TQUICK_LIB_VERSION_BRANCH=" $$TQUICK_LIB_VERSION_BRANCH)
    message("TQUICK_LIB_VERSION_NUMBER=" $$TQUICK_LIB_VERSION_NUMBER)
    message("TQUICK_LIB_VERSION_DISPLAY=" $$TQUICK_LIB_VERSION_DISPLAY)
    message("TQUICK_COMPAT_VERSION=" $$TQUICK_COMPAT_VERSION)
    message("TQUICK_COPYRIGHT_YEAR=" $$TQUICK_COPYRIGHT_YEAR)
    message("TQUICK_NAME=" $$TQUICK_NAME)
}



##-------------------------------------------------------------------------
# define lib target name function
defineReplace(tLibraryTargetName) {
   unset(LIBRARY_NAME)
   LIBRARY_NAME = $$1
   CONFIG(debug, debug|release) {
      !debug_and_release|build_pass {
          mac:RET = $$member(LIBRARY_NAME, 0)_debug
              else:win32:RET = $$member(LIBRARY_NAME, 0)d
      }
   }
   isEmpty(RET):RET = $$LIBRARY_NAME
   return($$RET)
}

# define Requires minimum qt version function
defineTest(tquickMinQtVersion) {
    maj = $$1
    min = $$2
    patch = $$3
    isEqual(QT_MAJOR_VERSION, $$maj) {
        isEqual(QT_MINOR_VERSION, $$min) {
            isEqual(QT_PATCH_VERSION, $$patch) {
                return(true)
            }
            greaterThan(QT_PATCH_VERSION, $$patch) {
                return(true)
            }
        }
        greaterThan(QT_MINOR_VERSION, $$min) {
            return(true)
        }
    }
    greaterThan(QT_MAJOR_VERSION, $$maj) {
        return(true)
    }
    return(false)
}



##-------------------------------------------------------------------------
# Use c ++ 11 standard
CONFIG += c++11

qt {
    contains(QT, core): QT += concurrent
    contains(QT, gui): QT += widgets
}



##-------------------------------------------------------------------------
TQUICK_SOURCE_DIR = $$PWD
isEmpty(TQUICK_BUILD_DIR) {
    sub_dir = $$_PRO_FILE_PWD_
    sub_dir ~= s,^$$re_escape($$PWD),,
    TQUICK_BUILD_DIR = $$clean_path($$OUT_PWD)
    TQUICK_BUILD_DIR ~= s,$$re_escape($$sub_dir)$,,
}
isEqual(TQUICK_SOURCE_DIR, $$TQUICK_BUILD_DIR) {
    error("$$TQUICK_NAME Not in shadow build mode!")
}

osx {
    TQUICK_LIB_OUTPUT_DIR = $$TQUICK_BUILD_DIR
    TQUICK_QML_DIR = $$TQUICK_LIB_OUTPUT_DIR/qml
    TQUICK_EXEC_DIR = $$TQUICK_LIB_OUTPUT_DIR/LibExecs
    TQUICK_DATA_DIR = $$TQUICK_LIB_OUTPUT_DIR/Resources
    TQUICK_DOC_DIR = $$TQUICK_LIB_OUTPUT_DIR/doc
} else {
    contains(TEMPLATE, vc.*):vcproj = 1

    TQUICK_LIB_OUTPUT_DIR = $$TQUICK_BUILD_DIR
    TQUICK_QML_DIR = $$TQUICK_LIB_OUTPUT_DIR/qml
    TQUICK_EXEC_DIR = $$TQUICK_LIB_OUTPUT_DIR/libexec
    TQUICK_DATA_DIR = $$TQUICK_LIB_OUTPUT_DIR/share
    TQUICK_DOC_DIR = $$TQUICK_LIB_OUTPUT_DIR/share/doc
}

TQUICK_RELATIVE_QML_DIR = $$relative_path($$TQUICK_QML_DIR, $$TQUICK_EXEC_DIR)
TQUICK_RELATIVE_DATA_DIR = $$relative_path($$TQUICK_DATA_DIR, $$TQUICK_EXEC_DIR)
TQUICK_RELATIVE_DOC_DIR = $$relative_path($$TQUICK_DOC_DIR, $$TQUICK_EXEC_DIR)

isEqual(TQUICK_TEST, "true") {
    message("TQUICK_SOURCE_DIR=" $$TQUICK_SOURCE_DIR)
    message("TQUICK_BUILD_DIR=" $$TQUICK_BUILD_DIR)
    message("TQUICK_LIB_OUTPUT_DIR=" $$TQUICK_LIB_OUTPUT_DIR)
    message("TQUICK_QML_DIR=" $$TQUICK_QML_DIR)
    message("TQUICK_EXEC_DIR=" $$TQUICK_EXEC_DIR)
    message("TQUICK_DATA_DIR=" $$TQUICK_DATA_DIR)
    message("TQUICK_DOC_DIR=" $$TQUICK_DOC_DIR)
    message("TQUICK_RELATIVE_DATA_DIR=" $$TQUICK_RELATIVE_DATA_DIR)
    message("TQUICK_RELATIVE_DOC_DIR=" $$TQUICK_RELATIVE_DOC_DIR)
}



##-------------------------------------------------------------------------
# define header info file
DISTFILES += \
    $$PWD/Src/tquickinfo.h.in \
    $$TQUICK_BUILD_DIR/Src/tquickinfo.h

tquickinfo.input = $$PWD/Src/tquickinfo.h.in
tquickinfo.output = $$TQUICK_BUILD_DIR/Src/tquickinfo.h
QMAKE_SUBSTITUTES += tquickinfo

INCLUDEPATH += $$TQUICK_BUILD_DIR/Src



##-------------------------------------------------------------------------
# define source dirs var
TQUICK_LIB_SOURCE_DIRS += $$TQUICK_SOURCE_DIR/Src/Libs # lib source dirs
TQUICK_PLUGIN_SOURCE_DIRS += $$TQUICK_SOURCE_DIR/Src/Plugins # plugin source dirs
TQUICK_QML_SOURCE_DIRS += $$TQUICK_SOURCE_DIR/Src/QMLs # qml source dirs



##-------------------------------------------------------------------------
## rpath lib
unix {
TQUICK_LIB_RPATH_FLAGS = -Wl,-rpath,$${TQUICK_QML_DIR}
for(dir, TQUICK_QML_DIRS) {
    exists($$dir) {
        TQUICK_LIB_RPATH_FLAGS += :$${dir}
        break()
    }
}
QMAKE_LFLAGS += $$TQUICK_LIB_RPATH_FLAGS
}



##-------------------------------------------------------------------------
# include qml build dir
!isEmpty(TQUICK_QML_NAME) {
    TQUICK_QML_BUILD_PATH = $$TQUICK_QML_DIR/$$TQUICK_QML_NAME
    exists(TQUICK_QML_BUILD_PATH) {
        INCLUDEPATH += $$TQUICK_QML_BUILD_PATH  # for .in to .h file in case of actual build directory
    }
}

# recursively resolve plugin deps
done_tquickqmls =
for(ever) {
    isEmpty(TQUICK_QML_DEPENDS): break()
    done_tquickqmls += $$TQUICK_QML_DEPENDS $$TQUICK_LIB_DEPENDS
    for(dep, TQUICK_QML_DEPENDS) {
        lib = $${dep}
        dependencies_file =
        for(dir, TQUICK_LIB_SOURCE_DIRS) {
            exists($$dir/$$dep/$${dep}_dependencies.pri) {
                dependencies_file = $$dir/$$dep/$${dep}_dependencies.pri
                LIBS += -L$$TQUICK_LIB_DIR -l$$tLibraryTargetName($$lib)
                INCLUDEPATH += $$dir/$$dep/Include
#                message([$$TQUICK_NAME] $$dir/$$dep/Include)
#                message([$$TQUICK_NAME] -L$$TQUICK_LIB_DIR -l$$tLibraryTargetName($$lib))
                break()
            }
        }
        for(dir, TQUICK_QML_SOURCE_DIRS) {
            exists($$dir/$$dep/$${dep}_dependencies.pri) {
                dependencies_file = $$dir/$$dep/$${dep}_dependencies.pri
                LIBS += -L$$TQUICK_QML_DIR/$$lib -l$$tLibraryTargetName($$lib)
                INCLUDEPATH += $$dir/$$dep/Include
#                message([$$TQUICK_NAME] $$dir/$$dep/Include)
#                message([$$TQUICK_NAME] -L$$TQUICK_QML_DIR/$$lib -l$$tLibraryTargetName($$lib))
                # Additional import path used to resolve QML modules in Qt Creator's code model
                QML_IMPORT_PATH = $$TQUICK_QML_DIR
                # Additional import path used to resolve QML modules just for Qt Quick Designer
                QML_DESIGNER_IMPORT_PATH = $$TQUICK_QML_DIR
                break()
            }
        }
        isEmpty(dependencies_file): error("QML dependency $$dep not found")
        include($$dependencies_file)
    }
    TQUICK_QML_DEPENDS = $$unique(TQUICK_QML_DEPENDS)
    TQUICK_QML_DEPENDS += $$unique(TQUICK_LIB_DEPENDS)
    TQUICK_QML_DEPENDS -= $$unique(done_tquickqmls)
}
