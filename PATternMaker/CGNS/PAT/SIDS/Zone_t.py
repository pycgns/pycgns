#  ---------------------------------------------------------------------------
#  pyCGNS.PAT - Python package for CFD General Notation System - PATternMaker
#  See license.txt file in the root directory of this Python module source  
#  ---------------------------------------------------------------------------
#  $Release$
#  ---------------------------------------------------------------------------
#
import CGNS.PAT.cgnslib      as C
import CGNS.PAT.cgnserrors   as E
import CGNS.PAT.cgnskeywords as K
import numpy             as N

data=C.newZone(None,'{Zone}',N.array([[5,7,9],[4,6,8],[0,0,0]],order='F'))

g1=C.newGridCoordinates(data,"GridCoordinates")
C.newRigidGridMotion(data,"{RigidGridMotion}")
C.newArbitraryGridMotion(data,"{ArbitraryGridMotion}")
C.newFlowSolution(data,"{FlowSolution}")
C.newDiscreteData(data,"{DiscreteData}")
C.newIntegralData(data,"{IntegralData}")
C.newZoneGridConnectivity(data,"{GridConnectivity}")
C.newBoundary(data,"{BC}",N.array([[0,0,0],[0,0,0]]))
C.newZoneIterativeData(data,"{ZoneIterativeData}")
C.newReferenceState(data)
C.newRotatingCoordinates(data)
C.newDataClass(data)
C.newDimensionalUnits(data)
C.newFlowEquationSet(data)
C.newConvergenceHistory(data,K.ZoneConvergenceHistory_s)
C.newUserDefinedData(data,'{UserDefinedData}')
C.newDescriptor(data,'{Descriptor}')
C.newOrdinal(data)

status='6.3'
comment='Full SIDS with all optionals'
pattern=[data, status, comment]
