# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'CGNS/NAV/T/Q7LinkWindow.ui'
#
# Created: Thu Jun 13 09:00:14 2013
#      by: pyside-uic 0.2.13 running on PySide 1.0.9
#
# WARNING! All changes made in this file will be lost!

from PySide import QtCore, QtGui

class Ui_Q7LinkWindow(object):
    def setupUi(self, Q7LinkWindow):
        Q7LinkWindow.setObjectName("Q7LinkWindow")
        Q7LinkWindow.resize(715, 350)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(Q7LinkWindow.sizePolicy().hasHeightForWidth())
        Q7LinkWindow.setSizePolicy(sizePolicy)
        Q7LinkWindow.setMinimumSize(QtCore.QSize(715, 350))
        Q7LinkWindow.setMaximumSize(QtCore.QSize(3000, 750))
        icon = QtGui.QIcon()
        icon.addPixmap(QtGui.QPixmap(":/images/icons/cgSpy.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        Q7LinkWindow.setWindowIcon(icon)
        self.gridLayout = QtGui.QGridLayout(Q7LinkWindow)
        self.gridLayout.setObjectName("gridLayout")
        self.horizontalLayout_3 = QtGui.QHBoxLayout()
        self.horizontalLayout_3.setObjectName("horizontalLayout_3")
        self.bClearSelectedLink = QtGui.QPushButton(Q7LinkWindow)
        self.bClearSelectedLink.setMinimumSize(QtCore.QSize(25, 25))
        self.bClearSelectedLink.setMaximumSize(QtCore.QSize(25, 25))
        self.bClearSelectedLink.setText("")
        icon1 = QtGui.QIcon()
        icon1.addPixmap(QtGui.QPixmap(":/images/icons/clear-entry.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bClearSelectedLink.setIcon(icon1)
        self.bClearSelectedLink.setObjectName("bClearSelectedLink")
        self.horizontalLayout_3.addWidget(self.bClearSelectedLink)
        self.eDirectorySelectedLink = QtGui.QLineEdit(Q7LinkWindow)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.eDirectorySelectedLink.sizePolicy().hasHeightForWidth())
        self.eDirectorySelectedLink.setSizePolicy(sizePolicy)
        self.eDirectorySelectedLink.setReadOnly(False)
        self.eDirectorySelectedLink.setObjectName("eDirectorySelectedLink")
        self.horizontalLayout_3.addWidget(self.eDirectorySelectedLink)
        self.eFileSelectedLink = QtGui.QLineEdit(Q7LinkWindow)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.eFileSelectedLink.sizePolicy().hasHeightForWidth())
        self.eFileSelectedLink.setSizePolicy(sizePolicy)
        self.eFileSelectedLink.setReadOnly(False)
        self.eFileSelectedLink.setObjectName("eFileSelectedLink")
        self.horizontalLayout_3.addWidget(self.eFileSelectedLink)
        self.eNodeSelectedLink = QtGui.QLineEdit(Q7LinkWindow)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.eNodeSelectedLink.sizePolicy().hasHeightForWidth())
        self.eNodeSelectedLink.setSizePolicy(sizePolicy)
        self.eNodeSelectedLink.setReadOnly(False)
        self.eNodeSelectedLink.setObjectName("eNodeSelectedLink")
        self.horizontalLayout_3.addWidget(self.eNodeSelectedLink)
        self.gridLayout.addLayout(self.horizontalLayout_3, 4, 0, 1, 1)
        self.horizontalLayout = QtGui.QHBoxLayout()
        self.horizontalLayout.setObjectName("horizontalLayout")
        self.bAddLink = QtGui.QPushButton(Q7LinkWindow)
        self.bAddLink.setMinimumSize(QtCore.QSize(25, 25))
        self.bAddLink.setMaximumSize(QtCore.QSize(25, 25))
        self.bAddLink.setText("")
        icon2 = QtGui.QIcon()
        icon2.addPixmap(QtGui.QPixmap(":/images/icons/link-add.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bAddLink.setIcon(icon2)
        self.bAddLink.setObjectName("bAddLink")
        self.horizontalLayout.addWidget(self.bAddLink)
        self.bEditLink = QtGui.QPushButton(Q7LinkWindow)
        self.bEditLink.setMinimumSize(QtCore.QSize(25, 25))
        self.bEditLink.setMaximumSize(QtCore.QSize(25, 25))
        self.bEditLink.setText("")
        icon3 = QtGui.QIcon()
        icon3.addPixmap(QtGui.QPixmap(":/images/icons/link-select.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bEditLink.setIcon(icon3)
        self.bEditLink.setObjectName("bEditLink")
        self.horizontalLayout.addWidget(self.bEditLink)
        self.bDuplicateLink = QtGui.QPushButton(Q7LinkWindow)
        self.bDuplicateLink.setMinimumSize(QtCore.QSize(25, 25))
        self.bDuplicateLink.setMaximumSize(QtCore.QSize(25, 25))
        self.bDuplicateLink.setText("")
        icon4 = QtGui.QIcon()
        icon4.addPixmap(QtGui.QPixmap(":/images/icons/link-dup.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bDuplicateLink.setIcon(icon4)
        self.bDuplicateLink.setObjectName("bDuplicateLink")
        self.horizontalLayout.addWidget(self.bDuplicateLink)
        self.bDeleteLink = QtGui.QPushButton(Q7LinkWindow)
        self.bDeleteLink.setMinimumSize(QtCore.QSize(25, 25))
        self.bDeleteLink.setMaximumSize(QtCore.QSize(25, 25))
        self.bDeleteLink.setText("")
        icon5 = QtGui.QIcon()
        icon5.addPixmap(QtGui.QPixmap(":/images/icons/link-delete.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bDeleteLink.setIcon(icon5)
        self.bDeleteLink.setObjectName("bDeleteLink")
        self.horizontalLayout.addWidget(self.bDeleteLink)
        spacerItem = QtGui.QSpacerItem(40, 20, QtGui.QSizePolicy.Minimum, QtGui.QSizePolicy.Minimum)
        self.horizontalLayout.addItem(spacerItem)
        self.bLoadTree = QtGui.QPushButton(Q7LinkWindow)
        self.bLoadTree.setMinimumSize(QtCore.QSize(25, 25))
        self.bLoadTree.setMaximumSize(QtCore.QSize(25, 25))
        self.bLoadTree.setText("")
        icon6 = QtGui.QIcon()
        icon6.addPixmap(QtGui.QPixmap(":/images/icons/tree-load-g.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bLoadTree.setIcon(icon6)
        self.bLoadTree.setObjectName("bLoadTree")
        self.horizontalLayout.addWidget(self.bLoadTree)
        spacerItem1 = QtGui.QSpacerItem(40, 20, QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Minimum)
        self.horizontalLayout.addItem(spacerItem1)
        self.bSave = QtGui.QPushButton(Q7LinkWindow)
        self.bSave.setMinimumSize(QtCore.QSize(25, 25))
        self.bSave.setMaximumSize(QtCore.QSize(25, 25))
        self.bSave.setText("")
        icon7 = QtGui.QIcon()
        icon7.addPixmap(QtGui.QPixmap(":/images/icons/link-save.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bSave.setIcon(icon7)
        self.bSave.setObjectName("bSave")
        self.horizontalLayout.addWidget(self.bSave)
        self.gridLayout.addLayout(self.horizontalLayout, 2, 0, 1, 1)
        self.verticalLayout = QtGui.QVBoxLayout()
        self.verticalLayout.setObjectName("verticalLayout")
        self.linkTable = QtGui.QTableWidget(Q7LinkWindow)
        self.linkTable.setVerticalScrollBarPolicy(QtCore.Qt.ScrollBarAlwaysOn)
        self.linkTable.setHorizontalScrollBarPolicy(QtCore.Qt.ScrollBarAlwaysOn)
        self.linkTable.setEditTriggers(QtGui.QAbstractItemView.DoubleClicked)
        self.linkTable.setSelectionMode(QtGui.QAbstractItemView.SingleSelection)
        self.linkTable.setSelectionBehavior(QtGui.QAbstractItemView.SelectRows)
        self.linkTable.setColumnCount(5)
        self.linkTable.setObjectName("linkTable")
        self.linkTable.setColumnCount(5)
        self.linkTable.setRowCount(0)
        self.verticalLayout.addWidget(self.linkTable)
        self.gridLayout.addLayout(self.verticalLayout, 5, 0, 1, 1)
        self.horizontalLayout_2 = QtGui.QHBoxLayout()
        self.horizontalLayout_2.setObjectName("horizontalLayout_2")
        self.bBackControl = QtGui.QPushButton(Q7LinkWindow)
        self.bBackControl.setMinimumSize(QtCore.QSize(25, 25))
        self.bBackControl.setMaximumSize(QtCore.QSize(25, 25))
        self.bBackControl.setText("")
        icon8 = QtGui.QIcon()
        icon8.addPixmap(QtGui.QPixmap(":/images/icons/top.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bBackControl.setIcon(icon8)
        self.bBackControl.setObjectName("bBackControl")
        self.horizontalLayout_2.addWidget(self.bBackControl)
        self.bInfo = QtGui.QPushButton(Q7LinkWindow)
        self.bInfo.setMinimumSize(QtCore.QSize(25, 25))
        self.bInfo.setMaximumSize(QtCore.QSize(25, 25))
        self.bInfo.setText("")
        icon9 = QtGui.QIcon()
        icon9.addPixmap(QtGui.QPixmap(":/images/icons/help-view.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bInfo.setIcon(icon9)
        self.bInfo.setObjectName("bInfo")
        self.horizontalLayout_2.addWidget(self.bInfo)
        self.eDirSource = QtGui.QLineEdit(Q7LinkWindow)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.eDirSource.sizePolicy().hasHeightForWidth())
        self.eDirSource.setSizePolicy(sizePolicy)
        self.eDirSource.setObjectName("eDirSource")
        self.horizontalLayout_2.addWidget(self.eDirSource)
        self.label = QtGui.QLabel(Q7LinkWindow)
        self.label.setObjectName("label")
        self.horizontalLayout_2.addWidget(self.label)
        self.eFileSource = QtGui.QLineEdit(Q7LinkWindow)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.eFileSource.sizePolicy().hasHeightForWidth())
        self.eFileSource.setSizePolicy(sizePolicy)
        self.eFileSource.setObjectName("eFileSource")
        self.horizontalLayout_2.addWidget(self.eFileSource)
        spacerItem2 = QtGui.QSpacerItem(40, 20, QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Minimum)
        self.horizontalLayout_2.addItem(spacerItem2)
        self.bClose = QtGui.QPushButton(Q7LinkWindow)
        self.bClose.setObjectName("bClose")
        self.horizontalLayout_2.addWidget(self.bClose)
        self.gridLayout.addLayout(self.horizontalLayout_2, 7, 0, 1, 1)
        self.horizontalLayout_4 = QtGui.QHBoxLayout()
        self.horizontalLayout_4.setObjectName("horizontalLayout_4")
        self.bCheckLink = QtGui.QPushButton(Q7LinkWindow)
        self.bCheckLink.setMinimumSize(QtCore.QSize(25, 25))
        self.bCheckLink.setMaximumSize(QtCore.QSize(25, 25))
        self.bCheckLink.setText("")
        icon10 = QtGui.QIcon()
        icon10.addPixmap(QtGui.QPixmap(":/images/icons/link-check.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bCheckLink.setIcon(icon10)
        self.bCheckLink.setObjectName("bCheckLink")
        self.horizontalLayout_4.addWidget(self.bCheckLink)
        self.label_2 = QtGui.QLabel(Q7LinkWindow)
        self.label_2.setObjectName("label_2")
        self.horizontalLayout_4.addWidget(self.label_2)
        self.cUnreachable = QtGui.QCheckBox(Q7LinkWindow)
        self.cUnreachable.setObjectName("cUnreachable")
        self.horizontalLayout_4.addWidget(self.cUnreachable)
        self.cDuplicates = QtGui.QCheckBox(Q7LinkWindow)
        self.cDuplicates.setObjectName("cDuplicates")
        self.horizontalLayout_4.addWidget(self.cDuplicates)
        self.cBad = QtGui.QCheckBox(Q7LinkWindow)
        self.cBad.setObjectName("cBad")
        self.horizontalLayout_4.addWidget(self.cBad)
        self.cExternal = QtGui.QCheckBox(Q7LinkWindow)
        self.cExternal.setObjectName("cExternal")
        self.horizontalLayout_4.addWidget(self.cExternal)
        self.cInternal = QtGui.QCheckBox(Q7LinkWindow)
        self.cInternal.setObjectName("cInternal")
        self.horizontalLayout_4.addWidget(self.cInternal)
        spacerItem3 = QtGui.QSpacerItem(40, 20, QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Minimum)
        self.horizontalLayout_4.addItem(spacerItem3)
        self.gridLayout.addLayout(self.horizontalLayout_4, 6, 0, 1, 1)

        self.retranslateUi(Q7LinkWindow)
        QtCore.QMetaObject.connectSlotsByName(Q7LinkWindow)

    def retranslateUi(self, Q7LinkWindow):
        Q7LinkWindow.setWindowTitle(QtGui.QApplication.translate("Q7LinkWindow", "Form", None, QtGui.QApplication.UnicodeUTF8))
        self.bClearSelectedLink.setToolTip(QtGui.QApplication.translate("Q7LinkWindow", "clear selected link target", None, QtGui.QApplication.UnicodeUTF8))
        self.bAddLink.setToolTip(QtGui.QApplication.translate("Q7LinkWindow", "add new link entry", None, QtGui.QApplication.UnicodeUTF8))
        self.bEditLink.setToolTip(QtGui.QApplication.translate("Q7LinkWindow", "add entry for selected node target", None, QtGui.QApplication.UnicodeUTF8))
        self.bDuplicateLink.setToolTip(QtGui.QApplication.translate("Q7LinkWindow", "duplicate link entry", None, QtGui.QApplication.UnicodeUTF8))
        self.bDeleteLink.setToolTip(QtGui.QApplication.translate("Q7LinkWindow", "delete link entry", None, QtGui.QApplication.UnicodeUTF8))
        self.bLoadTree.setToolTip(QtGui.QApplication.translate("Q7LinkWindow", "open link target file", None, QtGui.QApplication.UnicodeUTF8))
        self.linkTable.setSortingEnabled(True)
        self.label.setText(QtGui.QApplication.translate("Q7LinkWindow", "/", None, QtGui.QApplication.UnicodeUTF8))
        self.bClose.setText(QtGui.QApplication.translate("Q7LinkWindow", "Close", None, QtGui.QApplication.UnicodeUTF8))
        self.bCheckLink.setToolTip(QtGui.QApplication.translate("Q7LinkWindow", "check and fix link list", None, QtGui.QApplication.UnicodeUTF8))
        self.label_2.setText(QtGui.QApplication.translate("Q7LinkWindow", "Remove:", None, QtGui.QApplication.UnicodeUTF8))
        self.cUnreachable.setText(QtGui.QApplication.translate("Q7LinkWindow", "unreachable", None, QtGui.QApplication.UnicodeUTF8))
        self.cDuplicates.setText(QtGui.QApplication.translate("Q7LinkWindow", "duplicates", None, QtGui.QApplication.UnicodeUTF8))
        self.cBad.setText(QtGui.QApplication.translate("Q7LinkWindow", "bad links", None, QtGui.QApplication.UnicodeUTF8))
        self.cExternal.setText(QtGui.QApplication.translate("Q7LinkWindow", "external links", None, QtGui.QApplication.UnicodeUTF8))
        self.cInternal.setText(QtGui.QApplication.translate("Q7LinkWindow", "internal links", None, QtGui.QApplication.UnicodeUTF8))

import Res_rc
