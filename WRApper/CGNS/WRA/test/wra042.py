import CGNS.WRA.mll as Mll
import numpy as N

# ----------------------------------------------------------------------
a=Mll.pyCGNS('tmp/testmll43.hdf',Mll.MODE_READ)
a.gopath('/Base/Zone 01')

n=a.where()
print n

a.close()

