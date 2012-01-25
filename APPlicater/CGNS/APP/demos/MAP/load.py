#!/usr/bin/env python
#  -------------------------------------------------------------------------
#  pyCGNS.APP - Python package for CFD General Notation System - APPlicater
#  See license.txt file in the root directory of this Python module source  
#  -------------------------------------------------------------------------
#  $Release$
#  ------------------------------------------------------------------------- 
import CGNS.MAP

(tree,links)=CGNS.MAP.load("./data/T0.cgns",CGNS.MAP.S2P_DEFAULT)

print tree
print links

# --- last line