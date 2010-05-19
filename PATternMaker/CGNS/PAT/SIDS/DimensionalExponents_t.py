# CFD General Notation System - CGNS lib wrapper
# ONERA/DSNA/ELSA - poinot@onera.fr
# pyCGNS - $Rev: 47 $ $Date: 2008-01-24 12:00:02 +0100 (Thu, 24 Jan 2008) $
# See file COPYING in the root directory of this Python module source 
# tree for license information. 
#
import CGNS.PAT.cgnslib      as C
import CGNS.PAT.cgnserrors   as E
import CGNS.PAT.cgnskeywords as K
import numpy             as N
#
data=C.newDimensionalExponents(None)
C.newRind(data,N.array([0,0,0,0,1,1]))
C.newDataClass(data)
C.newDimensionalUnits(data)
C.newUserDefinedData(data,'{UserDefinedData}')
C.newDescriptor(data,'{Descriptor}')
#
status='4.4'
comment='Full SIDS with all optionals'
pattern=[data, status, comment]
#
