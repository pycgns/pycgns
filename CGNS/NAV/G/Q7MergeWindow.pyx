# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'CGNS/NAV/T/Q7MergeWindow.ui'
#
# Created: Fri Jul  8 10:23:56 2016
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

class Ui_Q7MergeWindow(object):
    def setupUi(self, Q7MergeWindow):
        Q7MergeWindow.setObjectName(_fromUtf8("Q7MergeWindow"))
        Q7MergeWindow.resize(1124, 300)
        icon = QtGui.QIcon()
        icon.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/cgSpy.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        Q7MergeWindow.setWindowIcon(icon)
        self.verticalLayout_2 = QtGui.QVBoxLayout(Q7MergeWindow)
        self.verticalLayout_2.setObjectName(_fromUtf8("verticalLayout_2"))
        self.horizontalLayout = QtGui.QHBoxLayout()
        self.horizontalLayout.setObjectName(_fromUtf8("horizontalLayout"))
        self.bSelectA = QtGui.QPushButton(Q7MergeWindow)
        self.bSelectA.setMinimumSize(QtCore.QSize(24, 24))
        self.bSelectA.setMaximumSize(QtCore.QSize(24, 24))
        self.bSelectA.setText(_fromUtf8(""))
        icon1 = QtGui.QIcon()
        icon1.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/user-A.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bSelectA.setIcon(icon1)
        self.bSelectA.setCheckable(True)
        self.bSelectA.setChecked(True)
        self.bSelectA.setObjectName(_fromUtf8("bSelectA"))
        self.horizontalLayout.addWidget(self.bSelectA)
        self.bSelectOrderSwap = QtGui.QPushButton(Q7MergeWindow)
        self.bSelectOrderSwap.setMinimumSize(QtCore.QSize(24, 24))
        self.bSelectOrderSwap.setMaximumSize(QtCore.QSize(24, 24))
        self.bSelectOrderSwap.setText(_fromUtf8(""))
        icon2 = QtGui.QIcon()
        icon2.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/reverse.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bSelectOrderSwap.setIcon(icon2)
        self.bSelectOrderSwap.setObjectName(_fromUtf8("bSelectOrderSwap"))
        self.horizontalLayout.addWidget(self.bSelectOrderSwap)
        self.bSelectB = QtGui.QPushButton(Q7MergeWindow)
        self.bSelectB.setMinimumSize(QtCore.QSize(24, 24))
        self.bSelectB.setMaximumSize(QtCore.QSize(24, 24))
        self.bSelectB.setText(_fromUtf8(""))
        icon3 = QtGui.QIcon()
        icon3.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/user-B.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bSelectB.setIcon(icon3)
        self.bSelectB.setCheckable(True)
        self.bSelectB.setChecked(True)
        self.bSelectB.setObjectName(_fromUtf8("bSelectB"))
        self.horizontalLayout.addWidget(self.bSelectB)
        spacerItem = QtGui.QSpacerItem(40, 20, QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Minimum)
        self.horizontalLayout.addItem(spacerItem)
        self.bZoomOut = QtGui.QToolButton(Q7MergeWindow)
        self.bZoomOut.setMinimumSize(QtCore.QSize(25, 25))
        self.bZoomOut.setMaximumSize(QtCore.QSize(25, 25))
        icon4 = QtGui.QIcon()
        icon4.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/level-out.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bZoomOut.setIcon(icon4)
        self.bZoomOut.setObjectName(_fromUtf8("bZoomOut"))
        self.horizontalLayout.addWidget(self.bZoomOut)
        self.bZoomAll = QtGui.QPushButton(Q7MergeWindow)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Fixed, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.bZoomAll.sizePolicy().hasHeightForWidth())
        self.bZoomAll.setSizePolicy(sizePolicy)
        self.bZoomAll.setMinimumSize(QtCore.QSize(25, 25))
        self.bZoomAll.setMaximumSize(QtCore.QSize(25, 25))
        self.bZoomAll.setText(_fromUtf8(""))
        icon5 = QtGui.QIcon()
        icon5.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/level-all.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bZoomAll.setIcon(icon5)
        self.bZoomAll.setObjectName(_fromUtf8("bZoomAll"))
        self.horizontalLayout.addWidget(self.bZoomAll)
        self.bZoomIn = QtGui.QToolButton(Q7MergeWindow)
        self.bZoomIn.setMinimumSize(QtCore.QSize(25, 25))
        self.bZoomIn.setMaximumSize(QtCore.QSize(25, 25))
        icon6 = QtGui.QIcon()
        icon6.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/level-in.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bZoomIn.setIcon(icon6)
        self.bZoomIn.setObjectName(_fromUtf8("bZoomIn"))
        self.horizontalLayout.addWidget(self.bZoomIn)
        spacerItem1 = QtGui.QSpacerItem(40, 20, QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Minimum)
        self.horizontalLayout.addItem(spacerItem1)
        self.bSaveDiff = QtGui.QToolButton(Q7MergeWindow)
        self.bSaveDiff.setMinimumSize(QtCore.QSize(25, 25))
        self.bSaveDiff.setMaximumSize(QtCore.QSize(25, 25))
        icon7 = QtGui.QIcon()
        icon7.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/select-save.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bSaveDiff.setIcon(icon7)
        self.bSaveDiff.setObjectName(_fromUtf8("bSaveDiff"))
        self.horizontalLayout.addWidget(self.bSaveDiff)
        self.verticalLayout_2.addLayout(self.horizontalLayout)
        self.horizontalLayout_2 = QtGui.QHBoxLayout()
        self.horizontalLayout_2.setObjectName(_fromUtf8("horizontalLayout_2"))
        self.treeview = Q7DiffTreeView(Q7MergeWindow)
        self.treeview.viewport().setProperty("cursor", QtGui.QCursor(QtCore.Qt.CrossCursor))
        self.treeview.setVerticalScrollBarPolicy(QtCore.Qt.ScrollBarAsNeeded)
        self.treeview.setAutoScroll(False)
        self.treeview.setEditTriggers(QtGui.QAbstractItemView.NoEditTriggers)
        self.treeview.setProperty("showDropIndicator", False)
        self.treeview.setHorizontalScrollMode(QtGui.QAbstractItemView.ScrollPerItem)
        self.treeview.setIndentation(16)
        self.treeview.setRootIsDecorated(True)
        self.treeview.setUniformRowHeights(True)
        self.treeview.setExpandsOnDoubleClick(False)
        self.treeview.setObjectName(_fromUtf8("treeview"))
        self.horizontalLayout_2.addWidget(self.treeview)
        self.verticalLayout_2.addLayout(self.horizontalLayout_2)
        self.horizontalLayout_3 = QtGui.QHBoxLayout()
        self.horizontalLayout_3.setObjectName(_fromUtf8("horizontalLayout_3"))
        self.bBackControl = QtGui.QPushButton(Q7MergeWindow)
        self.bBackControl.setMinimumSize(QtCore.QSize(25, 25))
        self.bBackControl.setMaximumSize(QtCore.QSize(25, 25))
        self.bBackControl.setText(_fromUtf8(""))
        icon8 = QtGui.QIcon()
        icon8.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/top.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bBackControl.setIcon(icon8)
        self.bBackControl.setObjectName(_fromUtf8("bBackControl"))
        self.horizontalLayout_3.addWidget(self.bBackControl)
        self.bInfo = QtGui.QPushButton(Q7MergeWindow)
        self.bInfo.setMinimumSize(QtCore.QSize(25, 25))
        self.bInfo.setMaximumSize(QtCore.QSize(25, 25))
        self.bInfo.setText(_fromUtf8(""))
        icon9 = QtGui.QIcon()
        icon9.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/help-view.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bInfo.setIcon(icon9)
        self.bInfo.setObjectName(_fromUtf8("bInfo"))
        self.horizontalLayout_3.addWidget(self.bInfo)
        spacerItem2 = QtGui.QSpacerItem(40, 20, QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Minimum)
        self.horizontalLayout_3.addItem(spacerItem2)
        self.bPreviousMark = QtGui.QToolButton(Q7MergeWindow)
        self.bPreviousMark.setMinimumSize(QtCore.QSize(25, 25))
        self.bPreviousMark.setMaximumSize(QtCore.QSize(25, 25))
        icon10 = QtGui.QIcon()
        icon10.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/node-sids-opened.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bPreviousMark.setIcon(icon10)
        self.bPreviousMark.setObjectName(_fromUtf8("bPreviousMark"))
        self.horizontalLayout_3.addWidget(self.bPreviousMark)
        self.bUnmarkAll_1 = QtGui.QToolButton(Q7MergeWindow)
        self.bUnmarkAll_1.setMinimumSize(QtCore.QSize(25, 25))
        self.bUnmarkAll_1.setMaximumSize(QtCore.QSize(25, 25))
        icon11 = QtGui.QIcon()
        icon11.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/node-sids-leaf.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bUnmarkAll_1.setIcon(icon11)
        self.bUnmarkAll_1.setObjectName(_fromUtf8("bUnmarkAll_1"))
        self.horizontalLayout_3.addWidget(self.bUnmarkAll_1)
        self.bNextMark = QtGui.QToolButton(Q7MergeWindow)
        self.bNextMark.setMinimumSize(QtCore.QSize(25, 25))
        self.bNextMark.setMaximumSize(QtCore.QSize(25, 25))
        icon12 = QtGui.QIcon()
        icon12.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/icons/node-sids-closed.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bNextMark.setIcon(icon12)
        self.bNextMark.setObjectName(_fromUtf8("bNextMark"))
        self.horizontalLayout_3.addWidget(self.bNextMark)
        spacerItem3 = QtGui.QSpacerItem(40, 20, QtGui.QSizePolicy.Fixed, QtGui.QSizePolicy.Minimum)
        self.horizontalLayout_3.addItem(spacerItem3)
        self.bClose = QtGui.QPushButton(Q7MergeWindow)
        self.bClose.setObjectName(_fromUtf8("bClose"))
        self.horizontalLayout_3.addWidget(self.bClose)
        self.verticalLayout_2.addLayout(self.horizontalLayout_3)

        self.retranslateUi(Q7MergeWindow)
        QtCore.QMetaObject.connectSlotsByName(Q7MergeWindow)

    def retranslateUi(self, Q7MergeWindow):
        Q7MergeWindow.setWindowTitle(_translate("Q7MergeWindow", "Form", None))
        self.bSelectOrderSwap.setToolTip(_translate("Q7MergeWindow", "Reverse precedence order of merge", None))
        self.bZoomOut.setToolTip(_translate("Q7MergeWindow", "Collapse lowest tree level", None))
        self.bZoomOut.setText(_translate("Q7MergeWindow", "...", None))
        self.bZoomAll.setToolTip(_translate("Q7MergeWindow", "Expand all tree", None))
        self.bZoomIn.setToolTip(_translate("Q7MergeWindow", "Expand lowest tree level", None))
        self.bZoomIn.setText(_translate("Q7MergeWindow", "...", None))
        self.bSaveDiff.setToolTip(_translate("Q7MergeWindow", "Save tree view snapshot", None))
        self.bSaveDiff.setText(_translate("Q7MergeWindow", "...", None))
        self.bBackControl.setToolTip(_translate("Q7MergeWindow", "Raise Control window", None))
        self.bInfo.setToolTip(_translate("Q7MergeWindow", "Contextual help", None))
        self.bPreviousMark.setToolTip(_translate("Q7MergeWindow", "Select previous marked node", None))
        self.bPreviousMark.setText(_translate("Q7MergeWindow", "...", None))
        self.bUnmarkAll_1.setToolTip(_translate("Q7MergeWindow", "Unmark all nodes", None))
        self.bUnmarkAll_1.setText(_translate("Q7MergeWindow", "...", None))
        self.bNextMark.setToolTip(_translate("Q7MergeWindow", "Select next marked node", None))
        self.bNextMark.setText(_translate("Q7MergeWindow", "...", None))
        self.bClose.setText(_translate("Q7MergeWindow", "Close", None))

from CGNS.NAV.mdifftreeview import Q7DiffTreeView
import Res_rc
