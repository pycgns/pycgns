# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'CGNS/NAV/T/Q7ControlWindow.ui'
#
# Created by: PyQt5 UI code generator 5.6
#
# WARNING! All changes made in this file will be lost!

from PyQt5 import QtCore, QtGui, QtWidgets

class Ui_Q7ControlWindow(object):
    def setupUi(self, Q7ControlWindow):
        Q7ControlWindow.setObjectName("Q7ControlWindow")
        Q7ControlWindow.resize(799, 232)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Expanding)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(Q7ControlWindow.sizePolicy().hasHeightForWidth())
        Q7ControlWindow.setSizePolicy(sizePolicy)
        icon = QtGui.QIcon()
        icon.addPixmap(QtGui.QPixmap(":/images/icons/cgSpy.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        Q7ControlWindow.setWindowIcon(icon)
        self.verticalLayout_2 = QtWidgets.QVBoxLayout(Q7ControlWindow)
        self.verticalLayout_2.setObjectName("verticalLayout_2")
        self.horizontalLayout = QtWidgets.QHBoxLayout()
        self.horizontalLayout.setObjectName("horizontalLayout")
        self.bTreeLoadLast = QtWidgets.QToolButton(Q7ControlWindow)
        self.bTreeLoadLast.setMinimumSize(QtCore.QSize(25, 25))
        self.bTreeLoadLast.setMaximumSize(QtCore.QSize(25, 25))
        self.bTreeLoadLast.setText("")
        icon1 = QtGui.QIcon()
        icon1.addPixmap(QtGui.QPixmap(":/images/icons/tree-load-g.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bTreeLoadLast.setIcon(icon1)
        self.bTreeLoadLast.setObjectName("bTreeLoadLast")
        self.horizontalLayout.addWidget(self.bTreeLoadLast)
        self.bTreeLoad = QtWidgets.QToolButton(Q7ControlWindow)
        self.bTreeLoad.setMinimumSize(QtCore.QSize(25, 25))
        self.bTreeLoad.setMaximumSize(QtCore.QSize(25, 25))
        self.bTreeLoad.setText("")
        icon2 = QtGui.QIcon()
        icon2.addPixmap(QtGui.QPixmap(":/images/icons/tree-load.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bTreeLoad.setIcon(icon2)
        self.bTreeLoad.setObjectName("bTreeLoad")
        self.horizontalLayout.addWidget(self.bTreeLoad)
        spacerItem = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.horizontalLayout.addItem(spacerItem)
        self.bEditTree = QtWidgets.QToolButton(Q7ControlWindow)
        self.bEditTree.setMinimumSize(QtCore.QSize(25, 25))
        self.bEditTree.setMaximumSize(QtCore.QSize(25, 25))
        icon3 = QtGui.QIcon()
        icon3.addPixmap(QtGui.QPixmap(":/images/icons/tree-new.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bEditTree.setIcon(icon3)
        self.bEditTree.setObjectName("bEditTree")
        self.horizontalLayout.addWidget(self.bEditTree)
        self.bPatternView = QtWidgets.QToolButton(Q7ControlWindow)
        self.bPatternView.setMinimumSize(QtCore.QSize(25, 25))
        self.bPatternView.setMaximumSize(QtCore.QSize(25, 25))
        icon4 = QtGui.QIcon()
        icon4.addPixmap(QtGui.QPixmap(":/images/icons/pattern.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bPatternView.setIcon(icon4)
        self.bPatternView.setObjectName("bPatternView")
        self.horizontalLayout.addWidget(self.bPatternView)
        spacerItem1 = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.horizontalLayout.addItem(spacerItem1)
        self.bLog = QtWidgets.QPushButton(Q7ControlWindow)
        self.bLog.setMinimumSize(QtCore.QSize(25, 25))
        self.bLog.setMaximumSize(QtCore.QSize(25, 25))
        self.bLog.setText("")
        icon5 = QtGui.QIcon()
        icon5.addPixmap(QtGui.QPixmap(":/images/icons/subtree-sids-warning.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bLog.setIcon(icon5)
        self.bLog.setObjectName("bLog")
        self.horizontalLayout.addWidget(self.bLog)
        spacerItem2 = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.horizontalLayout.addItem(spacerItem2)
        self.bOptionView = QtWidgets.QToolButton(Q7ControlWindow)
        self.bOptionView.setMinimumSize(QtCore.QSize(25, 25))
        self.bOptionView.setMaximumSize(QtCore.QSize(25, 25))
        icon6 = QtGui.QIcon()
        icon6.addPixmap(QtGui.QPixmap(":/images/icons/options-view.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bOptionView.setIcon(icon6)
        self.bOptionView.setObjectName("bOptionView")
        self.horizontalLayout.addWidget(self.bOptionView)
        self.bInfo = QtWidgets.QPushButton(Q7ControlWindow)
        self.bInfo.setMinimumSize(QtCore.QSize(25, 25))
        self.bInfo.setMaximumSize(QtCore.QSize(25, 25))
        self.bInfo.setText("")
        icon7 = QtGui.QIcon()
        icon7.addPixmap(QtGui.QPixmap(":/images/icons/help-view.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bInfo.setIcon(icon7)
        self.bInfo.setObjectName("bInfo")
        self.horizontalLayout.addWidget(self.bInfo)
        self.bAbout = QtWidgets.QToolButton(Q7ControlWindow)
        self.bAbout.setMinimumSize(QtCore.QSize(25, 25))
        self.bAbout.setMaximumSize(QtCore.QSize(25, 25))
        icon8 = QtGui.QIcon()
        icon8.addPixmap(QtGui.QPixmap(":/images/icons/view-help.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bAbout.setIcon(icon8)
        self.bAbout.setObjectName("bAbout")
        self.horizontalLayout.addWidget(self.bAbout)
        spacerItem3 = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.horizontalLayout.addItem(spacerItem3)
        self.bClose = QtWidgets.QPushButton(Q7ControlWindow)
        self.bClose.setMinimumSize(QtCore.QSize(25, 25))
        self.bClose.setMaximumSize(QtCore.QSize(25, 25))
        self.bClose.setText("")
        icon9 = QtGui.QIcon()
        icon9.addPixmap(QtGui.QPixmap(":/images/icons/close-view.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bClose.setIcon(icon9)
        self.bClose.setObjectName("bClose")
        self.horizontalLayout.addWidget(self.bClose)
        self.verticalLayout_2.addLayout(self.horizontalLayout)
        self.controlTable = Q7ControlTableWidget(Q7ControlWindow)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Expanding)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.controlTable.sizePolicy().hasHeightForWidth())
        self.controlTable.setSizePolicy(sizePolicy)
        self.controlTable.setMinimumSize(QtCore.QSize(781, 181))
        self.controlTable.setEditTriggers(QtWidgets.QAbstractItemView.NoEditTriggers)
        self.controlTable.setTabKeyNavigation(False)
        self.controlTable.setProperty("showDropIndicator", False)
        self.controlTable.setDragDropOverwriteMode(False)
        self.controlTable.setSelectionMode(QtWidgets.QAbstractItemView.SingleSelection)
        self.controlTable.setSelectionBehavior(QtWidgets.QAbstractItemView.SelectRows)
        self.controlTable.setCornerButtonEnabled(False)
        self.controlTable.setRowCount(0)
        self.controlTable.setColumnCount(6)
        self.controlTable.setObjectName("controlTable")
        self.controlTable.horizontalHeader().setCascadingSectionResizes(True)
        self.controlTable.horizontalHeader().setStretchLastSection(True)
        self.verticalLayout_2.addWidget(self.controlTable)

        self.retranslateUi(Q7ControlWindow)
        QtCore.QMetaObject.connectSlotsByName(Q7ControlWindow)

    def retranslateUi(self, Q7ControlWindow):
        _translate = QtCore.QCoreApplication.translate
        Q7ControlWindow.setWindowTitle(_translate("Q7ControlWindow", "Form"))
        self.bTreeLoadLast.setToolTip(_translate("Q7ControlWindow", "Load the last used CGNS file"))
        self.bTreeLoad.setToolTip(_translate("Q7ControlWindow", "Load an existing CGNS file"))
        self.bEditTree.setToolTip(_translate("Q7ControlWindow", "Create a new CGNS tree from scratch"))
        self.bEditTree.setText(_translate("Q7ControlWindow", "..."))
        self.bPatternView.setToolTip(_translate("Q7ControlWindow", "Open CGNS/SIDS sub-trees database"))
        self.bPatternView.setText(_translate("Q7ControlWindow", "..."))
        self.bLog.setToolTip(_translate("Q7ControlWindow", "Log window"))
        self.bOptionView.setToolTip(_translate("Q7ControlWindow", "Set user defined options"))
        self.bOptionView.setText(_translate("Q7ControlWindow", "..."))
        self.bInfo.setToolTip(_translate("Q7ControlWindow", "Help window"))
        self.bAbout.setToolTip(_translate("Q7ControlWindow", "About...."))
        self.bAbout.setText(_translate("Q7ControlWindow", "..."))
        self.bClose.setToolTip(_translate("Q7ControlWindow", "Close all CGNS.NAV windows"))
        self.controlTable.setSortingEnabled(True)

from CGNS.NAV.mcontrol import Q7ControlTableWidget
import Res_rc
