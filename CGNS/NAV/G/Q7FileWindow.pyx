# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'CGNS/NAV/T/Q7FileWindow.ui'
#
# Created by: PyQt5 UI code generator 5.6
#
# WARNING! All changes made in this file will be lost!

from PyQt5 import QtCore, QtGui, QtWidgets

class Ui_Q7FileWindow(object):
    def setupUi(self, Q7FileWindow):
        Q7FileWindow.setObjectName("Q7FileWindow")
        Q7FileWindow.setWindowModality(QtCore.Qt.ApplicationModal)
        Q7FileWindow.resize(720, 420)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Fixed, QtWidgets.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(Q7FileWindow.sizePolicy().hasHeightForWidth())
        Q7FileWindow.setSizePolicy(sizePolicy)
        Q7FileWindow.setMinimumSize(QtCore.QSize(720, 400))
        Q7FileWindow.setMaximumSize(QtCore.QSize(726, 420))
        icon = QtGui.QIcon()
        icon.addPixmap(QtGui.QPixmap(":/images/icons/cgSpy.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        Q7FileWindow.setWindowIcon(icon)
        self.verticalLayout = QtWidgets.QVBoxLayout(Q7FileWindow)
        self.verticalLayout.setObjectName("verticalLayout")
        self.horizontalLayout = QtWidgets.QHBoxLayout()
        self.horizontalLayout.setObjectName("horizontalLayout")
        spacerItem = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.horizontalLayout.addItem(spacerItem)
        self.tabs = QtWidgets.QTabWidget(Q7FileWindow)
        self.tabs.setEnabled(True)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Fixed, QtWidgets.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.tabs.sizePolicy().hasHeightForWidth())
        self.tabs.setSizePolicy(sizePolicy)
        self.tabs.setMinimumSize(QtCore.QSize(700, 200))
        self.tabs.setMaximumSize(QtCore.QSize(700, 420))
        self.tabs.setObjectName("tabs")
        self.Selection = QtWidgets.QWidget()
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Fixed, QtWidgets.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.Selection.sizePolicy().hasHeightForWidth())
        self.Selection.setSizePolicy(sizePolicy)
        self.Selection.setMinimumSize(QtCore.QSize(720, 400))
        self.Selection.setMaximumSize(QtCore.QSize(720, 400))
        self.Selection.setObjectName("Selection")
        self.treeview = QtWidgets.QTreeView(self.Selection)
        self.treeview.setGeometry(QtCore.QRect(10, 100, 680, 230))
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Preferred, QtWidgets.QSizePolicy.Preferred)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.treeview.sizePolicy().hasHeightForWidth())
        self.treeview.setSizePolicy(sizePolicy)
        self.treeview.setMinimumSize(QtCore.QSize(680, 230))
        self.treeview.setMaximumSize(QtCore.QSize(680, 230))
        self.treeview.setEditTriggers(QtWidgets.QAbstractItemView.EditKeyPressed|QtWidgets.QAbstractItemView.SelectedClicked)
        self.treeview.setSelectionBehavior(QtWidgets.QAbstractItemView.SelectRows)
        self.treeview.setUniformRowHeights(True)
        self.treeview.setSortingEnabled(True)
        self.treeview.setAllColumnsShowFocus(True)
        self.treeview.setObjectName("treeview")
        self.bClose = QtWidgets.QPushButton(self.Selection)
        self.bClose.setGeometry(QtCore.QRect(610, 340, 75, 26))
        self.bClose.setObjectName("bClose")
        self.bInfo = QtWidgets.QPushButton(self.Selection)
        self.bInfo.setGeometry(QtCore.QRect(10, 340, 25, 25))
        self.bInfo.setMinimumSize(QtCore.QSize(25, 25))
        self.bInfo.setMaximumSize(QtCore.QSize(25, 25))
        self.bInfo.setText("")
        icon1 = QtGui.QIcon()
        icon1.addPixmap(QtGui.QPixmap(":/images/icons/help-view.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bInfo.setIcon(icon1)
        self.bInfo.setObjectName("bInfo")
        self.gridLayoutWidget = QtWidgets.QWidget(self.Selection)
        self.gridLayoutWidget.setGeometry(QtCore.QRect(10, 10, 681, 81))
        self.gridLayoutWidget.setObjectName("gridLayoutWidget")
        self.gridLayout = QtWidgets.QGridLayout(self.gridLayoutWidget)
        self.gridLayout.setContentsMargins(0, 0, 0, 0)
        self.gridLayout.setSpacing(3)
        self.gridLayout.setObjectName("gridLayout")
        self.fileentries = QtWidgets.QComboBox(self.gridLayoutWidget)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Expanding)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.fileentries.sizePolicy().hasHeightForWidth())
        self.fileentries.setSizePolicy(sizePolicy)
        self.fileentries.setEditable(True)
        self.fileentries.setObjectName("fileentries")
        self.gridLayout.addWidget(self.fileentries, 5, 2, 1, 2)
        self.horizontalLayout_4 = QtWidgets.QHBoxLayout()
        self.horizontalLayout_4.setObjectName("horizontalLayout_4")
        self.cNoLargeData = QtWidgets.QCheckBox(self.gridLayoutWidget)
        font = QtGui.QFont()
        font.setBold(False)
        font.setWeight(50)
        self.cNoLargeData.setFont(font)
        self.cNoLargeData.setObjectName("cNoLargeData")
        self.horizontalLayout_4.addWidget(self.cNoLargeData)
        spacerItem1 = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.horizontalLayout_4.addItem(spacerItem1)
        self.gridLayout.addLayout(self.horizontalLayout_4, 1, 2, 1, 3)
        self.direntries = QtWidgets.QComboBox(self.gridLayoutWidget)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Expanding)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.direntries.sizePolicy().hasHeightForWidth())
        self.direntries.setSizePolicy(sizePolicy)
        self.direntries.setEditable(True)
        self.direntries.setObjectName("direntries")
        self.gridLayout.addWidget(self.direntries, 3, 2, 1, 3)
        self.cShowDirs = QtWidgets.QCheckBox(self.gridLayoutWidget)
        self.cShowDirs.setLayoutDirection(QtCore.Qt.LeftToRight)
        self.cShowDirs.setChecked(True)
        self.cShowDirs.setObjectName("cShowDirs")
        self.gridLayout.addWidget(self.cShowDirs, 5, 4, 1, 1)
        self.bCurrent = QtWidgets.QPushButton(self.gridLayoutWidget)
        self.bCurrent.setMinimumSize(QtCore.QSize(25, 25))
        self.bCurrent.setMaximumSize(QtCore.QSize(25, 25))
        self.bCurrent.setLayoutDirection(QtCore.Qt.LeftToRight)
        self.bCurrent.setText("")
        icon2 = QtGui.QIcon()
        icon2.addPixmap(QtGui.QPixmap(":/images/icons/local-dir.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bCurrent.setIcon(icon2)
        self.bCurrent.setObjectName("bCurrent")
        self.gridLayout.addWidget(self.bCurrent, 3, 1, 1, 1)
        self.bBack = QtWidgets.QPushButton(self.gridLayoutWidget)
        self.bBack.setMinimumSize(QtCore.QSize(25, 25))
        self.bBack.setMaximumSize(QtCore.QSize(25, 25))
        font = QtGui.QFont()
        font.setPointSize(14)
        font.setBold(True)
        font.setWeight(75)
        self.bBack.setFont(font)
        self.bBack.setText("")
        icon3 = QtGui.QIcon()
        icon3.addPixmap(QtGui.QPixmap(":/images/icons/parent-dir.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bBack.setIcon(icon3)
        self.bBack.setIconSize(QtCore.QSize(16, 16))
        self.bBack.setObjectName("bBack")
        self.gridLayout.addWidget(self.bBack, 3, 0, 1, 1)
        self.bAction = QtWidgets.QPushButton(self.Selection)
        self.bAction.setGeometry(QtCore.QRect(530, 340, 70, 26))
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Fixed, QtWidgets.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.bAction.sizePolicy().hasHeightForWidth())
        self.bAction.setSizePolicy(sizePolicy)
        self.bAction.setMaximumSize(QtCore.QSize(70, 16777215))
        font = QtGui.QFont()
        font.setBold(False)
        font.setWeight(50)
        self.bAction.setFont(font)
        self.bAction.setObjectName("bAction")
        self.tabs.addTab(self.Selection, "")
        self.tab = QtWidgets.QWidget()
        self.tab.setObjectName("tab")
        self.groupBox_3 = QtWidgets.QGroupBox(self.tab)
        self.groupBox_3.setGeometry(QtCore.QRect(10, 10, 331, 241))
        self.groupBox_3.setObjectName("groupBox_3")
        self.cNoLargeData_2 = QtWidgets.QCheckBox(self.groupBox_3)
        self.cNoLargeData_2.setGeometry(QtCore.QRect(20, 20, 161, 20))
        font = QtGui.QFont()
        font.setBold(False)
        font.setWeight(50)
        self.cNoLargeData_2.setFont(font)
        self.cNoLargeData_2.setObjectName("cNoLargeData_2")
        self.cFollowLinks = QtWidgets.QCheckBox(self.groupBox_3)
        self.cFollowLinks.setGeometry(QtCore.QRect(20, 40, 88, 20))
        self.cFollowLinks.setObjectName("cFollowLinks")
        self.cReadOnly = QtWidgets.QCheckBox(self.groupBox_3)
        self.cReadOnly.setEnabled(True)
        self.cReadOnly.setGeometry(QtCore.QRect(20, 60, 127, 20))
        self.cReadOnly.setObjectName("cReadOnly")
        self.cLoadSubPath = QtWidgets.QCheckBox(self.groupBox_3)
        self.cLoadSubPath.setGeometry(QtCore.QRect(20, 90, 151, 20))
        self.cLoadSubPath.setObjectName("cLoadSubPath")
        self.lineEdit = QtWidgets.QLineEdit(self.groupBox_3)
        self.lineEdit.setGeometry(QtCore.QRect(20, 110, 301, 21))
        self.lineEdit.setObjectName("lineEdit")
        self.cLimitDepth = QtWidgets.QCheckBox(self.groupBox_3)
        self.cLimitDepth.setGeometry(QtCore.QRect(20, 150, 101, 20))
        self.cLimitDepth.setObjectName("cLimitDepth")
        self.spinBox = QtWidgets.QSpinBox(self.groupBox_3)
        self.spinBox.setGeometry(QtCore.QRect(140, 150, 53, 22))
        self.spinBox.setObjectName("spinBox")
        self.groupBox_4 = QtWidgets.QGroupBox(self.tab)
        self.groupBox_4.setGeometry(QtCore.QRect(350, 10, 341, 241))
        self.groupBox_4.setObjectName("groupBox_4")
        self.cOverwrite = QtWidgets.QCheckBox(self.groupBox_4)
        self.cOverwrite.setGeometry(QtCore.QRect(10, 30, 77, 20))
        font = QtGui.QFont()
        font.setBold(False)
        font.setWeight(50)
        self.cOverwrite.setFont(font)
        self.cOverwrite.setObjectName("cOverwrite")
        self.cDeleteMissing = QtWidgets.QCheckBox(self.groupBox_4)
        self.cDeleteMissing.setGeometry(QtCore.QRect(10, 50, 107, 20))
        self.cDeleteMissing.setObjectName("cDeleteMissing")
        self.cSkipEmpty = QtWidgets.QCheckBox(self.groupBox_4)
        self.cSkipEmpty.setGeometry(QtCore.QRect(10, 70, 85, 20))
        self.cSkipEmpty.setObjectName("cSkipEmpty")
        self.cSaveWithoutLinks = QtWidgets.QCheckBox(self.groupBox_4)
        self.cSaveWithoutLinks.setGeometry(QtCore.QRect(10, 110, 151, 20))
        self.cSaveWithoutLinks.setObjectName("cSaveWithoutLinks")
        self.groupBox_5 = QtWidgets.QGroupBox(self.tab)
        self.groupBox_5.setGeometry(QtCore.QRect(10, 260, 681, 101))
        self.groupBox_5.setObjectName("groupBox_5")
        self.checkBox = QtWidgets.QCheckBox(self.groupBox_5)
        self.checkBox.setGeometry(QtCore.QRect(10, 20, 83, 20))
        self.checkBox.setObjectName("checkBox")
        self.checkBox_2 = QtWidgets.QCheckBox(self.groupBox_5)
        self.checkBox_2.setGeometry(QtCore.QRect(10, 40, 171, 20))
        self.checkBox_2.setObjectName("checkBox_2")
        self.checkBox_3 = QtWidgets.QCheckBox(self.groupBox_5)
        self.checkBox_3.setGeometry(QtCore.QRect(10, 60, 151, 20))
        self.checkBox_3.setObjectName("checkBox_3")
        self.lineEdit_2 = QtWidgets.QLineEdit(self.groupBox_5)
        self.lineEdit_2.setGeometry(QtCore.QRect(120, 60, 211, 21))
        self.lineEdit_2.setObjectName("lineEdit_2")
        self.line = QtWidgets.QFrame(self.groupBox_5)
        self.line.setGeometry(QtCore.QRect(313, 20, 41, 71))
        self.line.setFrameShape(QtWidgets.QFrame.VLine)
        self.line.setFrameShadow(QtWidgets.QFrame.Sunken)
        self.line.setObjectName("line")
        self.tabs.addTab(self.tab, "")
        self.tab_2 = QtWidgets.QWidget()
        self.tab_2.setEnabled(True)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Fixed, QtWidgets.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.tab_2.sizePolicy().hasHeightForWidth())
        self.tab_2.setSizePolicy(sizePolicy)
        self.tab_2.setMinimumSize(QtCore.QSize(720, 350))
        self.tab_2.setMaximumSize(QtCore.QSize(720, 350))
        self.tab_2.setObjectName("tab_2")
        self.groupBox = QtWidgets.QGroupBox(self.tab_2)
        self.groupBox.setGeometry(QtCore.QRect(191, 55, 492, 291))
        self.groupBox.setObjectName("groupBox")
        self.rClearAllDirs = QtWidgets.QRadioButton(self.groupBox)
        self.rClearAllDirs.setGeometry(QtCore.QRect(10, 100, 228, 20))
        self.rClearAllDirs.setObjectName("rClearAllDirs")
        self.rClearNoHDF = QtWidgets.QRadioButton(self.groupBox)
        self.rClearNoHDF.setGeometry(QtCore.QRect(10, 40, 302, 20))
        self.rClearNoHDF.setObjectName("rClearNoHDF")
        self.rClearNotFound = QtWidgets.QRadioButton(self.groupBox)
        self.rClearNotFound.setGeometry(QtCore.QRect(10, 20, 210, 20))
        self.rClearNotFound.setChecked(True)
        self.rClearNotFound.setObjectName("rClearNotFound")
        self.rClearSelectedDirs = QtWidgets.QRadioButton(self.groupBox)
        self.rClearSelectedDirs.setGeometry(QtCore.QRect(10, 60, 176, 20))
        self.rClearSelectedDirs.setObjectName("rClearSelectedDirs")
        self.rClearSelectedFiles = QtWidgets.QRadioButton(self.groupBox)
        self.rClearSelectedFiles.setGeometry(QtCore.QRect(10, 80, 160, 20))
        self.rClearSelectedFiles.setObjectName("rClearSelectedFiles")
        self.lClear = QtWidgets.QListWidget(self.groupBox)
        self.lClear.setGeometry(QtCore.QRect(9, 120, 475, 161))
        self.lClear.setSelectionMode(QtWidgets.QAbstractItemView.MultiSelection)
        self.lClear.setObjectName("lClear")
        self.bClearHistory = QtWidgets.QPushButton(self.groupBox)
        self.bClearHistory.setGeometry(QtCore.QRect(410, 20, 75, 25))
        self.bClearHistory.setObjectName("bClearHistory")
        self.bInfo2 = QtWidgets.QPushButton(self.groupBox)
        self.bInfo2.setGeometry(QtCore.QRect(380, 20, 25, 25))
        self.bInfo2.setMinimumSize(QtCore.QSize(25, 25))
        self.bInfo2.setMaximumSize(QtCore.QSize(25, 25))
        self.bInfo2.setText("")
        self.bInfo2.setIcon(icon1)
        self.bInfo2.setObjectName("bInfo2")
        self.cActivate = QtWidgets.QCheckBox(self.tab_2)
        self.cActivate.setEnabled(False)
        self.cActivate.setGeometry(QtCore.QRect(190, 30, 173, 20))
        self.cActivate.setChecked(True)
        self.cActivate.setObjectName("cActivate")
        self.groupBox_2 = QtWidgets.QGroupBox(self.tab_2)
        self.groupBox_2.setGeometry(QtCore.QRect(6, 53, 173, 291))
        self.groupBox_2.setObjectName("groupBox_2")
        self.cShowAll = QtWidgets.QCheckBox(self.groupBox_2)
        self.cShowAll.setGeometry(QtCore.QRect(10, 17, 702, 20))
        self.cShowAll.setObjectName("cShowAll")
        self.__O_filterhdffiles = QtWidgets.QCheckBox(self.groupBox_2)
        self.__O_filterhdffiles.setGeometry(QtCore.QRect(10, 39, 80, 20))
        self.__O_filterhdffiles.setChecked(True)
        self.__O_filterhdffiles.setObjectName("__O_filterhdffiles")
        self.__O_filtercgnsfiles = QtWidgets.QCheckBox(self.groupBox_2)
        self.__O_filtercgnsfiles.setGeometry(QtCore.QRect(10, 60, 141, 20))
        self.__O_filtercgnsfiles.setChecked(True)
        self.__O_filtercgnsfiles.setObjectName("__O_filtercgnsfiles")
        self.cShowOwnExt = QtWidgets.QCheckBox(self.groupBox_2)
        self.cShowOwnExt.setGeometry(QtCore.QRect(10, 100, 111, 20))
        self.cShowOwnExt.setObjectName("cShowOwnExt")
        self.lOwnExt = QtWidgets.QListWidget(self.groupBox_2)
        self.lOwnExt.setGeometry(QtCore.QRect(9, 120, 154, 161))
        self.lOwnExt.setObjectName("lOwnExt")
        self.cAutoDir = QtWidgets.QCheckBox(self.tab_2)
        self.cAutoDir.setGeometry(QtCore.QRect(10, 30, 164, 20))
        self.cAutoDir.setObjectName("cAutoDir")
        self.tabs.addTab(self.tab_2, "")
        self.horizontalLayout.addWidget(self.tabs)
        self.verticalLayout.addLayout(self.horizontalLayout)

        self.retranslateUi(Q7FileWindow)
        self.tabs.setCurrentIndex(0)
        QtCore.QMetaObject.connectSlotsByName(Q7FileWindow)

    def retranslateUi(self, Q7FileWindow):
        _translate = QtCore.QCoreApplication.translate
        Q7FileWindow.setWindowTitle(_translate("Q7FileWindow", "Form"))
        self.bClose.setText(_translate("Q7FileWindow", "Cancel"))
        self.cNoLargeData.setToolTip(_translate("Q7FileWindow", "Nodes with large data are read but their data is not"))
        self.cNoLargeData.setText(_translate("Q7FileWindow", "Do not load large data"))
        self.cShowDirs.setText(_translate("Q7FileWindow", "Show directories"))
        self.bCurrent.setToolTip(_translate("Q7FileWindow", "Go to launch directory"))
        self.bBack.setToolTip(_translate("Q7FileWindow", "Go back to parent directory"))
        self.bAction.setText(_translate("Q7FileWindow", "LOAD"))
        self.tabs.setTabText(self.tabs.indexOf(self.Selection), _translate("Q7FileWindow", "Selection"))
        self.groupBox_3.setTitle(_translate("Q7FileWindow", "Load"))
        self.cNoLargeData_2.setToolTip(_translate("Q7FileWindow", "Nodes with large data are read but their data is not"))
        self.cNoLargeData_2.setText(_translate("Q7FileWindow", "Do not load large data"))
        self.cFollowLinks.setText(_translate("Q7FileWindow", "Follow links"))
        self.cReadOnly.setText(_translate("Q7FileWindow", "Open as read-only"))
        self.cLoadSubPath.setText(_translate("Q7FileWindow", "Load sub-tree with path:"))
        self.cLimitDepth.setText(_translate("Q7FileWindow", "Limit depth to:"))
        self.groupBox_4.setTitle(_translate("Q7FileWindow", "Save"))
        self.cOverwrite.setToolTip(_translate("Q7FileWindow", "Overwrite an existing file with new contents"))
        self.cOverwrite.setText(_translate("Q7FileWindow", "Overwrite"))
        self.cDeleteMissing.setToolTip(_translate("Q7FileWindow", "Children found in existing file but not in current tree are removed"))
        self.cDeleteMissing.setText(_translate("Q7FileWindow", "Delete missing"))
        self.cSkipEmpty.setText(_translate("Q7FileWindow", "Skip empty"))
        self.cSaveWithoutLinks.setText(_translate("Q7FileWindow", "Do not save with links"))
        self.groupBox_5.setTitle(_translate("Q7FileWindow", "CHLone options (both load and save)"))
        self.checkBox.setText(_translate("Q7FileWindow", "Trace"))
        self.checkBox_2.setText(_translate("Q7FileWindow", "Debug (quite large output)"))
        self.checkBox_3.setText(_translate("Q7FileWindow", "Send output to:"))
        self.tabs.setTabText(self.tabs.indexOf(self.tab), _translate("Q7FileWindow", "Load/Save options"))
        self.groupBox.setTitle(_translate("Q7FileWindow", "Clear history"))
        self.rClearAllDirs.setText(_translate("Q7FileWindow", "All directory and file entries"))
        self.rClearNoHDF.setText(_translate("Q7FileWindow", "Directory entries without correct file extension"))
        self.rClearNotFound.setText(_translate("Q7FileWindow", "Not found directory and file entries"))
        self.rClearSelectedDirs.setText(_translate("Q7FileWindow", "Selected directory entries"))
        self.rClearSelectedFiles.setText(_translate("Q7FileWindow", "Selected file entries"))
        self.bClearHistory.setText(_translate("Q7FileWindow", "Clear"))
        self.cActivate.setText(_translate("Q7FileWindow", "Activate directory/file history"))
        self.groupBox_2.setTitle(_translate("Q7FileWindow", "Show"))
        self.cShowAll.setText(_translate("Q7FileWindow", "All file extensions"))
        self.__O_filterhdffiles.setText(_translate("Q7FileWindow", ".hdf files"))
        self.__O_filtercgnsfiles.setText(_translate("Q7FileWindow", ".cgns/.adf files"))
        self.cShowOwnExt.setText(_translate("Q7FileWindow", "own extension:"))
        self.cAutoDir.setText(_translate("Q7FileWindow", "Auto-Change directory"))
        self.tabs.setTabText(self.tabs.indexOf(self.tab_2), _translate("Q7FileWindow", "History/Filter"))

import Res_rc
