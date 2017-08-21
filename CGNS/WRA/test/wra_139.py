#  -------------------------------------------------------------------------
#  pyCGNS - Python package for CFD General Notation Sys
#  See license.txt file in the root directory of this Python module source  
#  -------------------------------------------------------------------------
from __future__ import print_function

import CGNS.WRA.mll as Mll
import numpy as N

print('CGNS.WRA.mll', '#139 - ziter_read')

# ----------------------------------------------------------------------
a = Mll.pyCGNS('tmp/testmll40.hdf', Mll.MODE_READ)
n = a.ziter_read(1, 1)
a.close()
