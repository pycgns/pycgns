# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'CGNS/NAV/T/Q7DiffWindow.ui'
#
# Created: Fri Jul  8 10:23:55 2016
#      by: PyQt4 UI code generator 4.11.1
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui

try:
    _fromUtf8 = QtCore.QString.fromUtf8
except AttributeError:
    def _fromUtf8(s):
        return s

try:
    _encoding = QtGui.QApplication.UnicodeUTF8
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig, _encoding)
except AttributeError:
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig)

class Ui_Q7DiffWindow(object):
    def setupUi(self, Q7DiffWindow):
        Q7DiffWindow.setObjectName(_fromUtf8("Q7DiffWindow"))
        Q7DiffWindow.resize(1124, 300)
        icon = QtGui.QIcon()
        icon.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/cgSpy.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        Q7DiffWindow.setWindowIcon(icon)
        self.verticalLayout_2 = QtGui.QVBoxLayout(Q7DiffWindow)
        self.verticalLayout_2.setObjectName(_fromUtf8("verticalLayout_2"))
        self.horizontalLayout = QtGui.QHBoxLayout()
        self.horizontalLayout.setObjectName(_fromUtf8("horizontalLayout"))
        self.bLockScroll = QtGui.QPushButton(Q7DiffWindow)
        self.bLockScroll.setMinimumSize(QtCore.QSize(25, 25))
        self.bLockScroll.setMaximumSize(QtCore.QSize(25, 25))
        self.bLockScroll.setText(_fromUtf8(""))
        icon1 = QtGui.QIcon()
        icon1.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/lock-scroll.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bLockScroll.setIcon(icon1)
        self.bLockScroll.setCheckable(True)
        self.bLockScroll.setChecked(True)
        self.bLockScroll.setObjectName(_fromUtf8("bLockScroll"))
        self.horizontalLayout.addWidget(self.bLockScroll)
        spacerItem = QtGui.QSpacerItem(40, 20, QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Minimum)
        self.horizontalLayout.addItem(spacerItem)
        self.bZoomOut = QtGui.QToolButton(Q7DiffWindow)
        self.bZoomOut.setMinimumSize(QtCore.QSize(25, 25))
        self.bZoomOut.setMaximumSize(QtCore.QSize(25, 25))
        icon2 = QtGui.QIcon()
        icon2.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/level-out.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bZoomOut.setIcon(icon2)
        self.bZoomOut.setObjectName(_fromUtf8("bZoomOut"))
        self.horizontalLayout.addWidget(self.bZoomOut)
        self.bZoomAll = QtGui.QPushButton(Q7DiffWindow)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Fixed, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.bZoomAll.sizePolicy().hasHeightForWidth())
        self.bZoomAll.setSizePolicy(sizePolicy)
        self.bZoomAll.setMinimumSize(QtCore.QSize(25, 25))
        self.bZoomAll.setMaximumSize(QtCore.QSize(25, 25))
        self.bZoomAll.setText(_fromUtf8(""))
        icon3 = QtGui.QIcon()
        icon3.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/level-all.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bZoomAll.setIcon(icon3)
        self.bZoomAll.setObjectName(_fromUtf8("bZoomAll"))
        self.horizontalLayout.addWidget(self.bZoomAll)
        self.bZoomIn = QtGui.QToolButton(Q7DiffWindow)
        self.bZoomIn.setMinimumSize(QtCore.QSize(25, 25))
        self.bZoomIn.setMaximumSize(QtCore.QSize(25, 25))
        icon4 = QtGui.QIcon()
        icon4.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/level-in.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bZoomIn.setIcon(icon4)
        self.bZoomIn.setObjectName(_fromUtf8("bZoomIn"))
        self.horizontalLayout.addWidget(self.bZoomIn)
        spacerItem1 = QtGui.QSpacerItem(40, 20, QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Minimum)
        self.horizontalLayout.addItem(spacerItem1)
        self.bSaveDiff = QtGui.QToolButton(Q7DiffWindow)
        self.bSaveDiff.setMinimumSize(QtCore.QSize(25, 25))
        self.bSaveDiff.setMaximumSize(QtCore.QSize(25, 25))
        icon5 = QtGui.QIcon()
        icon5.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/select-save.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bSaveDiff.setIcon(icon5)
        self.bSaveDiff.setObjectName(_fromUtf8("bSaveDiff"))
        self.horizontalLayout.addWidget(self.bSaveDiff)
        self.verticalLayout_2.addLayout(self.horizontalLayout)
        self.horizontalLayout_2 = QtGui.QHBoxLayout()
        self.horizontalLayout_2.setObjectName(_fromUtf8("horizontalLayout_2"))
        self.treeviewA = Q7DiffTreeView(Q7DiffWindow)
        self.treeviewA.viewport().setProperty("cursor", QtGui.QCursor(QtCore.Qt.CrossCursor))
        self.treeviewA.setVerticalScrollBarPolicy(QtCore.Qt.ScrollBarAlwaysOff)
        self.treeviewA.setAutoScroll(False)
        self.treeviewA.setProperty("showDropIndicator", False)
        self.treeviewA.setHorizontalScrollMode(QtGui.QAbstractItemView.ScrollPerItem)
        self.treeviewA.setIndentation(16)
        self.treeviewA.setRootIsDecorated(True)
        self.treeviewA.setUniformRowHeights(True)
        self.treeviewA.setExpandsOnDoubleClick(False)
        self.treeviewA.setObjectName(_fromUtf8("treeviewA"))
        self.horizontalLayout_2.addWidget(self.treeviewA)
        self.verticalScrollBarA = QtGui.QScrollBar(Q7DiffWindow)
        self.verticalScrollBarA.setOrientation(QtCore.Qt.Vertical)
        self.verticalScrollBarA.setObjectName(_fromUtf8("verticalScrollBarA"))
        self.horizontalLayout_2.addWidget(self.verticalScrollBarA)
        self.verticalScrollBarB = QtGui.QScrollBar(Q7DiffWindow)
        self.verticalScrollBarB.setOrientation(QtCore.Qt.Vertical)
        self.verticalScrollBarB.setObjectName(_fromUtf8("verticalScrollBarB"))
        self.horizontalLayout_2.addWidget(self.verticalScrollBarB)
        self.treeviewB = Q7DiffTreeView(Q7DiffWindow)
        self.treeviewB.setVerticalScrollBarPolicy(QtCore.Qt.ScrollBarAlwaysOff)
        self.treeviewB.setObjectName(_fromUtf8("treeviewB"))
        self.horizontalLayout_2.addWidget(self.treeviewB)
        self.verticalLayout_2.addLayout(self.horizontalLayout_2)
        self.horizontalLayout_3 = QtGui.QHBoxLayout()
        self.horizontalLayout_3.setObjectName(_fromUtf8("horizontalLayout_3"))
        self.bBackControl = QtGui.QPushButton(Q7DiffWindow)
        self.bBackControl.setMinimumSize(QtCore.QSize(25, 25))
        self.bBackControl.setMaximumSize(QtCore.QSize(25, 25))
        self.bBackControl.setText(_fromUtf8(""))
        icon6 = QtGui.QIcon()
        icon6.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/top.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bBackControl.setIcon(icon6)
        self.bBackControl.setObjectName(_fromUtf8("bBackControl"))
        self.horizontalLayout_3.addWidget(self.bBackControl)
        self.bInfo = QtGui.QPushButton(Q7DiffWindow)
        self.bInfo.setMinimumSize(QtCore.QSize(25, 25))
        self.bInfo.setMaximumSize(QtCore.QSize(25, 25))
        self.bInfo.setText(_fromUtf8(""))
        icon7 = QtGui.QIcon()
        icon7.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/help-view.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bInfo.setIcon(icon7)
        self.bInfo.setObjectName(_fromUtf8("bInfo"))
        self.horizontalLayout_3.addWidget(self.bInfo)
        spacerItem2 = QtGui.QSpacerItem(40, 20, QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Minimum)
        self.horizontalLayout_3.addItem(spacerItem2)
        self.bPreviousMark = QtGui.QToolButton(Q7DiffWindow)
        self.bPreviousMark.setEnabled(True)
        self.bPreviousMark.setMinimumSize(QtCore.QSize(25, 25))
        self.bPreviousMark.setMaximumSize(QtCore.QSize(25, 25))
        icon8 = QtGui.QIcon()
        icon8.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/node-sids-opened.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bPreviousMark.setIcon(icon8)
        self.bPreviousMark.setObjectName(_fromUtf8("bPreviousMark"))
        self.horizontalLayout_3.addWidget(self.bPreviousMark)
        self.bUnmarkAll_1 = QtGui.QToolButton(Q7DiffWindow)
        self.bUnmarkAll_1.setMinimumSize(QtCore.QSize(25, 25))
        self.bUnmarkAll_1.setMaximumSize(QtCore.QSize(25, 25))
        icon9 = QtGui.QIcon()
        icon9.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/node-sids-leaf.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bUnmarkAll_1.setIcon(icon9)
        self.bUnmarkAll_1.setObjectName(_fromUtf8("bUnmarkAll_1"))
        self.horizontalLayout_3.addWidget(self.bUnmarkAll_1)
        self.bNextMark = QtGui.QToolButton(Q7DiffWindow)
        self.bNextMark.setMinimumSize(QtCore.QSize(25, 25))
        self.bNextMark.setMaximumSize(QtCore.QSize(25, 25))
        icon10 = QtGui.QIcon()
        icon10.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/node-sids-closed.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bNextMark.setIcon(icon10)
        self.bNextMark.setObjectName(_fromUtf8("bNextMark"))
        self.horizontalLayout_3.addWidget(self.bNextMark)
        spacerItem3 = QtGui.QSpacerItem(40, 20, QtGui.QSizePolicy.Fixed, QtGui.QSizePolicy.Minimum)
        self.horizontalLayout_3.addItem(spacerItem3)
        self.bClose = QtGui.QPushButton(Q7DiffWindow)
        self.bClose.setObjectName(_fromUtf8("bClose"))
        self.horizontalLayout_3.addWidget(self.bClose)
        self.verticalLayout_2.addLayout(self.horizontalLayout_3)

        self.retranslateUi(Q7DiffWindow)
        QtCore.QMetaObject.connectSlotsByName(Q7DiffWindow)

    def retranslateUi(self, Q7DiffWindow):
        Q7DiffWindow.setWindowTitle(_translate("Q7DiffWindow", "Form", None))
        self.bLockScroll.setToolTip(_translate("Q7DiffWindow", "Lock scrollbars together", None))
        self.bZoomOut.setToolTip(_translate("Q7DiffWindow", "Collapse lowest tree level", None))
        self.bZoomOut.setText(_translate("Q7DiffWindow", "...", None))
        self.bZoomAll.setToolTip(_translate("Q7DiffWindow", "Expand all tree", None))
        self.bZoomIn.setToolTip(_translate("Q7DiffWindow", "Expand lowest tree level", None))
        self.bZoomIn.setText(_translate("Q7DiffWindow", "...", None))
        self.bSaveDiff.setToolTip(_translate("Q7DiffWindow", "Save tree view snapshot", None))
        self.bSaveDiff.setText(_translate("Q7DiffWindow", "...", None))
        self.verticalScrollBarA.setToolTip(_translate("Q7DiffWindow", "DiffA file", None))
        self.verticalScrollBarB.setToolTip(_translate("Q7DiffWindow", "DiffB file", None))
        self.bBackControl.setToolTip(_translate("Q7DiffWindow", "Raise Control window", None))
        self.bInfo.setToolTip(_translate("Q7DiffWindow", "Contextual help", None))
        self.bPreviousMark.setToolTip(_translate("Q7DiffWindow", "Select previous marked node", None))
        self.bPreviousMark.setText(_translate("Q7DiffWindow", "...", None))
        self.bUnmarkAll_1.setToolTip(_translate("Q7DiffWindow", "Unmark all nodes", None))
        self.bUnmarkAll_1.setText(_translate("Q7DiffWindow", "...", None))
        self.bNextMark.setToolTip(_translate("Q7DiffWindow", "Select next marked node", None))
        self.bNextMark.setText(_translate("Q7DiffWindow", "...", None))
        self.bClose.setText(_translate("Q7DiffWindow", "Close", None))

from CGNS.NAV.mdifftreeview import Q7DiffTreeView
import Res_rc
