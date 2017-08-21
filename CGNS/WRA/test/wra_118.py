#  -------------------------------------------------------------------------
#  pyCGNS - Python package for CFD General Notation Sys
#  See license.txt file in the root directory of this Python module source  
#  -------------------------------------------------------------------------
from __future__ import print_function
import CGNS.WRA.mll as Mll
import numpy as N

print('CGNS.WRA.mll', '#118 - model_read')

# ----------------------------------------------------------------------
a = Mll.pyCGNS('tmp/testmll21.hdf', Mll.MODE_READ)
a.gopath("/Base/FlowEquationSet")
t = a.model_read('GasModel_t')
a.close()
