#!/usr/bin/env python
# CFD General Notation System - CGNS lib wrapper
# ONERA/DSNA/ELSA - poinot@onera.fr
# pyCGNS - $Rev: 79 $ $Date: 2009-03-13 10:19:54 +0100 (Fri, 13 Mar 2009) $
# See file COPYING in the root directory of this Python module source 
# tree for license information. 
#
import os

from   distutils.core import setup, Extension
import distutils.util
import distutils.sysconfig

import getopt
import re
import sys
import glob
import string

# --- pyCGNSconfig search
import os
import sys
spath=sys.path[:]
sys.path=[os.getcwd(),'%s/..'%(os.getcwd())]
try:
  import pyCGNSconfig
except ImportError:
  print 'pyGCNS[ERROR]: WRA cannot find pyCGNSconfig.py file!'
  sys.exit(1)
sys.path=[os.getcwd(),'%s/..'%(os.getcwd())]+spath
import setuputils
setuputils.installConfigFiles([os.getcwd(),'%s/..'%(os.getcwd())])
sys.prefix=sys.exec_prefix
# ---

setconfig=0
for distcom in sys.argv:
  if distcom in ['build', 'install']:
    setconfig=1

if setconfig:
  largs='python '+string.join(sys.argv)
  if (not os.path.exists('./build')): os.mkdir('./build')
  ftrace=open('./pyCGNS.log.%s'%os.getpid(),'w+')
  ftrace.write(largs)
  ftrace.write('\n')
  ftrace.close()

# ---------------------------------------------------------------------------
# pyCGNS build options:
#

# --- default values
mll=True
hdf=False
alib='numpy'
chlonelib=hdflib=cgnslib=""
hdfversion=cgnsversion=chloneversion='unknown'

sys.path.append('./CGNS')
from version import __vid__

lname         = "pyCGNS"
lversion      = __vid__

pdir=os.path.normpath(sys.prefix)
xdir=os.path.normpath(sys.exec_prefix)

extraargs=['-U__CGNS_HEADER_INSTALLED__']
include_dirs=[]
library_dirs=[]
optional_libs=[]

rpathlib=[]
cgnsincdir=[pdir+'/include']
cgnslibdir=[xdir+'/lib']

olist='h'

# See pyCGNS/README for OPTIONS selection

lolist=["cgns-with-mll",       # produce CGNS/MLL/ADF binding
        "cgns-with-chlone",    # produce HDF5/CHLONE binding
        "cgns-without-mll",    # produce without CGNS/MLL/ADF binding
        "cgns-without-chlone", # produce without HDF5/CHLONE storage/module
        "cgns-path-includes=", # <:> list of path to MLL,ADF,HDF include files
        "cgns-path-libs=",     # <:> list of path to MLL,HDF... libs
        "cgns-libs="]          # <:> list of extra libs

# distutils standard options
lolist+=['help','prefix=']

def printUsageButDontLeave():
  print 72*'='
  print "### pyCGNS: see README file for details on installation options"
  print "### pyCGNS: in particular for default values."
  print "### pyCGNS: --cgns-with-mll --cgns-without-mll"
  print "### pyCGNS: --cgns-with-chlone --cgns-without-chlone"
  print "### pyCGNS: --cgns-path-includes=path1:path2:path3"
  print "### pyCGNS: --cgns-path-libs=path1:path2:path3"
  print "### pyCGNS: --cgns-libs=lib1:lib2:lib3"

# --- parse options, override values
try:
  opts, args = getopt.gnu_getopt(sys.argv[1:],olist,lolist)
except getopt.GetoptError:
  printUsageButDontLeave()
  sys.exit(2)

for o,a in opts:
  if (o == "--cgns-with-mll"):      mll=True
  if (o == "--cgns-with-chlone"):   hdf=True
  if (o == "--cgns-without-mll"):   mll=False
  if (o == "--cgns-without-chlone"):hdf=False
  if (o == "--cgns-path-includes"): cgnsincdir=a.split(':')
  if (o == "--cgns-path-libs"):     cgnslibdir=a.split(':')
  if (o == "--cgns-libs"):          optional_libs=a.split(':')
  if (o in ['-h',"--help"]):        printUsageButDontLeave()
  
# --- remove pyCGNS options (options will be used by distutils)
rl=[]
for opt in sys.argv:
  if (opt[:7] != '--cgns-'): rl.append(opt)
sys.argv=rl

summary=""

if setconfig:

  num=alib
  rpathlib=[]

  # --- CHlone setup ---
  if hdf:  
    extraargs+=['-D__USE_CHLONE__']
    summary+="### pyCGNS: CHLONE        [YES]\n"
    notfound=1
    chloneversion="0.1"
    for pth in cgnslibdir:
      if (    (os.path.exists(pth+'/libCHlone.a'))
           or (os.path.exists(pth+'/libCHlone.so'))
           or (os.path.exists(pth+'/libCHlone.sl'))):
        rpathlib+=[pth]
        chlonelib=pth+'/libCHlone.so'
        notfound=0
    if notfound:
      print "### pyCGNS: ERROR: libCHlone not found, please check paths:"
      print "### pyCGNS: ",cgnslibdir
      sys.exit(1)
    notfound=1      
    for pth in cgnsincdir:
      if (os.path.exists(pth+'/CHlone.h')): notfound=0
    if notfound:
      print "### pyCGNS: ERROR: CHlone.h not found, please check paths"
      print "### pyCGNS: ",cgnsincdir
      sys.exit(1)
  else:
    summary+="### pyCGNS: CHLONE        [NO]\n"

  # --- HDF5 (mandatory for MLL or CHlone) ---
  if hdf or mll:
    notfound=1
    for pth in cgnslibdir:
      if (    (os.path.exists(pth+'/libhdf5.a'))
           or (os.path.exists(pth+'/libhdf5.so'))
           or (os.path.exists(pth+'/libhdf5.sl'))):
        rpathlib+=[pth]
        hdflib=pth+'/libhdf5.so'
        notfound=0
    if notfound:
      print "### pyCGNS: ERROR: libhdf5 not found, please check paths:"
      print "### pyCGNS: ",cgnslibdir
      sys.exit(1)
    notfound=1
    for pth in cgnsincdir:
      if (os.path.exists(pth+'/hdf5.h')):
        notfound=0
    if notfound:
      print "### pyCGNS: ERROR: hdf5.h not found, please check paths"
      print "### pyCGNS: ",cgnsincdir
      sys.exit(1)
    # find hdf5 version
    ifh='HDF5 library version: unknown'
    for pth in cgnsincdir:
      if (os.path.exists(pth+'/H5public.h')):
        fh=open(pth+'/H5public.h','r')
        fl=fh.readlines()
        fh.close()
        for ifh in fl:
          if (ifh[:21] == "#define H5_VERS_INFO "):
            hdfversion=ifh.split('"')[1]
            break
  else:
    summary+="### pyCGNS: HDF5          [NO]\n"

  if mll:
    notfound=1
    for pth in cgnsincdir:
      if (os.path.exists(pth+'/cgnslib.h')):
        notfound=0
        f=open(pth+'/cgnslib.h','r')
        l=f.readlines()
        f.close()
        for ll in l:
          if (ll[:20]=="#define CGNS_VERSION"):
            cgnsversion=ll.split()[2]
            if (cgnsversion<'3000'):
              extraargs+=['-D__CGNS_NO_HDF__']

      
    if notfound:
      print "### pyCGNS: ERROR: cgnslib.h not found, please check paths"
      print "### pyCGNS: ",cgnsincdir
      sys.exit(1)

    summary+="### pyCGNS: CGNS MLL      [YES]\n"
    summary+="### pyCGNS: CGNS version  %s\n"%cgnsversion
    summary+="### pyCGNS: CGNS includes %s\n"%(cgnsincdir)
    summary+="### pyCGNS: CGNS libs     %s\n"%(cgnslibdir)

    notfound=1
    for pth in cgnslibdir:
      if (    (os.path.exists(pth+'/libcgns.a'))
           or (os.path.exists(pth+'/libcgns.so'))
           or (os.path.exists(pth+'/libcgns.sl'))):
        rpathlib+=[pth]
        cgnslib=pth+'/libcgns.so'
        notfound=0

    if notfound:
      print "### pyCGNS: ERROR: libcgns not found, please check paths:"
      print "### pyCGNS: ",cgnslibdir
      sys.exit(1)
      
    notfound=1
    for pth in cgnsincdir:
      if (os.path.exists(pth+'/adfh/ADFH.h')):
        extraargs+=['-D__ADF_IN_SOURCES__']
        notfound=0
      if (os.path.exists(pth+'/ADFH.h')):
        notfound=0

    if notfound:
      print "### pyCGNS: Warning: ADFH.h not found, using pyCGNS own headers"
      extraargs+=['-U__ADF_IN_SOURCES__']
       
    include_dirs+=cgnsincdir
    library_dirs+=cgnslibdir
    
  else:
    summary+="### pyCGNS: CGNS MLL      [NO]\n"
    summary+="### pyCGNS: \n"
    summary+="### pyCGNS: WARNING: installation WITHOUT MLL library bindings\n"
    summary+="### pyCGNS:          only Python libs will be installed\n"
    summary+="### pyCGNS:          see README file for installation options\n"

  from time import gmtime, strftime
  proddate=strftime("%Y-%m-%d %H:%M:%S", gmtime())
  prodhost=os.uname()

  print 72*'='
  print summary,
  print 72*'='

  configfile=open("../pyCGNSconfig.py","a")
  configfile.write("# CFD General Notation System - CGNS lib wrapper\n")
  configfile.write("# ONERA/DSNA/ELSA - poinot@onera.fr\n")
  configfile.write("# See file COPYING in the root directory")
  configfile.write("of this Python module source\n")
  configfile.write("# tree for license information.\n")
  configfile.write("\n# THIS FILE IS GENERATED DURING INSTALLATION\n\n")
  configfile.write("VERSION='%s'\n"%lversion)
  configfile.write("DATE='%s'\n"%proddate)
  configfile.write("PLATFORM=%s\n"%str(prodhost))
  configfile.write("HAS_MLL=%s\n"%mll)
  configfile.write("PATH_MLL='%s'\n"%cgnslib)
  configfile.write("PATH_HDF5='%s'\n"%hdflib)
  configfile.write("PATH_CHLONE='%s'\n"%chlonelib)
  configfile.write("NUM_LIBRARY='%s'\n"%num)
  configfile.write("MLL_VERSION='%s'\n"%cgnsversion)
  configfile.write("HAS_CHLONE=%s\n"%hdf)
  configfile.write("HDF5_VERSION='%s'\n"%hdfversion)
  configfile.write("CHLONE_VERSION='%s'\n"%chloneversion)
  configfile.write("INCLUDE_PATH=%s\n"%include_dirs)
  configfile.write("LIB_PATH=%s\n"%library_dirs)
  configfile.write("EXTRA_ARGS=%s\n"%extraargs)
  configfile.write("OPTIONAL_LIBS=%s\n"%optional_libs)
  configfile.write("\n# --- last line\n\n")
  configfile.close()

  btarget='./build/lib.%s-%s'%(distutils.util.get_platform(),sys.version[0:3])

# --- add common stuff
nincs='%s/lib/python%s/site-packages/numpy/core/include'%(xdir,sys.version[:3])
include_dirs+=cgnsincdir+[nincs,'modadf']
if (mll):
  optional_libs+=['cgns','hdf5']
if (hdf):
  optional_libs+=['CHlone','hdf5']

extraargslk=[]
for nrpth in rpathlib:
  extraargslk+=['-Wl,-rpath,%s'%nrpth]

lext_modules=[]

# ***************************************************************************
# Setup script for the CGNS Python interface
ldescription  = "Python CFD General Notation System Interfaces"
lauthor       = "ONERA/DSNA/ELSA Marc Poinot"
lauthor_email = "poinot@onera.fr"
lurl          = "http://elsa.onera.fr/CGNS/releases"
llicense      = "Python"
lverbose      = 1
lpackages     = ['CGNS.WRA']
lscripts      = []

ldata_files   = [
('share/CGNS/WRA/demo',glob.glob('CGNS/WRA/demo/*.py')),
('share/CGNS/WRA/demo/UsersGuide',
glob.glob('CGNS/WRA/demo/UsersGuide/*.py')),
('share/CGNS/WRA/test',glob.glob('CGNS/test/*.py'))]

# ---
if mll:
  lext_modules += [
                # You must let adfmodule into the midlevel shared library
                # ADF has some static variables, and changing module .so
                # will let the values separate, one in each .so
                # Thus, adf module has to be duplicated and the calls to
                # adf through midlevel should be clearly scoped in the
                # python code
                Extension('CGNS.WRA.midlevelmodule', 
                sources=['modadf/adfmodule.c',
                         'modmll/cgnsmodule.c',
                         'modmll/cgnsdict.c'],
                          include_dirs = include_dirs,
                          library_dirs = library_dirs,
                          libraries    = optional_libs,
                          extra_compile_args=extraargs,
                          extra_link_args=extraargslk),
                Extension('CGNS.WRA.adfmodule', 
                sources=['modadf/adfmodule.c'],
                          include_dirs = include_dirs,
                          library_dirs = library_dirs,
                          extra_link_args=extraargslk,
                          libraries    = optional_libs)
                ] # close extension modules
                
setup (
  name         = lname,
  version      = lversion,
  description  = ldescription,
  author       = lauthor,
  author_email = lauthor_email,
  url          = lurl,
  license      = llicense,
  verbose      = lverbose,
  ext_modules  = lext_modules,
  packages     = lpackages,
  scripts      = lscripts,
  data_files   = ldata_files,

  cmdclass={'clean':setuputils.clean}

) # close setup

if setconfig:
  print '### Leave the installation directory and test with:'
  print "python -c 'import CGNS.WRA;CGNS.WRA.test()'"
  
# --- last line
  
