# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'CGNS/NAV/T/Q7OptionsWindow.ui'
#
# Created by: PyQt5 UI code generator 5.6
#
# WARNING! All changes made in this file will be lost!

from PyQt5 import QtCore, QtGui, QtWidgets

class Ui_Q7OptionsWindow(object):
    def setupUi(self, Q7OptionsWindow):
        Q7OptionsWindow.setObjectName("Q7OptionsWindow")
        Q7OptionsWindow.setWindowModality(QtCore.Qt.ApplicationModal)
        Q7OptionsWindow.resize(650, 364)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Fixed, QtWidgets.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(Q7OptionsWindow.sizePolicy().hasHeightForWidth())
        Q7OptionsWindow.setSizePolicy(sizePolicy)
        Q7OptionsWindow.setMinimumSize(QtCore.QSize(650, 364))
        Q7OptionsWindow.setMaximumSize(QtCore.QSize(650, 364))
        icon = QtGui.QIcon()
        icon.addPixmap(QtGui.QPixmap(":/images/icons/cgSpy.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        Q7OptionsWindow.setWindowIcon(icon)
        self.verticalLayout = QtWidgets.QVBoxLayout(Q7OptionsWindow)
        self.verticalLayout.setObjectName("verticalLayout")
        self.horizontalLayout_2 = QtWidgets.QHBoxLayout()
        self.horizontalLayout_2.setObjectName("horizontalLayout_2")
        self.tabs = QtWidgets.QTabWidget(Q7OptionsWindow)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Fixed, QtWidgets.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.tabs.sizePolicy().hasHeightForWidth())
        self.tabs.setSizePolicy(sizePolicy)
        self.tabs.setMinimumSize(QtCore.QSize(630, 310))
        self.tabs.setMaximumSize(QtCore.QSize(630, 310))
        self.tabs.setObjectName("tabs")
        self.tab_1 = QtWidgets.QWidget()
        self.tab_1.setObjectName("tab_1")
        self.__O_recursivetreedisplay = QtWidgets.QCheckBox(self.tab_1)
        self.__O_recursivetreedisplay.setGeometry(QtCore.QRect(10, 15, 274, 22))
        self.__O_recursivetreedisplay.setObjectName("__O_recursivetreedisplay")
        self.__O_donotdisplaylargedata = QtWidgets.QCheckBox(self.tab_1)
        self.__O_donotdisplaylargedata.setGeometry(QtCore.QRect(10, 155, 274, 22))
        self.__O_donotdisplaylargedata.setObjectName("__O_donotdisplaylargedata")
        self.__O_donotloadlargearrays = QtWidgets.QCheckBox(self.tab_1)
        self.__O_donotloadlargearrays.setGeometry(QtCore.QRect(10, 80, 274, 22))
        self.__O_donotloadlargearrays.setObjectName("__O_donotloadlargearrays")
        self.label_1 = QtWidgets.QLabel(self.tab_1)
        self.label_1.setGeometry(QtCore.QRect(10, 35, 217, 27))
        self.label_1.setObjectName("label_1")
        self.__O_maxrecursionlevel = QtWidgets.QSpinBox(self.tab_1)
        self.__O_maxrecursionlevel.setGeometry(QtCore.QRect(235, 35, 71, 27))
        font = QtGui.QFont()
        font.setFamily("Courier")
        self.__O_maxrecursionlevel.setFont(font)
        self.__O_maxrecursionlevel.setMinimum(1)
        self.__O_maxrecursionlevel.setMaximum(99)
        self.__O_maxrecursionlevel.setProperty("value", 7)
        self.__O_maxrecursionlevel.setObjectName("__O_maxrecursionlevel")
        self.__O_maxloaddatasize = QtWidgets.QSpinBox(self.tab_1)
        self.__O_maxloaddatasize.setEnabled(True)
        self.__O_maxloaddatasize.setGeometry(QtCore.QRect(235, 100, 71, 27))
        font = QtGui.QFont()
        font.setFamily("Courier")
        font.setPointSize(10)
        self.__O_maxloaddatasize.setFont(font)
        self.__O_maxloaddatasize.setMinimum(-1)
        self.__O_maxloaddatasize.setMaximum(65535)
        self.__O_maxloaddatasize.setProperty("value", -1)
        self.__O_maxloaddatasize.setObjectName("__O_maxloaddatasize")
        self.__O_filterhdffiles = QtWidgets.QCheckBox(self.tab_1)
        self.__O_filterhdffiles.setGeometry(QtCore.QRect(320, 10, 274, 22))
        self.__O_filterhdffiles.setObjectName("__O_filterhdffiles")
        self.__O_filtercgnsfiles = QtWidgets.QCheckBox(self.tab_1)
        self.__O_filtercgnsfiles.setGeometry(QtCore.QRect(320, 90, 274, 22))
        self.__O_filtercgnsfiles.setObjectName("__O_filtercgnsfiles")
        self.line = QtWidgets.QFrame(self.tab_1)
        self.line.setGeometry(QtCore.QRect(305, 10, 20, 261))
        self.line.setFrameShape(QtWidgets.QFrame.VLine)
        self.line.setFrameShadow(QtWidgets.QFrame.Sunken)
        self.line.setObjectName("line")
        self.__O_cgnsfileextension = QtWidgets.QPlainTextEdit(self.tab_1)
        self.__O_cgnsfileextension.setGeometry(QtCore.QRect(335, 110, 211, 41))
        font = QtGui.QFont()
        font.setFamily("Courier")
        self.__O_cgnsfileextension.setFont(font)
        self.__O_cgnsfileextension.setObjectName("__O_cgnsfileextension")
        self.__O_hdffileextension = QtWidgets.QPlainTextEdit(self.tab_1)
        self.__O_hdffileextension.setGeometry(QtCore.QRect(335, 30, 211, 41))
        font = QtGui.QFont()
        font.setFamily("Courier")
        self.__O_hdffileextension.setFont(font)
        self.__O_hdffileextension.setObjectName("__O_hdffileextension")
        self.label_23 = QtWidgets.QLabel(self.tab_1)
        self.label_23.setGeometry(QtCore.QRect(10, 175, 217, 27))
        self.label_23.setObjectName("label_23")
        self.__O_maxdisplaydatasize = QtWidgets.QSpinBox(self.tab_1)
        self.__O_maxdisplaydatasize.setGeometry(QtCore.QRect(235, 175, 71, 27))
        font = QtGui.QFont()
        font.setFamily("Courier")
        self.__O_maxdisplaydatasize.setFont(font)
        self.__O_maxdisplaydatasize.setMinimum(-1)
        self.__O_maxdisplaydatasize.setMaximum(1000)
        self.__O_maxdisplaydatasize.setProperty("value", -1)
        self.__O_maxdisplaydatasize.setObjectName("__O_maxdisplaydatasize")
        self.label_9 = QtWidgets.QLabel(self.tab_1)
        self.label_9.setGeometry(QtCore.QRect(10, 100, 217, 27))
        self.label_9.setObjectName("label_9")
        self.tabs.addTab(self.tab_1, "")
        self.tab_8 = QtWidgets.QWidget()
        self.tab_8.setObjectName("tab_8")
        self.__O_fileupdateremoveschildren = QtWidgets.QCheckBox(self.tab_8)
        self.__O_fileupdateremoveschildren.setGeometry(QtCore.QRect(10, 10, 271, 21))
        self.__O_fileupdateremoveschildren.setObjectName("__O_fileupdateremoveschildren")
        self.tabs.addTab(self.tab_8, "")
        self.tab_2 = QtWidgets.QWidget()
        self.tab_2.setObjectName("tab_2")
        self.__O_addcurrentdirinsearch = QtWidgets.QCheckBox(self.tab_2)
        self.__O_addcurrentdirinsearch.setGeometry(QtCore.QRect(5, 10, 274, 22))
        self.__O_addcurrentdirinsearch.setObjectName("__O_addcurrentdirinsearch")
        self.__O_addrootdirinsearch = QtWidgets.QCheckBox(self.tab_2)
        self.__O_addrootdirinsearch.setGeometry(QtCore.QRect(5, 35, 311, 22))
        self.__O_addrootdirinsearch.setObjectName("__O_addrootdirinsearch")
        self.groupBox_2 = QtWidgets.QGroupBox(self.tab_2)
        self.groupBox_2.setGeometry(QtCore.QRect(5, 105, 546, 171))
        self.groupBox_2.setObjectName("groupBox_2")
        self.__O_linksearchpathlist = QtWidgets.QPlainTextEdit(self.groupBox_2)
        self.__O_linksearchpathlist.setGeometry(QtCore.QRect(0, 25, 541, 61))
        font = QtGui.QFont()
        font.setFamily("Courier")
        self.__O_linksearchpathlist.setFont(font)
        self.__O_linksearchpathlist.setObjectName("__O_linksearchpathlist")
        self.__O_followlinksatload = QtWidgets.QCheckBox(self.groupBox_2)
        self.__O_followlinksatload.setGeometry(QtCore.QRect(0, 95, 274, 22))
        self.__O_followlinksatload.setObjectName("__O_followlinksatload")
        self.__O_stoploadbrokenlinks = QtWidgets.QCheckBox(self.groupBox_2)
        self.__O_stoploadbrokenlinks.setGeometry(QtCore.QRect(0, 120, 274, 22))
        self.__O_stoploadbrokenlinks.setObjectName("__O_stoploadbrokenlinks")
        self.__O_donotfollowlinksatsave = QtWidgets.QCheckBox(self.groupBox_2)
        self.__O_donotfollowlinksatsave.setEnabled(False)
        self.__O_donotfollowlinksatsave.setGeometry(QtCore.QRect(0, 145, 274, 22))
        self.__O_donotfollowlinksatsave.setObjectName("__O_donotfollowlinksatsave")
        self.pushButton = QtWidgets.QPushButton(self.tab_2)
        self.pushButton.setEnabled(False)
        self.pushButton.setGeometry(QtCore.QRect(365, 15, 181, 26))
        self.pushButton.setObjectName("pushButton")
        self.tabs.addTab(self.tab_2, "")
        self.tab_7 = QtWidgets.QWidget()
        self.tab_7.setObjectName("tab_7")
        self.groupBox_4 = QtWidgets.QGroupBox(self.tab_7)
        self.groupBox_4.setGeometry(QtCore.QRect(5, 5, 546, 96))
        self.groupBox_4.setObjectName("groupBox_4")
        self.__O_profilesearchpathlist = QtWidgets.QPlainTextEdit(self.groupBox_4)
        self.__O_profilesearchpathlist.setGeometry(QtCore.QRect(0, 25, 541, 66))
        font = QtGui.QFont()
        font.setFamily("Courier")
        self.__O_profilesearchpathlist.setFont(font)
        self.__O_profilesearchpathlist.setObjectName("__O_profilesearchpathlist")
        self.__O_recursivesidspatternsload = QtWidgets.QCheckBox(self.tab_7)
        self.__O_recursivesidspatternsload.setGeometry(QtCore.QRect(5, 105, 274, 22))
        self.__O_recursivesidspatternsload.setObjectName("__O_recursivesidspatternsload")
        self.tabs.addTab(self.tab_7, "")
        self.tab_6 = QtWidgets.QWidget()
        self.tab_6.setObjectName("tab_6")
        self.__O_checkonthefly = QtWidgets.QCheckBox(self.tab_6)
        self.__O_checkonthefly.setEnabled(False)
        self.__O_checkonthefly.setGeometry(QtCore.QRect(10, 10, 274, 22))
        self.__O_checkonthefly.setCheckable(True)
        self.__O_checkonthefly.setObjectName("__O_checkonthefly")
        self.__O_forcesidslegacymapping = QtWidgets.QCheckBox(self.tab_6)
        self.__O_forcesidslegacymapping.setEnabled(False)
        self.__O_forcesidslegacymapping.setGeometry(QtCore.QRect(10, 30, 274, 22))
        self.__O_forcesidslegacymapping.setObjectName("__O_forcesidslegacymapping")
        self.__O_forcefortranflag = QtWidgets.QCheckBox(self.tab_6)
        self.__O_forcefortranflag.setEnabled(False)
        self.__O_forcefortranflag.setGeometry(QtCore.QRect(10, 50, 274, 22))
        self.__O_forcefortranflag.setObjectName("__O_forcefortranflag")
        self.groupBox_3 = QtWidgets.QGroupBox(self.tab_6)
        self.groupBox_3.setGeometry(QtCore.QRect(5, 75, 546, 201))
        self.groupBox_3.setObjectName("groupBox_3")
        self.label_31 = QtWidgets.QLabel(self.groupBox_3)
        self.label_31.setGeometry(QtCore.QRect(10, 25, 271, 21))
        self.label_31.setObjectName("label_31")
        self.cRecurseGrammarSearch = QtWidgets.QCheckBox(self.groupBox_3)
        self.cRecurseGrammarSearch.setEnabled(False)
        self.cRecurseGrammarSearch.setGeometry(QtCore.QRect(10, 50, 301, 21))
        self.cRecurseGrammarSearch.setCheckable(False)
        self.cRecurseGrammarSearch.setObjectName("cRecurseGrammarSearch")
        self.__O_grammarsearchpathlist = QtWidgets.QPlainTextEdit(self.groupBox_3)
        self.__O_grammarsearchpathlist.setGeometry(QtCore.QRect(0, 130, 536, 66))
        font = QtGui.QFont()
        font.setFamily("Courier")
        self.__O_grammarsearchpathlist.setFont(font)
        self.__O_grammarsearchpathlist.setObjectName("__O_grammarsearchpathlist")
        self.label_24 = QtWidgets.QLabel(self.groupBox_3)
        self.label_24.setGeometry(QtCore.QRect(0, 95, 147, 51))
        self.label_24.setObjectName("label_24")
        self.label_25 = QtWidgets.QLabel(self.tab_6)
        self.label_25.setGeometry(QtCore.QRect(385, 10, 111, 16))
        self.label_25.setObjectName("label_25")
        self.__O_valkeylist = QtWidgets.QPlainTextEdit(self.tab_6)
        self.__O_valkeylist.setGeometry(QtCore.QRect(385, 30, 156, 156))
        font = QtGui.QFont()
        font.setFamily("Courier")
        self.__O_valkeylist.setFont(font)
        self.__O_valkeylist.setObjectName("__O_valkeylist")
        self.tabs.addTab(self.tab_6, "")
        self.tab_3 = QtWidgets.QWidget()
        self.tab_3.setObjectName("tab_3")
        self.__O_label_size = QtWidgets.QSpinBox(self.tab_3)
        self.__O_label_size.setGeometry(QtCore.QRect(395, 20, 46, 27))
        self.__O_label_size.setMinimum(6)
        self.__O_label_size.setMaximum(18)
        self.__O_label_size.setProperty("value", 10)
        self.__O_label_size.setObjectName("__O_label_size")
        self.label = QtWidgets.QLabel(self.tab_3)
        self.label.setGeometry(QtCore.QRect(10, 25, 166, 17))
        self.label.setObjectName("label")
        self.__O_label_bold = QtWidgets.QCheckBox(self.tab_3)
        self.__O_label_bold.setGeometry(QtCore.QRect(455, 25, 86, 21))
        self.__O_label_bold.setText("")
        self.__O_label_bold.setObjectName("__O_label_bold")
        self.__O_label_italic = QtWidgets.QCheckBox(self.tab_3)
        self.__O_label_italic.setGeometry(QtCore.QRect(500, 25, 86, 21))
        self.__O_label_italic.setText("")
        self.__O_label_italic.setObjectName("__O_label_italic")
        self.__O_label_family = QtWidgets.QFontComboBox(self.tab_3)
        self.__O_label_family.setGeometry(QtCore.QRect(180, 20, 216, 26))
        self.__O_label_family.setObjectName("__O_label_family")
        self.label_3 = QtWidgets.QLabel(self.tab_3)
        self.label_3.setGeometry(QtCore.QRect(10, 55, 161, 17))
        self.label_3.setObjectName("label_3")
        self.label_12 = QtWidgets.QLabel(self.tab_3)
        self.label_12.setGeometry(QtCore.QRect(10, 85, 161, 17))
        self.label_12.setObjectName("label_12")
        self.label_26 = QtWidgets.QLabel(self.tab_3)
        self.label_26.setGeometry(QtCore.QRect(10, 115, 161, 17))
        self.label_26.setObjectName("label_26")
        self.label_27 = QtWidgets.QLabel(self.tab_3)
        self.label_27.setGeometry(QtCore.QRect(10, 145, 166, 17))
        self.label_27.setObjectName("label_27")
        self.label_28 = QtWidgets.QLabel(self.tab_3)
        self.label_28.setGeometry(QtCore.QRect(10, 175, 166, 17))
        self.label_28.setObjectName("label_28")
        self.label_29 = QtWidgets.QLabel(self.tab_3)
        self.label_29.setGeometry(QtCore.QRect(445, 5, 58, 16))
        self.label_29.setObjectName("label_29")
        self.label_30 = QtWidgets.QLabel(self.tab_3)
        self.label_30.setGeometry(QtCore.QRect(495, 5, 58, 16))
        self.label_30.setObjectName("label_30")
        self.__O_button_family = QtWidgets.QFontComboBox(self.tab_3)
        self.__O_button_family.setGeometry(QtCore.QRect(180, 50, 216, 26))
        self.__O_button_family.setObjectName("__O_button_family")
        self.__O_edit_family = QtWidgets.QFontComboBox(self.tab_3)
        self.__O_edit_family.setGeometry(QtCore.QRect(180, 80, 216, 26))
        self.__O_edit_family.setObjectName("__O_edit_family")
        self.__O_table_family = QtWidgets.QFontComboBox(self.tab_3)
        self.__O_table_family.setGeometry(QtCore.QRect(180, 110, 216, 26))
        self.__O_table_family.setObjectName("__O_table_family")
        self.__O_nname_family = QtWidgets.QFontComboBox(self.tab_3)
        self.__O_nname_family.setEnabled(False)
        self.__O_nname_family.setGeometry(QtCore.QRect(180, 140, 216, 26))
        self.__O_nname_family.setObjectName("__O_nname_family")
        self.__O_rname_family = QtWidgets.QFontComboBox(self.tab_3)
        self.__O_rname_family.setGeometry(QtCore.QRect(180, 170, 216, 26))
        self.__O_rname_family.setObjectName("__O_rname_family")
        self.__O_button_size = QtWidgets.QSpinBox(self.tab_3)
        self.__O_button_size.setGeometry(QtCore.QRect(395, 50, 46, 27))
        self.__O_button_size.setMinimum(6)
        self.__O_button_size.setMaximum(18)
        self.__O_button_size.setProperty("value", 10)
        self.__O_button_size.setObjectName("__O_button_size")
        self.__O_edit_size = QtWidgets.QSpinBox(self.tab_3)
        self.__O_edit_size.setGeometry(QtCore.QRect(395, 80, 46, 27))
        self.__O_edit_size.setMinimum(6)
        self.__O_edit_size.setMaximum(18)
        self.__O_edit_size.setProperty("value", 10)
        self.__O_edit_size.setObjectName("__O_edit_size")
        self.__O_table_size = QtWidgets.QSpinBox(self.tab_3)
        self.__O_table_size.setGeometry(QtCore.QRect(395, 110, 46, 27))
        self.__O_table_size.setMinimum(6)
        self.__O_table_size.setMaximum(18)
        self.__O_table_size.setProperty("value", 10)
        self.__O_table_size.setObjectName("__O_table_size")
        self.__O_nname_size = QtWidgets.QSpinBox(self.tab_3)
        self.__O_nname_size.setEnabled(False)
        self.__O_nname_size.setGeometry(QtCore.QRect(395, 140, 46, 27))
        self.__O_nname_size.setMinimum(6)
        self.__O_nname_size.setMaximum(18)
        self.__O_nname_size.setProperty("value", 10)
        self.__O_nname_size.setObjectName("__O_nname_size")
        self.__O_rname_size = QtWidgets.QSpinBox(self.tab_3)
        self.__O_rname_size.setGeometry(QtCore.QRect(395, 170, 46, 27))
        self.__O_rname_size.setMinimum(6)
        self.__O_rname_size.setMaximum(18)
        self.__O_rname_size.setProperty("value", 10)
        self.__O_rname_size.setObjectName("__O_rname_size")
        self.__O_button_bold = QtWidgets.QCheckBox(self.tab_3)
        self.__O_button_bold.setGeometry(QtCore.QRect(455, 55, 86, 21))
        self.__O_button_bold.setText("")
        self.__O_button_bold.setObjectName("__O_button_bold")
        self.__O_edit_bold = QtWidgets.QCheckBox(self.tab_3)
        self.__O_edit_bold.setGeometry(QtCore.QRect(455, 85, 86, 21))
        self.__O_edit_bold.setText("")
        self.__O_edit_bold.setObjectName("__O_edit_bold")
        self.__O_table_bold = QtWidgets.QCheckBox(self.tab_3)
        self.__O_table_bold.setGeometry(QtCore.QRect(455, 115, 86, 21))
        self.__O_table_bold.setText("")
        self.__O_table_bold.setObjectName("__O_table_bold")
        self.__O_nname_bold = QtWidgets.QCheckBox(self.tab_3)
        self.__O_nname_bold.setEnabled(False)
        self.__O_nname_bold.setGeometry(QtCore.QRect(455, 145, 86, 21))
        self.__O_nname_bold.setText("")
        self.__O_nname_bold.setObjectName("__O_nname_bold")
        self.__O_rname_bold = QtWidgets.QCheckBox(self.tab_3)
        self.__O_rname_bold.setGeometry(QtCore.QRect(455, 175, 86, 21))
        self.__O_rname_bold.setText("")
        self.__O_rname_bold.setObjectName("__O_rname_bold")
        self.__O_button_italic = QtWidgets.QCheckBox(self.tab_3)
        self.__O_button_italic.setGeometry(QtCore.QRect(500, 55, 86, 21))
        self.__O_button_italic.setText("")
        self.__O_button_italic.setObjectName("__O_button_italic")
        self.__O_edit_italic = QtWidgets.QCheckBox(self.tab_3)
        self.__O_edit_italic.setGeometry(QtCore.QRect(500, 85, 86, 21))
        self.__O_edit_italic.setText("")
        self.__O_edit_italic.setObjectName("__O_edit_italic")
        self.__O_table_italic = QtWidgets.QCheckBox(self.tab_3)
        self.__O_table_italic.setGeometry(QtCore.QRect(500, 115, 86, 21))
        self.__O_table_italic.setText("")
        self.__O_table_italic.setObjectName("__O_table_italic")
        self.__O_nname_italic = QtWidgets.QCheckBox(self.tab_3)
        self.__O_nname_italic.setEnabled(False)
        self.__O_nname_italic.setGeometry(QtCore.QRect(500, 145, 86, 21))
        self.__O_nname_italic.setText("")
        self.__O_nname_italic.setObjectName("__O_nname_italic")
        self.__O_rname_italic = QtWidgets.QCheckBox(self.tab_3)
        self.__O_rname_italic.setGeometry(QtCore.QRect(500, 175, 86, 21))
        self.__O_rname_italic.setText("")
        self.__O_rname_italic.setObjectName("__O_rname_italic")
        self.bResetFonts = QtWidgets.QPushButton(self.tab_3)
        self.bResetFonts.setGeometry(QtCore.QRect(10, 215, 25, 25))
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(25)
        sizePolicy.setVerticalStretch(25)
        sizePolicy.setHeightForWidth(self.bResetFonts.sizePolicy().hasHeightForWidth())
        self.bResetFonts.setSizePolicy(sizePolicy)
        self.bResetFonts.setMinimumSize(QtCore.QSize(25, 25))
        self.bResetFonts.setMaximumSize(QtCore.QSize(25, 25))
        self.bResetFonts.setText("")
        icon1 = QtGui.QIcon()
        icon1.addPixmap(QtGui.QPixmap(":/images/icons/undo-last-modification.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bResetFonts.setIcon(icon1)
        self.bResetFonts.setObjectName("bResetFonts")
        self.tabs.addTab(self.tab_3, "")
        self.tab_4 = QtWidgets.QWidget()
        self.tab_4.setObjectName("tab_4")
        self.__O_showtableindex = QtWidgets.QCheckBox(self.tab_4)
        self.__O_showtableindex.setGeometry(QtCore.QRect(320, 100, 274, 22))
        self.__O_showtableindex.setObjectName("__O_showtableindex")
        self.__O_oneviewpertreenode = QtWidgets.QCheckBox(self.tab_4)
        self.__O_oneviewpertreenode.setGeometry(QtCore.QRect(320, 175, 274, 22))
        self.__O_oneviewpertreenode.setObjectName("__O_oneviewpertreenode")
        self.__O_showhelpballoons = QtWidgets.QCheckBox(self.tab_4)
        self.__O_showhelpballoons.setGeometry(QtCore.QRect(320, 80, 274, 22))
        self.__O_showhelpballoons.setObjectName("__O_showhelpballoons")
        self.__O_show1dasplain = QtWidgets.QCheckBox(self.tab_4)
        self.__O_show1dasplain.setGeometry(QtCore.QRect(320, 125, 274, 22))
        self.__O_show1dasplain.setObjectName("__O_show1dasplain")
        self.__O_transposearrayforview = QtWidgets.QCheckBox(self.tab_4)
        self.__O_transposearrayforview.setGeometry(QtCore.QRect(320, 30, 274, 22))
        self.__O_transposearrayforview.setObjectName("__O_transposearrayforview")
        self.__O_autoexpand = QtWidgets.QCheckBox(self.tab_4)
        self.__O_autoexpand.setGeometry(QtCore.QRect(320, 55, 166, 21))
        self.__O_autoexpand.setObjectName("__O_autoexpand")
        self.groupBox_5 = QtWidgets.QGroupBox(self.tab_4)
        self.groupBox_5.setGeometry(QtCore.QRect(5, 10, 306, 261))
        self.groupBox_5.setCheckable(True)
        self.groupBox_5.setObjectName("groupBox_5")
        self.__O_showsidscolumn = QtWidgets.QCheckBox(self.groupBox_5)
        self.__O_showsidscolumn.setGeometry(QtCore.QRect(25, 25, 116, 21))
        self.__O_showsidscolumn.setObjectName("__O_showsidscolumn")
        self.__O_showlinkcolumn = QtWidgets.QCheckBox(self.groupBox_5)
        self.__O_showlinkcolumn.setGeometry(QtCore.QRect(25, 50, 84, 21))
        self.__O_showlinkcolumn.setObjectName("__O_showlinkcolumn")
        self.__O_showselectcolumn = QtWidgets.QCheckBox(self.groupBox_5)
        self.__O_showselectcolumn.setGeometry(QtCore.QRect(25, 75, 84, 21))
        self.__O_showselectcolumn.setObjectName("__O_showselectcolumn")
        self.__O_showcheckcolumn = QtWidgets.QCheckBox(self.groupBox_5)
        self.__O_showcheckcolumn.setGeometry(QtCore.QRect(25, 100, 84, 21))
        self.__O_showcheckcolumn.setObjectName("__O_showcheckcolumn")
        self.__O_showusercolumn = QtWidgets.QCheckBox(self.groupBox_5)
        self.__O_showusercolumn.setGeometry(QtCore.QRect(25, 125, 84, 21))
        self.__O_showusercolumn.setObjectName("__O_showusercolumn")
        self.__O_showshapecolumn = QtWidgets.QCheckBox(self.groupBox_5)
        self.__O_showshapecolumn.setGeometry(QtCore.QRect(25, 150, 84, 21))
        self.__O_showshapecolumn.setObjectName("__O_showshapecolumn")
        self.__O_showdatatypecolumn = QtWidgets.QCheckBox(self.groupBox_5)
        self.__O_showdatatypecolumn.setGeometry(QtCore.QRect(25, 175, 116, 21))
        self.__O_showdatatypecolumn.setObjectName("__O_showdatatypecolumn")
        self.tabs.addTab(self.tab_4, "")
        self.tab = QtWidgets.QWidget()
        self.tab.setObjectName("tab")
        self.groupBox = QtWidgets.QGroupBox(self.tab)
        self.groupBox.setGeometry(QtCore.QRect(10, 100, 536, 171))
        self.groupBox.setObjectName("groupBox")
        self.__O_querynoexception = QtWidgets.QCheckBox(self.groupBox)
        self.__O_querynoexception.setGeometry(QtCore.QRect(5, 30, 246, 20))
        self.__O_querynoexception.setObjectName("__O_querynoexception")
        self.checkBox = QtWidgets.QCheckBox(self.tab)
        self.checkBox.setEnabled(False)
        self.checkBox.setGeometry(QtCore.QRect(15, 10, 331, 20))
        self.checkBox.setObjectName("checkBox")
        self.checkBox_2 = QtWidgets.QCheckBox(self.tab)
        self.checkBox_2.setEnabled(False)
        self.checkBox_2.setGeometry(QtCore.QRect(15, 35, 331, 20))
        self.checkBox_2.setObjectName("checkBox_2")
        self.tabs.addTab(self.tab, "")
        self.tab_5 = QtWidgets.QWidget()
        self.tab_5.setObjectName("tab_5")
        self.label_4 = QtWidgets.QLabel(self.tab_5)
        self.label_4.setGeometry(QtCore.QRect(10, 15, 147, 27))
        self.label_4.setObjectName("label_4")
        self.label_5 = QtWidgets.QLabel(self.tab_5)
        self.label_5.setGeometry(QtCore.QRect(10, 45, 147, 27))
        self.label_5.setObjectName("label_5")
        self.__O_snapshotdirectory = QtWidgets.QLineEdit(self.tab_5)
        self.__O_snapshotdirectory.setGeometry(QtCore.QRect(160, 45, 391, 27))
        font = QtGui.QFont()
        font.setFamily("Courier")
        self.__O_snapshotdirectory.setFont(font)
        self.__O_snapshotdirectory.setObjectName("__O_snapshotdirectory")
        self.__O_queriesdirectory = QtWidgets.QLineEdit(self.tab_5)
        self.__O_queriesdirectory.setGeometry(QtCore.QRect(160, 15, 391, 27))
        font = QtGui.QFont()
        font.setFamily("Courier")
        self.__O_queriesdirectory.setFont(font)
        self.__O_queriesdirectory.setObjectName("__O_queriesdirectory")
        self.label_6 = QtWidgets.QLabel(self.tab_5)
        self.label_6.setGeometry(QtCore.QRect(10, 75, 147, 27))
        self.label_6.setObjectName("label_6")
        self.__O_selectionlistdirectory = QtWidgets.QLineEdit(self.tab_5)
        self.__O_selectionlistdirectory.setGeometry(QtCore.QRect(160, 75, 391, 27))
        font = QtGui.QFont()
        font.setFamily("Courier")
        self.__O_selectionlistdirectory.setFont(font)
        self.__O_selectionlistdirectory.setObjectName("__O_selectionlistdirectory")
        self.label_10 = QtWidgets.QLabel(self.tab_5)
        self.label_10.setGeometry(QtCore.QRect(10, 115, 147, 27))
        self.label_10.setObjectName("label_10")
        self.__O_adfconversioncom = QtWidgets.QLineEdit(self.tab_5)
        self.__O_adfconversioncom.setGeometry(QtCore.QRect(160, 115, 391, 27))
        font = QtGui.QFont()
        font.setFamily("Courier")
        self.__O_adfconversioncom.setFont(font)
        self.__O_adfconversioncom.setObjectName("__O_adfconversioncom")
        self.label_11 = QtWidgets.QLabel(self.tab_5)
        self.label_11.setGeometry(QtCore.QRect(10, 145, 151, 27))
        self.label_11.setObjectName("label_11")
        self.__O_temporarydirectory = QtWidgets.QLineEdit(self.tab_5)
        self.__O_temporarydirectory.setGeometry(QtCore.QRect(160, 145, 391, 27))
        font = QtGui.QFont()
        font.setFamily("Courier")
        self.__O_temporarydirectory.setFont(font)
        self.__O_temporarydirectory.setObjectName("__O_temporarydirectory")
        self.line_2 = QtWidgets.QFrame(self.tab_5)
        self.line_2.setGeometry(QtCore.QRect(10, 180, 536, 16))
        self.line_2.setFrameShape(QtWidgets.QFrame.HLine)
        self.line_2.setFrameShadow(QtWidgets.QFrame.Sunken)
        self.line_2.setObjectName("line_2")
        self.__O_activatemultithreading = QtWidgets.QCheckBox(self.tab_5)
        self.__O_activatemultithreading.setGeometry(QtCore.QRect(375, 195, 166, 21))
        self.__O_activatemultithreading.setObjectName("__O_activatemultithreading")
        self.__O_navtrace = QtWidgets.QCheckBox(self.tab_5)
        self.__O_navtrace.setGeometry(QtCore.QRect(10, 195, 131, 21))
        self.__O_navtrace.setObjectName("__O_navtrace")
        self.__O_chlonetrace = QtWidgets.QCheckBox(self.tab_5)
        self.__O_chlonetrace.setGeometry(QtCore.QRect(10, 215, 111, 21))
        self.__O_chlonetrace.setObjectName("__O_chlonetrace")
        self.bResetIgnored = QtWidgets.QPushButton(self.tab_5)
        self.bResetIgnored.setGeometry(QtCore.QRect(15, 240, 166, 28))
        self.bResetIgnored.setObjectName("bResetIgnored")
        self.tabs.addTab(self.tab_5, "")
        self.horizontalLayout_2.addWidget(self.tabs)
        self.verticalLayout.addLayout(self.horizontalLayout_2)
        self.horizontalLayout = QtWidgets.QHBoxLayout()
        self.horizontalLayout.setObjectName("horizontalLayout")
        self.bReset = QtWidgets.QPushButton(Q7OptionsWindow)
        self.bReset.setObjectName("bReset")
        self.horizontalLayout.addWidget(self.bReset)
        self.bInfo = QtWidgets.QPushButton(Q7OptionsWindow)
        self.bInfo.setMinimumSize(QtCore.QSize(25, 25))
        self.bInfo.setMaximumSize(QtCore.QSize(25, 25))
        self.bInfo.setText("")
        icon2 = QtGui.QIcon()
        icon2.addPixmap(QtGui.QPixmap(":/images/icons/help-view.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.bInfo.setIcon(icon2)
        self.bInfo.setObjectName("bInfo")
        self.horizontalLayout.addWidget(self.bInfo)
        spacerItem = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.horizontalLayout.addItem(spacerItem)
        self.bApply = QtWidgets.QPushButton(Q7OptionsWindow)
        self.bApply.setObjectName("bApply")
        self.horizontalLayout.addWidget(self.bApply)
        self.bClose = QtWidgets.QPushButton(Q7OptionsWindow)
        self.bClose.setObjectName("bClose")
        self.horizontalLayout.addWidget(self.bClose)
        self.verticalLayout.addLayout(self.horizontalLayout)

        self.retranslateUi(Q7OptionsWindow)
        self.tabs.setCurrentIndex(0)
        QtCore.QMetaObject.connectSlotsByName(Q7OptionsWindow)

    def retranslateUi(self, Q7OptionsWindow):
        _translate = QtCore.QCoreApplication.translate
        Q7OptionsWindow.setWindowTitle(_translate("Q7OptionsWindow", "Form"))
        self.__O_recursivetreedisplay.setText(_translate("Q7OptionsWindow", "Recursive tree display"))
        self.__O_donotdisplaylargedata.setText(_translate("Q7OptionsWindow", "Do not dispay large data"))
        self.__O_donotloadlargearrays.setText(_translate("Q7OptionsWindow", "Do not load large data arrays"))
        self.label_1.setText(_translate("Q7OptionsWindow", "Max tree parse recursion level:"))
        self.__O_filterhdffiles.setText(_translate("Q7OptionsWindow", "filter *.hdf files"))
        self.__O_filtercgnsfiles.setText(_translate("Q7OptionsWindow", "filter *.cgns files"))
        self.label_23.setText(_translate("Q7OptionsWindow", "Display nodes with data size below:"))
        self.label_9.setText(_translate("Q7OptionsWindow", "Do not load node data if above:"))
        self.tabs.setTabText(self.tabs.indexOf(self.tab_1), _translate("Q7OptionsWindow", "Load"))
        self.__O_fileupdateremoveschildren.setText(_translate("Q7OptionsWindow", "File update removes missing children"))
        self.tabs.setTabText(self.tabs.indexOf(self.tab_8), _translate("Q7OptionsWindow", "Save"))
        self.__O_addcurrentdirinsearch.setToolTip(_translate("Q7OptionsWindow", "Set to always add the current directory as the first in the linked-to files search.", "Set to always add the current directory as the first in the linked-to files search."))
        self.__O_addcurrentdirinsearch.setText(_translate("Q7OptionsWindow", "Add current dir in link search path"))
        self.__O_addrootdirinsearch.setText(_translate("Q7OptionsWindow", "Add file system root dir in link search path"))
        self.groupBox_2.setTitle(_translate("Q7OptionsWindow", "Search paths"))
        self.__O_followlinksatload.setText(_translate("Q7OptionsWindow", "Follow links during file load"))
        self.__O_stoploadbrokenlinks.setText(_translate("Q7OptionsWindow", "Stop loading on broken link"))
        self.__O_donotfollowlinksatsave.setText(_translate("Q7OptionsWindow", "Do not follow links during file save"))
        self.pushButton.setText(_translate("Q7OptionsWindow", "Remove unreachable paths"))
        self.tabs.setTabText(self.tabs.indexOf(self.tab_2), _translate("Q7OptionsWindow", "Links"))
        self.groupBox_4.setTitle(_translate("Q7OptionsWindow", "Search paths"))
        self.__O_recursivesidspatternsload.setText(_translate("Q7OptionsWindow", "Recursive SIDS patterns load"))
        self.tabs.setTabText(self.tabs.indexOf(self.tab_7), _translate("Q7OptionsWindow", "Profiles"))
        self.__O_checkonthefly.setText(_translate("Q7OptionsWindow", "Check on the fly"))
        self.__O_forcesidslegacymapping.setText(_translate("Q7OptionsWindow", "Force SIDS legacy mapping"))
        self.__O_forcefortranflag.setText(_translate("Q7OptionsWindow", "Force fortran flag in numpy arrays"))
        self.groupBox_3.setTitle(_translate("Q7OptionsWindow", "CGNS.VAL parameters"))
        self.label_31.setText(_translate("Q7OptionsWindow", "See also: Paths tab and grammars paths"))
        self.cRecurseGrammarSearch.setText(_translate("Q7OptionsWindow", "Activate recursion search for grammars (long)"))
        self.label_24.setText(_translate("Q7OptionsWindow", "<html><head/><body><p><span style=\" font-weight:600;\">Search paths</span></p></body></html>"))
        self.label_25.setText(_translate("Q7OptionsWindow", "Grammar keys"))
        self.tabs.setTabText(self.tabs.indexOf(self.tab_6), _translate("Q7OptionsWindow", "Checks"))
        self.label.setText(_translate("Q7OptionsWindow", "label"))
        self.label_3.setText(_translate("Q7OptionsWindow", "button"))
        self.label_12.setText(_translate("Q7OptionsWindow", "text edit"))
        self.label_26.setText(_translate("Q7OptionsWindow", "table (Form view)"))
        self.label_27.setText(_translate("Q7OptionsWindow", "graphic (VTK view)"))
        self.label_28.setText(_translate("Q7OptionsWindow", "node name (Tree view)"))
        self.label_29.setText(_translate("Q7OptionsWindow", "Bold"))
        self.label_30.setText(_translate("Q7OptionsWindow", "Italic"))
        self.bResetFonts.setToolTip(_translate("Q7OptionsWindow", "Reset all fonts to default installation fonts"))
        self.tabs.setTabText(self.tabs.indexOf(self.tab_3), _translate("Q7OptionsWindow", "Fonts"))
        self.__O_showtableindex.setText(_translate("Q7OptionsWindow", "Show table index"))
        self.__O_oneviewpertreenode.setText(_translate("Q7OptionsWindow", "One view per tree/node"))
        self.__O_showhelpballoons.setToolTip(_translate("Q7OptionsWindow", "Shows the help balloon you are reading right now."))
        self.__O_showhelpballoons.setText(_translate("Q7OptionsWindow", "Show tooltips"))
        self.__O_show1dasplain.setText(_translate("Q7OptionsWindow", "Show 1D values as Python plain types"))
        self.__O_transposearrayforview.setText(_translate("Q7OptionsWindow", "Transpose arrays for view/edit"))
        self.__O_autoexpand.setText(_translate("Q7OptionsWindow", "Auto expand tree view "))
        self.groupBox_5.setTitle(_translate("Q7OptionsWindow", "Show Tree Column Titles"))
        self.__O_showsidscolumn.setText(_translate("Q7OptionsWindow", "SIDS type"))
        self.__O_showlinkcolumn.setText(_translate("Q7OptionsWindow", "Link"))
        self.__O_showselectcolumn.setText(_translate("Q7OptionsWindow", "Mark"))
        self.__O_showcheckcolumn.setText(_translate("Q7OptionsWindow", "Check"))
        self.__O_showusercolumn.setText(_translate("Q7OptionsWindow", "User"))
        self.__O_showshapecolumn.setText(_translate("Q7OptionsWindow", "Shape"))
        self.__O_showdatatypecolumn.setText(_translate("Q7OptionsWindow", "Data Type"))
        self.tabs.setTabText(self.tabs.indexOf(self.tab_4), _translate("Q7OptionsWindow", "Windows"))
        self.groupBox.setTitle(_translate("Q7OptionsWindow", "Debug"))
        self.__O_querynoexception.setText(_translate("Q7OptionsWindow", "Do not catch any exception"))
        self.checkBox.setText(_translate("Q7OptionsWindow", "Ignore queries operating modification of the tree"))
        self.checkBox_2.setText(_translate("Q7OptionsWindow", "Add query results to previous query results"))
        self.tabs.setTabText(self.tabs.indexOf(self.tab), _translate("Q7OptionsWindow", "Queries"))
        self.label_4.setText(_translate("Q7OptionsWindow", "User queries directory"))
        self.label_5.setText(_translate("Q7OptionsWindow", "Snapshot directory"))
        self.label_6.setText(_translate("Q7OptionsWindow", "Selection list directory"))
        self.label_10.setText(_translate("Q7OptionsWindow", "ADF conversion"))
        self.label_11.setText(_translate("Q7OptionsWindow", "Temporary directory"))
        self.__O_activatemultithreading.setText(_translate("Q7OptionsWindow", "Activate Multi-threading"))
        self.__O_navtrace.setText(_translate("Q7OptionsWindow", "CGNS.NAV trace"))
        self.__O_chlonetrace.setText(_translate("Q7OptionsWindow", "CHLone trace"))
        self.bResetIgnored.setText(_translate("Q7OptionsWindow", "Reset ignored messages"))
        self.tabs.setTabText(self.tabs.indexOf(self.tab_5), _translate("Q7OptionsWindow", "Other"))
        self.bReset.setText(_translate("Q7OptionsWindow", "Reset"))
        self.bApply.setText(_translate("Q7OptionsWindow", "Apply"))
        self.bClose.setText(_translate("Q7OptionsWindow", "Close"))

import Res_rc
