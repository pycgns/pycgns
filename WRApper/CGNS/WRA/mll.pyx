#  -------------------------------------------------------------------------
#  pyCGNS.WRA - Python package for CFD General Notation System - WRAper
#  See license.txt file in the root directory of this Python module source  
#  -------------------------------------------------------------------------
#  $Release: v4.0.1 $
#  -------------------------------------------------------------------------
"""
CGNS.WRA.mll is a CGNS/MLL Python wrapper. It defines a `pyCGNS` class
which performs the `cg_open` and holds the opened file descriptor for
subsequent calls.

CGNS.WRA.mll is using a Cython wrapping, it replaces the CGNS.WRA._mll which
was an old hand-coded wrapper, difficult to maintain.
"""
import os.path
import CGNS.PAT.cgnskeywords as CK
import numpy as PNY

cimport cgnslib
cimport numpy as CNY

MODE_READ   = 0
MODE_WRITE  = 1
MODE_CLOSED = 2
MODE_MODIFY = 3

CG_OK             = 0
CG_ERROR          = 1
CG_NODE_NOT_FOUND = 2
CG_INCORRECT_PATH = 3
CG_NO_INDEX_DIM   = 4

Null              = 0
UserDefined       = 1

CG_FILE_NONE      = 0
CG_FILE_ADF       = 1
CG_FILE_HDF5      = 2
CG_FILE_XML       = 3    

# ------------------------------------------------------------
cdef cg_open_(char *filename, int mode):
  """
  cg_open_ is reserved for internal use by pyCGNS class, you should not
  call it.
  """
  cdef int fid
  fname=os.path.normpath(filename)
  fid=-1
  err=cgnslib.cg_open(filename,mode,&fid)
  return (fid,err)

cdef enum:
  MAXNAMELENGTH = 33

cdef asnumpydtype(cgnslib.DataType_t dtype):
    if (dtype==CK.RealSingle):  return PNY.float32
    if (dtype==CK.RealDouble):  return PNY.float64
    if (dtype==CK.Integer):     return PNY.int32
    if (dtype==CK.LongInteger): return PNY.int64
    if (dtype==CK.Character):   return PNY.uint8
    return None
        
cdef fromnumpydtype(dtype):
    if (dtype==PNY.float32):  return CK.RealSingle
    if (dtype==PNY.float64):  return CK.RealDouble
    if (dtype==PNY.int32):    return CK.Integer
    if (dtype==PNY.int64):    return CK.LongInteger
    if (dtype==PNY.uint8):    return CK.Character
    return None

class CGNSException(Exception):
    def __init__(self,code,msg):
        self.msg=msg
        self.code=code
    def __str__(self):
        return "pyCGNS Error: [%.4d] %s"%(self.code,self.msg)
    
# ====================================================================
cdef class pyCGNS(object):
  """
  A `pyCGNS` object is a CGNS/MLL file handler. You can call any
  CGNS/MLL function on this object, a `cg_<function>` in the C API
  is named `<function>` in this Python API. Functions are returning
  values instead of error code, you have to check each function
  mapping to known what are the inputs/outputs.  You would also find
  extra functions providing the user with a better Python interface.

  A `pyCGNS` object creation is a call to `cg_open`::

    db=CGNS.WRA.mll.pyCGNS('5blocks.cgns',CGNS.WRA.mll.MODE_READ)
    for b in db.bases():
      for z in db.zones(b):
         print db.zone_read(b,z)

  - Args:
   * `filename`: the target file path
   * `mode`:     an integer setting the open mode, an enumerate you should
   use through the Python module enumerate (CGNS.WRA.mll.MODE_READ,
   CGNS.WRA.mll.MODE_WRITE,CGNS.WRA.mll.MODE_MODIFY)

  - Return:
   * A pyCGNS class instance, the object is the CGNS/MLL file descriptor
   on which you can call CGNS/MLL functions.
       
  """
  cdef public object _mode
  cdef public object _root
  cdef public object _error
  cdef public object _filename

  def __init__(self,filename,mode):
    self._filename=filename
    self._mode=mode
    (self._root,self._error)=cg_open_(filename,mode)

  # ---------------------------------------------------------------------------
  cpdef close(self):
    """
    Closes the CGNS/MLL file descriptor.

    - Remarks:
    * The Python object is still there, however you cannot call any CGNS/MLL
    function with it. The `__del__` of the Python object calls the `close`.
    """
    cgnslib.cg_close(self._root)
    return CG_OK
  # ---------------------------------------------------------------------------
  cpdef float version(self):
    """
    Returns the CGNS/MLL library version::

      v=db.version()

    - Return:
     * The version number as a float, for example 2.400 is CGNS/MLL version 2.4

    - Remarks:
     * The Python print may display a float value without rounding, this may
     change with your Python version and the way you actually print the value::
     
      print '%g'%(db.version())
     
    """
    cdef float v
    cgnslib.cg_version(self._root,&v)
    return v
  # ---------------------------------------------------------------------------
  cpdef gopath(self,char *path):
    cgnslib.cg_gopath(self._root,path)

  # ------------------------------------------------------------------------------------------
##   cpdef where(self):
##     cdef int fn = -1
##     cdef int B = -1
##     cdef int depth = -1
##     cdef CNY.ndarray[dtype=CNY.int32_t,ndim=1] pnum
##     cdef CNY.ndarray[dtype=CNY.uint32_t,ndim=1] plab
##     cdef int* tnum
##     cdef char* tlab
##     pnum=PNY.ones((9,),dtype=PNY.int32)
##     tnum=<int *>pnum.data
##     plab=PNY.array(tuple(' '*256))
##     tlab=<char *>plab.data
##     self._error=cgnslib.cg_where(&fn,&B,&depth,&tlab,tnum)
##     return (fn,B,depth,plab,pnum)
  # ---------------------------------------------------------------------------
  cpdef nbases(self):
    """
    Returns the number of bases::

      for B in range(1,db.nbases()+1):
         print db.base_read(B)

    - Return:
     * The number of bases as an integer

    - Remarks:
     * See also :py:func:`bases`
    """
    cdef int n
    self._error=cgnslib.cg_nbases(self._root,&n)
    return n
  # ---------------------------------------------------------------------------
  cpdef bases(self):
    """
    Returns the bases indices::

      for B in db.bases():
         print db.base_read(B)

    - Return:
     * An `xrange` from 1 to <number of bases> or an empty list if there is
       no base at all.
       
    - Remarks:
     * See also :py:func:`nbases`
    """
    cdef int n
    self._error=cgnslib.cg_nbases(self._root,&n)
    if (n!=0): return xrange(1,n+1)
    return []
  # ---------------------------------------------------------------------------
  cpdef base_read(self, int B):
    """
    Returns a tuple with information about the base.

    - Args:
     * `B`: the base id 

    - Return:
     * argument base id (`int`)
     * base name (`string`)
     * cell dimensions (`int`)
     * physical dimensions (`int`)
    """
    cdef char basename[MAXNAMELENGTH]
    cdef int  cdim
    cdef int  pdim
    self._error=cgnslib.cg_base_read(self._root,B,basename,&cdim,&pdim)
    return (B, basename, cdim, pdim)
  # ---------------------------------------------------------------------------
  cpdef base_id(self, int B):
    """
    Returns the base internal id.

    - Args:
     * `B`: the CGNS/MLL base id (`int`) (this is **not** the internal id)

    - Return:
     * The base internal id (`int`)

    - Remarks:
     * This id can be used with the CGNS/ADF or CGNS/HDF5 API. If you don't
     know what this id is... then you should not use it.
    """
    cdef double ibid
    self._error=cgnslib.cg_base_id(self._root,B,&ibid)
    return ibid
  # ---------------------------------------------------------------------------
  cpdef base_write(self, char *basename, int cdim, int pdim):
    """
    Creates a new base::

      bid=db.base_write('Base-001',3,3)

    - Args:
     * `basename`: name of the new base (`string` should not exceed 32 chars)
     * `celldim`: cell dimensions of the base (`int`)
     * `physicaldim`: physical dimension of the base (`int`)

    - Return:
     * New base id (`int`)
    """
    cdef int bid
    self._error=cgnslib.cg_base_write(self._root,basename,cdim,pdim,&bid)
    return bid
  # ---------------------------------------------------------------------------
  cpdef zones(self, int B):
    """
    Returns all the zones indices of a base::

      for Z in db.zones(B):
         print db.zone_read(B,Z)[2]

    - Args:
     * `B`: the parent base id (`int`) (:py:func:`bases` and :py:func:`nbases`).

    - Return:
     * An `xrange` from 1 to <number of zones> or an empty list if there is
       no zone at all.
       
    - Remarks:
     * See also :py:func:`nzones`
    """
    cdef int n
    self._error=cgnslib.cg_nzones(self._root,B,&n)
    if (n!=0): return xrange(1,n+1)
    return []
  # ---------------------------------------------------------------------------
  cpdef nzones(self, int B):
    """
    Returns the number of zones in a base::

      for Z in range(1,db.nzones(B)+1):
         print db.zone_read(B,Z)[2]

    - Args:
     * `B`: Parent base id (`int`) (:py:func:`bases` and :py:func:`nbases`).

    - Return:
     * Number of zones as an integer (`int`)

    - Remarks:
     * See also :py:func:`zones`
    """
    cdef int n
    self._error=cgnslib.cg_nzones(self._root,B,&n)
    return n
  # ---------------------------------------------------------------------------
  cpdef zone_read(self, int B, int Z):
    """
    Returns a tuple with information about the zone.

    - Args:
     * `B`: base id (`int`)
     * `Z`: zone id (`int`)

    - Return:
     * argument base id (`int`)
     * argument zone id (`int`)     
     * zone name (`string`)
     * zone size (`numpy.ndarray`)

     - Remarks:
     * returned array of zone size is a 1D array, you have to read it taking
     into account the cell and physical dimensions of the parent base,
     see :py:func:`base_read`
   """
    
    cdef char zonename[MAXNAMELENGTH]
    cdef int *zsize
    cdef CNY.ndarray[dtype=CNY.int32_t,ndim=1] azsize
    (bid,bname,cdim,pdim)=self.base_read(B)
    azsize=PNY.ones((cdim*pdim),dtype=PNY.int32)
    zsize=<int *>azsize.data
    self._error=cgnslib.cg_zone_read(self._root,B,Z,zonename,zsize)
    return (B,Z,zonename,azsize)
  # ---------------------------------------------------------------------------
  cpdef zone_type(self, int B, int Z):
    """
    Returns the CGNS type of a zones.

    - Args:
     * `B`: the parent base id (`int`) (:py:func:`bases` and :py:func:`nbases`).
     * `Z`: the parent zone id (`int`) (:py:func:`zones` and :py:func:`nzones`).

    - Return:
     * The ZoneType_t of the zone as an integer (`int`). This is an enumerate value.
    """
    
    cdef cgnslib.ZoneType_t ztype
    ztype=cgnslib.ZoneTypeNull
    self._error=cgnslib.cg_zone_type(self._root,B,Z,&ztype)
    return ztype
  # ---------------------------------------------------------------------------
  cpdef zone_id(self, int B, int Z):
    """
    Returns the zone internal id.

    - Args:
     * `B`: the CGNS/MLL base id (`int`)
     * `Z`: the CGNS/MLL zone id (`int`) (this is **not** the internal id)

    - Return:
     * The zone internal id (`int`)

    - Remarks:
     * This id can be used with the CGNS/ADF or CGNS/HDF5 API. If you don't
     know what this id is... then you should not use it.
    """
    
    cdef double izid
    self._error=cgnslib.cg_zone_id(self._root,B,Z,&izid)
    return izid
  # ---------------------------------------------------------------------------
  cpdef zone_write(self, int B, char *zonename, ozsize,  cgnslib.ZoneType_t ztype):
    """
    Creates a new zone::

      zsize=numpy.array((i,j,k,i-1,j-1,k-1,0,0,0),dtype=numpy.int32)
      zid=db.zone_write(B,'Zone-001',zsize,CGNS.PAT.cgnskeywords.Structured)

    - Args:
     * `B`: parent base id (`int` within :py:func:`nbases` ids)
     * `zonename`: name of the new zone (`string` should not exceed 32 chars)
     * `zsize`: numpy array of `int`
     * `zonetype`: type of the zone `int`

    - Return:
     * New zone id

    - Remarks:
     * No zone size check
     * Zone size can be 1D
     * Zone type is an integer that should be one of the `CGNS.PAT.cgnskeywords.ZoneType_` keys
     * Zone size depends on base dimensions and zone type (see `CGNS/SIDS 6.3 <http://www.grc.nasa.gov/WWW/cgns/CGNS_docs_current/sids/cgnsbase.html#Zone>`_)
    """
    
    cdef CNY.ndarray[dtype=CNY.int32_t,ndim=1] zsize
    cdef int  zid=-1
    cdef int *ptrzs
    zsize=PNY.require(ozsize.flatten(),dtype=PNY.int32)
    ptrzs=<int *>zsize.data
    self._error=cgnslib.cg_zone_write(self._root,B,zonename,ptrzs,ztype,&zid)
    return zid
  # ---------------------------------------------------------------------------    
  cpdef nfamilies(self, int B):
    """
    Returns the number of families in a base::

      for F in range(1,db.nfamilies(B)+1):
         print db.family_read(B)

    - Args:
     * `B`: the parent base id (`int`) (:py:func:`bases` and :py:func:`nbases`).

    - Return:
     * The number of families as an integer (`int`)

    - Remarks:
     * See also :py:func:`families`
    """
    cdef int n
    self._error=cgnslib.cg_nfamilies(self._root,B,&n)
    return n
  # ---------------------------------------------------------------------------
  cpdef families(self, int B):
    """
    Returns all the families indices of a base::

      for F in db.families(B):
         print db.family_read(B)

    - Args:
     * `B`: parent base id (`int`) (:py:func:`bases` and :py:func:`nbases`).

    - Return:
     * An `xrange` from 1 to <number of families> or an empty list if there is
       no family at all.
       
    - Remarks:
     * See also :py:func:`nfamilies`
    """
    cdef int n
    self._error=cgnslib.cg_nfamilies(self._root,B,&n)
    if (n!=0): return xrange(1,n+1)
    return []
  # ---------------------------------------------------------------------------
  cpdef family_read(self, int B, int F):
    """
    Returns a tuple with information about the family.

    - Args:
     * `B`: base id (`int`)
     * `F`: family id (`int`)

    - Return:
     * argument base id (`int`)
     * argument family id (`int`)     
     * family name (`string`)
     * number of `FamilyBC_t` children nodes (`int`)
     * number of `GeometryReference_t` children nodes (`int`)

     - Remarks:
     * returned numbers of children for each `FamilyBC_t`
     and `GeometryReference_t` have to be :py:func:`fambc_read` and
     :py:func:`geo_read`. You have to parse each child a compare with
     some parameter of yours to find the one you are looking for.
    """
    cdef char  family_name[MAXNAMELENGTH]
    cdef int   nboco
    cdef int   ngeo
    self._error=cgnslib.cg_family_read(self._root,B,F,family_name,&nboco,&ngeo)
    return (B,F,family_name,nboco,ngeo)
  # ---------------------------------------------------------------------------
  cpdef family_write(self, int B, char *familyname):
    """
    Creates a new family::

      bid=db.family_write(B,'LeftWing')

    - Args:
     * `B`: the parent base id (`int`) (:py:func:`bases` and :py:func:`nbases`).
     * `familyname`: name of the new family (`string` should not exceed 32 chars)

    - Return:
     * New family id
    """
    cdef int fid
    self._error=cgnslib.cg_family_write(self._root,B,familyname,&fid)
    return fid
  # ---------------------------------------------------------------------------
  cpdef fambc_read(self, int B, int F, int BC):
    """
    Returns a tuple with information about the family BC.

    - Args:
     * `B`: base id (`int`)
     * `F`: family id (`int`)
     * `BC`: BC family id (`int`)

    - Return:
     * argument base id (`int`) 
     * argument family id (`int`)     
     * argument BC family id (`int`)     
     * BC family name (`string`)
     * BC type (`int`)

     - Remarks:
     * The BC type is one of the keys of `CGNS.PAT.cgnskeywords.BCType_`
    """
    cdef char fambc_name[MAXNAMELENGTH]
    cdef cgnslib.BCType_t bocotype
    self._error=cgnslib.cg_fambc_read(self._root,B,F,BC,fambc_name,&bocotype)
    return (B,F,BC,fambc_name,bocotype)
  # ---------------------------------------------------------------------------
  cpdef fambc_write(self, int B, int F,
                    char *fambcname, cgnslib.BCType_t bocotype):
    """
    Creates a new BC family::

      fbcid=db.fambc_write(B,F,CGNS.PAT.cgnskeywords.FamilyBC_s)

    - Args:
     * `B`: parent base id (`int`) (:py:func:`bases` and :py:func:`nbases`).
     * `F`: parent family id (`int`) (:py:func:`families` and :py:func:`nfamilies`).
     * `fambcname`: name of the new BC family (`string` should not exceed 32 chars)
     * `bocotype`: type of the actual BC for all BCs refering to the parent family name of `F`
       (`int`)

    - Return:
     * New BCfamily id (`int`)

    - Remarks:
     * A `BCFamily` takes place as a child of a Family in a Base, once
     created you can create or change some BCs with a type of `FamilySpecified`
     and with a `FamilyName` equals to this `BCFamily` parent Family.
     * a `FamilyBC_t`node name usually is `FamilyBC`
    """
    cdef int fbcid
    self._error=cgnslib.cg_fambc_write(self._root,B,F,fambcname,
                                       bocotype,&fbcid)
    return fbcid
  # ---------------------------------------------------------------------------
  cpdef geo_read(self, int B, int F, int G):
    """
    Returns a tuple with information about the Geometry reference.

    - Args:
     * `B`: base id (`int`)
     * `F`: family id (`int`)
     * `G`: geometry reference id (`int`)

    - Return:
     * argument base id (`int`)
     * argument family id (`int`)     
     * argument geometry reference id (`int`)     
     * geometry reference name (`string`)
     * geometry reference file (`string`)
     * geometry reference CAD name (`string`)
     * geometry reference number of parts (`int`)     

     - Remarks:
     * use :py:func:`family_read` to get the geometry reference id
    """
    cdef char *filename
    cdef int   n
    cdef char  geoname[MAXNAMELENGTH]
    cdef char  cadname[MAXNAMELENGTH]
    self._error=cgnslib.cg_geo_read(self._root,B,F,G,geoname,&filename,
                                    cadname,&n)
    return (B,F,G,geoname,filename,cadname,n)
  # ---------------------------------------------------------------------------
  cpdef geo_write(self, int B, int F, char *geoname, char *filename,
                  char *cadname):
    """
    Creates a new Geometry reference.

    - Args:
     * `B`: parent base id (`int`) (:py:func:`bases` and :py:func:`nbases`).
     * `F`: parent family id (`int`) (:py:func:`families` and :py:func:`nfamilies`).
     * `geoname`: name of the new geometry reference (`string` should not exceed 32 chars)
     * `filename`: path to geometry reference file (`string`)
     * `cadname`: name of the geometry reference CAD (`string`)

    - Return:
     * New Geometry reference id (`int`)

    - Remarks:
     * The cad should be an enumerate as described in SIDS section 12.7
    """
    cdef int gid
    self._error=cgnslib.cg_geo_write(self._root,B,F,geoname,filename,cadname,
                                     &gid)
    return gid
  # ---------------------------------------------------------------------------
  cpdef part_read(self, int B, int F, int G, int P):
    """
    Returns a tuple with information about a Geometry reference part.

    - Args:
     * `B`: base id (`int`)
     * `F`: family id (`int`)
     * `G`: geometry reference id (`int`)
     * `P`: geometry reference part id  (`int`)

    - Return:
     * argument base id (`int`)
     * argument family id (`int`)     
     * argument geometry reference id (`int`)
     * argument geometry reference part id (`int`)     
     * geometry reference part name (`string`)
    """
    cdef char partname[MAXNAMELENGTH]
    self._error=cgnslib.cg_part_read(self._root,B,F,G,P,partname)
    return (B,F,G,P,partname)
  # ---------------------------------------------------------------------------
  cpdef part_write(self, int B, int F, int G, char *partname):
    """
   Creates a new Geometry reference part.

    - Args:
     * `B`: parent base id (`int`) (:py:func:`bases` and :py:func:`nbases`).
     * `F`: parent family id (`int`) (:py:func:`families` and :py:func:`nfamilies`).
     * `G`: geometry reference id (`int`)
     * `partname`: name of the new geometry reference part (`string`)
       (`string` should not exceed 32 chars)

    - Return:
     * New Geometry reference part id
    """
    cdef int pid
    self._error=cgnslib.cg_part_write(self._root,B,F,G,partname,&pid)
    return pid
  # ---------------------------------------------------------------------------
  cpdef ngrids(self, int B, int Z):
    """
    Returns the number of grids in a zone::

      for G in range(1,db.ngrids(B,Z)+1):
         print db.grid_read(B,Z,G)

    - Args:
     * `B`: parent base id (`int`) (:py:func:`bases` and :py:func:`nbases`).
     * `Z`: parent zone id (`int`) (:py:func:`zones` and :py:func:`nzones`).

    - Return:
     * The number of grids as an integer (`int`)

    - Remarks:
     * See also :py:func:`grids`
    """
    cdef int n
    self._error=cgnslib.cg_ngrids(self._root,B,Z,&n)
    return n
  # ---------------------------------------------------------------------------
  cpdef grids(self, int B, int Z):
    """
    Returns the number of grids indices of a zone::

      for G in db.grids(B,Z):
         print db.grid_read(B,Z,G)

    - Args:
     * `B`: parent base id (`int`) (:py:func:`bases` and :py:func:`nbases`).
     * `Z`: parent zone id (`int`) (:py:func:`zones` and :py:func:`nzones`).

    - Return:
     * An `xrange` from 1 to <number of grids> or an empty list if there is
       no grid at all.

    - Remarks:
     * See also :py:func:`ngrids`
    """
    cdef int n
    self._error=cgnslib.cg_ngrids(self._root,B,Z,&n)
    if (n!=0): return xrange(1,n+1)
    return []
  # ---------------------------------------------------------------------------
  cpdef grid_read(self, int B, int Z, int G):
    """
    Returns a tuple with information about the grid.

    - Args:
     * `B`: base id (`int`)
     * `Z`: zone id (`int`)
     * `G`: grid id (`int`)

    - Return:
     * argument base id (`int`)
     * argument zone id (`int`)     
     * argument grid id (`int`)     
     * grid name (`string`)
    """
    cdef char gridname[MAXNAMELENGTH]
    self._error=cgnslib.cg_grid_read(self._root,B,Z,G,gridname)
    return (B,Z,G,gridname)
  # ---------------------------------------------------------------------------
  cpdef grid_write(self, int B, int Z, char *gridname):
    """
    Creates a new grid.

    - Args:
     * `B`: base id (`int`)
     * `Z`: zone id (`int`)
     * `gridname`: name of the new grid (`string` should not exceed 32 chars) (`string`)

    - Return:
     * grid id (`int`)

    - Remarks:
     * The `GridCoordinates` name is reserved for the default grid name.
     You should have one `GridCoordinates` grid per zone if your zone is not
     empty. See also :py:func:`coord_write` which creates `GridCoordinates`
     or uses it if present.
    """
    cdef int gid
    self._error=cgnslib.cg_grid_write(self._root,B,Z,gridname,&gid)
    return gid
  # ---------------------------------------------------------------------------
  cpdef ncoords(self, int B, int Z):
    """
    Returns the number of coordinates array in the GridCoordinates node.

    - Args:
     * `B`: parent base id (`int`)
     * `Z`: parent zone id (`int`)

    - Return:
     * The number of coordinates arrays as an integer (`int`)

    - Remarks:
     * See also :py:func:`coords`
    """
    cdef int n
    self._error=cgnslib.cg_ncoords(self._root,B,Z,&n)
    return n
  # ---------------------------------------------------------------------------
  cpdef coords(self, int B, int Z):
    """
    Returns the number of coordinates array indices of a zone.

    - Args:
     * `B`: parent base id (`int`)
     * `Z`: parent zone id (`int`)

    - Return:
     * An `xrange` from 1 to <number of nodes> or an empty list if there is
       no coordinates at all.

    - Remarks:
     * See also :py:func:`ncoords`
    """
    cdef int n
    self._error=cgnslib.cg_ncoords(self._root,B,Z,&n)
    if (n!=0): return xrange(1,n+1)
    return []
  # ---------------------------------------------------------------------------
  cpdef coord_info(self, int B, int Z, int C):
    """
    Returns a tuple with information about the coordinates.

    - Args:
     * `B`: base id (`int`)
     * `Z`: zone id (`int`)
     * `C`: coordinates id (`int`) (:py:func:`coords` and :py:func:`ncoords`)

    - Return:
     * argument base id (`int`)
     * argument zone id (`int`)     
     * argument coordinates id (`int`)
     * coordinates array data type (`int`)
     * coordinate name (`string`)

    - Remarks:
     * With a X,Y,Z coordinate system, you should look for X (one coordinate
     id), X (another coordinate id) and Z (another coordinate id). That makes
     three calls of `coord_info`.
     * The coordinate array datatype is from `CGNS.PAT.cgnskeywords.DataType_`
    """
    cdef cgnslib.DataType_t dtype
    cdef char coordname[MAXNAMELENGTH]
    self._error=cgnslib.cg_coord_info(self._root, B, Z, C,&dtype,coordname)
    return (B,Z,C,dtype,coordname)
  # ---------------------------------------------------------------------------
  cpdef coord_read(self, int B, int Z,
                   char *coordname, cgnslib.DataType_t dtype):
    """
    Returns a tuple with actual coordinates array.

    - Args:
     * `B`: base id (`int`)
     * `Z`: zone id (`int`)
     * `coordname`: coordinate array name to read (`string`)
     * `dtype`: datatype of the array (`int`)

    - Return:
     * argument base id (`int`)
     * argument zone id (`int`)     
     * argument coordinates name (`string`)
     * argument coordinates array data type (`int`)
     * min indices (`numpy.ndarray`)
     * max indices (`numpy.ndarray`)
     * coordinates (`numpy.ndarray`)

    - Remarks:
     * The datatype forces a cast if it is not the original type of the array
     * The coordinate array datatype is from `CGNS.PAT.cgnskeywords.DataType_`
     * The dtype can be a numpy dtype as far as it can be translated
    """
    (bid,bname,cdim,pdim)=self.base_read(B)
    (bid,zid,zname,zsize)=self.zone_read(B,Z)
    rmin=PNY.ones((cdim),dtype=PNY.int32)
    rmax=PNY.ones((cdim),dtype=PNY.int32)
    rminptr=<int *>CNY.PyArray_DATA(rmin)
    rmaxptr=<int *>CNY.PyArray_DATA(rmax)
    cdtype=asnumpydtype(dtype)
    if (cdtype == None):
        ndtype=fromnumpydtype(dtype)
        if (ndtype == None):
            raise CGNSException(10,"No such data type: %s"%str(ndtype))
        dtype=ndtype
        cdtype=asnumpydtype(dtype)
    coords=PNY.ones(zsize,dtype=cdtype)
    coordsptr=<void *>CNY.PyArray_DATA(coords)
    self._error=cgnslib.cg_coord_read(self._root, B, Z,
                                      coordname,dtype,
                                      rminptr,rmaxptr,coordsptr)
    return (B,Z,coordname,dtype,rmin,rmax,coords)
  # ---------------------------------------------------------------------------
  cpdef coord_id(self, int B, int Z, int C):
    """
    Returns the base internal id.

    - Args:
     * `B`: the CGNS/MLL base id (`int`)
     * `Z`: the CGNS/MLL zone id (`int`)
     * `C`: the CGNS/MLL coordinates id (`int`)

    - Return:
     * The coordinates internal id (`int`)

    - Remarks:
     * This id can be used with the CGNS/ADF or CGNS/HDF5 API. If you don't
     know what this id is... then you should not use it.
    """
    cdef double icid
    self._error=cgnslib.cg_coord_id(self._root,B,Z,C,&icid)
    return icid
  # ---------------------------------------------------------------------------
  cpdef coord_write(self, int B, int Z, cgnslib.DataType_t dtype,
                   char *coordname, coords):
    """
    Creates a new coordinates.

    - Args:
     * `B`: base id (`int`)
     * `Z`: zone id (`int`)
     * `dtype`: data type of the array contents (`int`)
     * `coordname`: name of the new coordinates (`string` should not exceed 32 chars)
     * `coords`: array of actual coordinates (`numpy.ndarray`)
     
    - Return:
     * coordinate array id (`int`)

    - Remarks:
     * Creates by default the `GridCoordinates` node
     * the coords array is a `numpy` with correct data type with respect
     to the `CGNS.PAT.cgnskeywords.DataType_` argument.
     * The dtype can be a numpy dtype as far as it can be translated
    """
    cdef int cid
    cdtype=asnumpydtype(dtype)
    if (cdtype == None):
        ndtype=fromnumpydtype(dtype)
        if (ndtype == None):
            raise CGNSException(10,"No such data type: %s"%str(ndtype))
        dtype=ndtype
    coordsptr=<void *>CNY.PyArray_DATA(coords)
    self._error=cgnslib.cg_coord_write(self._root, B, Z,
                                       dtype, coordname,coordsptr,&cid)
    return cid
  # ---------------------------------------------------------------------------
  cpdef coord_partial_write(self, int B, int Z, cgnslib.DataType_t dtype,
                            char *coordname, rmin, rmax, coords):
    """
    Modify coordinates.

    - Args:
     * `B`: base id (`int`)
     * `Z`: zone id (`int`)
     * `dtype`: data type of the array contents (`int`)
     * `coordname`: name of the new coordinates (`string` should not exceed 32 chars)
     * `rmin`: min range of data to write  (`numpy.ndarray`)
     * `rmax`: max range of data to write  (`numpy.ndarray`)
     * `coords`: array of actual coordinates (`numpy.ndarray`)
     
    - Return:
     * Creates by default the `GridCoordinates` node
     * the coords array is a `numpy` with correct data type with respect
     to the `CGNS.PAT.cgnskeywords.DataType_` argument.
    """
    cdef int cid
    rminptr=<int *>CNY.PyArray_DATA(rmin)
    rmaxptr=<int *>CNY.PyArray_DATA(rmax)
    coordsptr=<float *>CNY.PyArray_DATA(coords)
    cdtype=asnumpydtype(dtype)
    if (cdtype == None):
        ndtype=fromnumpydtype(dtype)
        if (ndtype == None):
            raise CGNSException(10,"No such data type: %s"%str(ndtype))
        dtype=ndtype
    self._error=cgnslib.cg_coord_partial_write(self._root, B, Z, dtype,
                                               coordname, rminptr, rmaxptr, 
                                               coordsptr,&cid)
    return cid
  # ------------------------------------------------------------
  cpdef nsols(self, int B, int Z):
    """
    Returns the number of flow solutions.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)

    - Return:
    *  number of flow solutions for zone `Z`(`int`)
    
    """
    
    cdef int ns=0
    self._error=cgnslib.cg_nsols(self._root,B,Z,&ns)
    return ns

  # ------------------------------------------------------------
  cpdef sol_write(self, int B, int Z, char * solname,
                  cgnslib.GridLocation_t location ):
    """
    Creates a new flow solution node.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `solname` : name of the flow solution (`string`)
    * `location` : grid location where the solution is recorded (`int`)
      The admissible locations are Vertex, CellCenter, IFaceCenter, JFaceCenter
      and KFaceCenter.

    - Return:
    * flow solution id (`int`) 

    """
    
    cdef int S=-1
    self._error=cgnslib.cg_sol_write(self._root,B,Z,solname,location,&S)
    return S

  # --------------------------------------------------------------
  cpdef sol_info(self,int B, int Z, int S):
    """
    Returns a tuple with contains the name of the flow solution and
    the grid location of the solution.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `S` : flow solution id which  is comprised between 1 and the total number
      of flow solutions (`int`)

    - Return:
    * name of the flow solution (`string`)
    * grid location of the solution (`int`)
    
    """
    
    cdef char * solname = " "
    cdef cgnslib.GridLocation_t location
    self._error=cgnslib.cg_sol_info(self._root,B,Z,S,solname,&location)
    return (solname,location)    

  # ---------------------------------------------------------------
  cpdef sol_id(self,int B, int Z, int S):
    cdef double sid
    self._error=cgnslib.cg_sol_id(self._root,B, Z, S, &sid)
    return sid

  # ----------------------------------------------------------------
  cpdef sol_size(self, int B, int Z, int S):
    """
    Returns a tuple with information about the flow solution
    data.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `S` : flow solution id (`int`)

    - Return:
    * number of dimensions defining the solution data (`int`)
      If a point set has been defined, this will be 1, otherwise this will be
      the current zone index dimension
    * array of data_dim dimensions for the solution data (`numpy.ndarray`)
    
    """
    
    cdef int data_dim
    dim_vals=PNY.ones((CK.ADF_MAX_DIMENSIONS,),dtype=PNY.int32)
    dim_valsptr=<int *>CNY.PyArray_DATA(dim_vals)
    self._error=cgnslib.cg_sol_size(self._root,B,Z,S,&data_dim,dim_valsptr)
    return (data_dim,dim_vals[0:data_dim])

  # ----------------------------------------------------------------
  cpdef nsections(self, int B, int Z):
    """
    Returns the number of element sections.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)

    - Return:
    * number of element sections (`int`)

    """
    
    cdef int nsections
    self._error=cgnslib.cg_nsections(self._root,B,Z,&nsections)
    return nsections

  # -----------------------------------------------------------------
  cpdef section_read(self, int B, int Z, int S):
    """
    Returns a tuple with information about the element section
    data.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `S` : element section id (`int`)

    - Return:
    * name of the `Elements_t` node (`string`)
    * type of element (`int`)
    * index of first element in the section (`int`)
    * index of last element in the section (`int`)
    * index of last boundary element in the section (`int`)
      If the elements are unsorted, this index is set to 0.
    * flag indicating if the parent data are defined (`int`)
      If the parent data exist, `parent_flag` is set to 1; otherwise it is set to 0.

    """
    
    cdef char * SectionName
    SectionName=' '
    cdef cgnslib.ElementType_t Element_type
    cdef cgnslib.cgsize_t start
    cdef cgnslib.cgsize_t end
    cdef int nbndry
    cdef int parent_flag
    self._error=cgnslib.cg_section_read(self._root,B,Z,S,SectionName,&Element_type,
                                        &start,&end,&nbndry,&parent_flag)
    return (SectionName,Element_type,start,end,nbndry,parent_flag)

  # ---------------------------------------------------------------------
  cpdef npe(self, cgnslib.ElementType_t type):
    """
    Returns the number of nodes of an element.

    - Args:
    * `type` : type of element (`int`)

    - Return:
    * number of nodes for an element of type `type` (`int`)
    
    """
    cpdef int npe
    self._error=cgnslib.cg_npe(type,&npe)
    return npe

  # ----------------------------------------------------------------------
  cpdef ElementDataSize(self, int B, int Z, int S):
    """
    Returns the number of element connectivity data values.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `S` : element section id (`int`)

    - Return:
    * number of element connectivity data values (`int`)
    
    """
    cdef cgnslib.cgsize_t ElementDataSize
    self._error=cgnslib.cg_ElementDataSize(self._root,B,Z,S,&ElementDataSize)
    return ElementDataSize

    # ---------------------------------------------------------------------
  cpdef ElementPartialSize(self, int B, int Z, int S, cgnslib.cgsize_t start,
                           cgnslib.cgsize_t end):
    """
    Returns the number of element connectivity data values in a range.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `S` : element section id (`int`)
    * `start` : min range of element connectivity data to read (`int`)
    * `end`: max range of element connectivity data to read (`int`)

    - Return:
    * number of element connectivity data values contained in the wanted range (`int`)
    
    """
    cdef cgnslib.cgsize_t ElementDataSize
    self._error=cgnslib.cg_ElementPartialSize(self._root,B,Z,S,start,end,&ElementDataSize)
    return ElementDataSize

  # -------------------------------------------------------------------------
  cpdef elements_read(self, int B, int Z, int S):
    """
    Returns a tuple with the element connectivity data and the parent data.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `S` : element section id (`int`)

    - Return:
    * element connectivity data (`numpy.ndarray`)
    * For boundary of interface elements, the `ParentData` array contains information on the
    cells and cell faces sharing the element. (`numpy.ndarray`)
    
    """
    data_size=self.ElementDataSize(B,Z,S)
    elements=PNY.ones((data_size),dtype=PNY.int32)
    parent_data=PNY.ones((data_size),dtype=PNY.int32)
    elementsptr=<int *>CNY.PyArray_DATA(elements)
    parent_dataptr=<int *>CNY.PyArray_DATA(parent_data)
    self._error=cgnslib.cg_elements_read(self._root,B,Z,S,elementsptr,parent_dataptr)
    return (elements,parent_data)
  
  # ---------------------------------------------------------------------
  cpdef elements_partial_read(self,int B,int Z, int S, cgnslib.cgsize_t start,
                              cgnslib.cgsize_t end):
    """
    Returns a tuple with the element connectivity data and the parent data
    for a given range.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `S` : element section id (`int`)
    * `start` : min range of element connectivity data to read (`int`)
    * `end`: max range of element connectivity data to read (`int`)
    

    - Return:
    * element connectivity data (`numpy.ndarray`)
    * For boundary of interface elements, the `ParentData` array contains information on the
    cells and cell faces sharing the element. (`numpy.ndarray`)
    
    """
    
    elt=self.section_read(B,Z,S)[1]
    elt_type=self.npe(elt)
    size=(end-start+1)*elt_type
    elements=PNY.ones((size),dtype=PNY.int32)
    parent_data=PNY.ones((size),dtype=PNY.int32)
    elementsptr=<int *>CNY.PyArray_DATA(elements)
    parent_dataptr=<int *>CNY.PyArray_DATA(parent_data)
    self._error=cgnslib.cg_elements_partial_read(self._root,B,Z,S,start,end,elementsptr,parent_dataptr)
    return (elements,parent_data)

  # --------------------------------------------------------------------------  
  cpdef section_write(self,int B, int Z, char * SectionName, cgnslib.ElementType_t type,
                      cgnslib.cgsize_t start, cgnslib.cgsize_t end, int nbndry,
                      elements):

    """
    Creates a new element section.
    

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `SectionName` : name of the element section (`string`)
    * `type` : type of element (`int`)
    * `start` : min range of element connectivity data to write (`int`)
    * `end`: max range of element connectivity data to write (`int`)
    * `nbndry` : index of last boundary element (`int`)
      If the elements are unsorted, this index is set to 0.
    * `elements` : element connectivity data (`numpy.ndarray`)
    

    - Return:
    * element section id (`int`) 
    
    """
    cdef int S=-1
    elements=PNY.int32(elements)
    elementsptr=<int *>CNY.PyArray_DATA(elements)
    self._error=cgnslib.cg_section_write(self._root,B,Z,SectionName,type,start,end,
                                         nbndry,elementsptr,&S)
    return S

  # ---------------------------------------------------------------------------
  cpdef parent_data_write(self, int B, int Z, int S, parent_data):
    
    """
    Writes parent info for an element section.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `S` : element section id which is comprised between 1 and the total number
      of element sections(`int`)
    * `parent_data` : For boundary of interface elements, the `ParentData` array contains
    information on the cells and cell faces sharing the element. (`numpy.ndarray`)
    
    """
    parent_data=PNY.int32(parent_data)
    parent_dataptr=<int *>CNY.PyArray_DATA(parent_data)
    self._error=cgnslib.cg_parent_data_write(self._root,B,Z,S,parent_dataptr)

  # ----------------------------------------------------------------------------
  cpdef section_partial_write(self, int B, int Z, char * SectionName,
                              cgnslib.ElementType_t type, cgnslib.cgsize_t start,
                              cgnslib.cgsize_t end, int nbndry):

    """
    Writes subset of element data.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `SectionName` : name of the element section (`string`)
    * `type` : type of element (`int`)
    * `start` : index of first element in the section to write (`int`)
    * `end` : index of last element in the section to write (`int`)
    * `nbndry` : index of last boundary element in the section (`int`)
      If the elements are unsorted, this index is set to 0.
    
    - Return:
    * element section index
    
    """
    cdef int S=-1
    self._error=cgnslib.cg_section_partial_write(self._root,B,Z,SectionName,type,
                                                 start,end,nbndry,&S)
    return S

  # -----------------------------------------------------------------------------
  cpdef elements_partial_write(self, int B, int Z, int S, cgnslib.cgsize_t start,
                              cgnslib.cgsize_t end, elements):

    """
    Writes element data for an element section.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `S` : element section id (`int`)
    * `start` : index of first element in the section to write (`int`)
    * `end` : index of last element in the section to write (`int`)
    * `elements` : element conncetivity data (`numpy.ndarray`)

    """
    
    elements=PNY.int32(elements)
    elementsptr=<int *>CNY.PyArray_DATA(elements)
    self._error=cgnslib.cg_elements_partial_write(self._root,B,Z,S,start,end,
                                                  elementsptr)

  # ------------------------------------------------------------------------------
  cpdef parent_data_partial_write(self, int B, int Z, int S, cgnslib.cgsize_t start,
                                  cgnslib.cgsize_t end, parent_data):

    """
    Writes subset of parent info for an element section.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `S` : element section index number (`int`)
    * `start` : index of first element in the section (`int`) 
    * `end` : index of last element in the section (`int`)   
    * `parent_data` : For boundary of interface elements, the `ParentData` array contains
       information on the cells and cell faces sharing the element. (`numpy.ndarray`)

    - Return:
    * None
    
    """
    parent_data=PNY.int32(parent_data)
    parent_dataptr=<int *>CNY.PyArray_DATA(parent_data)
    self._error=cgnslib.cg_parent_data_partial_write(self._root,B,Z,S,start,end,
                                                     parent_dataptr)

  # ------------------------------------------------------------------------------
  cpdef nbocos(self, int B, int Z):

      """
      Gets number of boundary conditions.
      
      - Args:
      * `B` : base id (`int`)
      * `Z` : zone id (`int`)

      - Return:
      * number of boundary conditions in zone `Z` (`int`)

      """
      
      cdef int nbbdcd
      self._error=cgnslib.cg_nbocos(self._root,B,Z,&nbbdcd)
      return nbbdcd

  # -----------------------------------------------------------------------------------
  cpdef boco_info(self, int B, int Z, int BC):

    """
    Gets info from a given boundary condition. Returns info in a tuple.

    - Args:
    * `B` : base id (`int`)(`numpy.ndarray`)
    * `Z` : zone id (`int`)
    * `BC`: boundary condition id (`int`)

    - Return:
    * name of the boundary condition (`string`)
    * type of boundary condition defined (`int`)
    * extent of the boundary condition (`int`). The extent may be defined using a range of
      points or elements using `PointRange`using, or using a discrete list of all points or
      elements at which the boundary condition is applied using `PointList`.
    * number of points or elements defining the boundary condition region (`int`)
      For a `ptset_type` of `PointRange`, the number is always 2. For a `ptset_type` of `PointList`,
      the number is equal to the number of points or elements in the list.
    * index vector indicating the computational coordinate direction of the boundary condition
      patch normal (`numpy.ndarray`)
    * flag indicating if the normals are defined in `NormalList`(`int`)
      Returns 1 if they are defined, 0 if they are not.
    * data type used in the definition of the normals (`int`)
      Admissible data types are `RealSingle` and `RealDouble`.
    * number of boundary condition datasets for the current boundary condition (`int`)
      

    """
    
    
    cdef char * boconame= " "
    cdef cgnslib.BCType_t bocotype
    cdef cgnslib.PointSetType_t ptset_type
    cdef cgnslib.cgsize_t npnts
    NormalIndex=PNY.zeros((3,),dtype=PNY.int32)
    NormalIndexptr=<int *>CNY.PyArray_DATA(NormalIndex)
    cdef cgnslib.cgsize_t NormalListFlag
    cdef cgnslib.DataType_t NormalDataType
    cdef int ndataset
    self._error=cgnslib.cg_boco_info(self._root,B,Z,BC,boconame,&bocotype,&ptset_type,
                                     &npnts,NormalIndexptr,&NormalListFlag,&NormalDataType,
                                     &ndataset)
    return (boconame,bocotype,ptset_type,npnts,NormalIndex,NormalListFlag,NormalDataType,
                                     ndataset)

  # ----------------------------------------------------------------------------------
  cpdef boco_id(self, int B, int Z, int BC):
    cdef double boco_id
    self._error=cgnslib.cg_boco_id(self._root,B,Z,BC,&boco_id)
    return boco_id

  # ----------------------------------------------------------------------------------
  cpdef boco_write(self, int B, int Z, char * boconame, cgnslib.BCType_t bocotype,
                   cgnslib.PointSetType_t ptset_type, cgnslib.cgsize_t npnts, pnts):

    """
    Creates a new boundary condition.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `boconame` : name of the boundary condition (`string`)
    * `bocotype` : type of the boundary condition (`int`)
    * `ptset_type : extent of the boundary condition (`int`)
    * `npnts` : number of points or elements defining the boundary condition region (`int`)
    * `pnts` : array of point or element indices defining the boundary condition region
      (`numpy.ndarray`)

    - Return:
    * boundary condition id (`int`)

    """

    cdef int BC=-1
    array=PNY.int32(pnts)
    arrayptr=<int *>CNY.PyArray_DATA(array)
    self._error=cgnslib.cg_boco_write(self._root,B,Z,boconame,bocotype,ptset_type,npnts,arrayptr,
                                      &BC)
    return BC

  # --------------------------------------------------------------------------------------
  cpdef boco_normal_write(self, int B, int Z, int BC, NormalIndex,
                          int NormalListFlag, NormalDataType=None, NormalList=None):

    """
    Writes the normals of a given `BC` boundary condition.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `BC`: boundary condition id (`int`)
    * `NormalIndex`:index vector indicating the computational coordinate direction of the
      boundary condition patch normal (`numpy.ndarray`)
    * `NormalListFlag`: flag indicating if the normals are defined in `NormalList`(`int`) .
      The flag is equal to 1 if they are defined, 0 if they are not. If the flag is forced to 0,
      'NormalDataType' and 'NormalList' are not taken into account. In this case, these arguments
      are not required.
    * `NormalDataType`: data type used in the definition of the normals (`int`).
      Admissible data types are `RealSingle` and `RealDouble`. 
    * `NormalList`: list of vectors normal to the boundary condition patch pointing into the
      interior of the zone (`numpy.ndarray`)

    - Returns:
    * None
    
    """
    nix=PNY.int32(NormalIndex)
    nixptr=<int *>CNY.PyArray_DATA(NormalIndex)
    if (NormalListFlag==1):
      ndt=<cgnslib.DataType_t>NormalDataType
      if (ndt==CK.RealDouble):
        nl=PNY.float64(NormalList)
        nlptrD=<double *>CNY.PyArray_DATA(nl)
        self._error=cgnslib.cg_boco_normal_write(self._root,B,Z,BC,nixptr,
                                                 NormalListFlag,ndt,nlptrD)
      else:
        nl=PNY.float32(NormalList)
        nlptrS=<float *>CNY.PyArray_DATA(nl)
        self._error=cgnslib.cg_boco_normal_write(self._root,B,Z,BC,nixptr,
                                                 NormalListFlag,ndt,nlptrS)
    else:
      nl=PNY.ones((1,))
      nlptrS=<float *>CNY.PyArray_DATA(nl)
      NormalDataType=3
      ndt=<cgnslib.DataType_t>NormalDataType
      self._error=cgnslib.cg_boco_normal_write(self._root,B,Z,BC,nixptr,
                                                 NormalListFlag,ndt,nlptrS)

  # ----------------------------------------------------------------------------------
  cpdef boco_read(self, int B, int Z, int BC):

    """
    Reads boundary condition data and normals.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `BC`: boundary condition id (`int`)

    - Returns:
    * array of point or element indices defining the boundary condition region (`numpy.ndarray`)
    * list of vectors normal to the boundary condition patch pointing into the interior
      of the zone (`numpy.ndarray`)
    
    """
    cdef int NormalList
    cdef double * nlptrD
    cdef float * nlptrS
    npnts=self.boco_info(B,Z,BC)[3]
    nls=self.boco_info(B,Z,BC)[5]
    datatype=self.boco_info(B,Z,BC)[6]
    ztype=self.zone_type(B,Z)
    pdim=self.base_read(B)[3]
    if (ztype==CK.Unstructured):
      dim=1
    elif (ztype==CK.Structured):
      dim=self.base_read(B)[2]  
    pnts=PNY.zeros((npnts,dim),dtype=PNY.int32)
    pntsptr=<int *>CNY.PyArray_DATA(pnts)
    if (nls==0):
      nl=PNY.zeros((3,))
    else:
      if (datatype==CK.RealDouble):
        nl=PNY.ones((nls/pdim,pdim),dtype=PNY.float64)
        nlptrD=<double *>CNY.PyArray_DATA(nl)
        self._error=cgnslib.cg_boco_read(self._root,B,Z,BC,pntsptr,nlptrD)
      else:
        nl=PNY.ones((nls/pdim,pdim),dtype=PNY.float32)
        nlptrS=<float *>CNY.PyArray_DATA(nl)
        self._error=cgnslib.cg_boco_read(self._root,B,Z,BC,pntsptr,nlptrS)
    return (pnts,nl)

  # ------------------------------------------------------------------------------------
  cpdef boco_gridlocation_read(self, int B, int Z, int BC):

    """
    Returns the location of a given boundary condition.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `BC`: boundary condition id (`int`)

    - Return:
    * grid location used in the definition of the point set (`int`)

    """
    
    cdef cgnslib.GridLocation_t location
    self._error=cgnslib.cg_boco_gridlocation_read(self._root,B,Z,BC,&location)
    return location

  # ------------------------------------------------------------------------------------
  cpdef boco_gridlocation_write(self, int B, int Z, int BC,
                                cgnslib.GridLocation_t location):

    """
    Writes the boundary condition location.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `BC`: boundary condition id (`int`)
    * `location` : grid location used in the definition of the point set (`int`)

    - Return:
    * None

    """
    
    self._error=cgnslib.cg_boco_gridlocation_write(self._root,B,Z,BC,location)

  # ------------------------------------------------------------------------------------
  cpdef dataset_write(self, int B, int Z, int BC, char * name, cgnslib.BCType_t BCType):

    """
    Writes the dataset set of a given boundary condition.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `BC`: boundary condition id (`int`)
    * `BCType` : boundary condition type (`int`)

    - Return:
    * dataset id (`int`)    

    """
    
    cdef int DSet=-1
    self._error=cgnslib.cg_dataset_write(self._root,B,Z,BC,name,BCType,&DSet)
    return DSet

  # ------------------------------------------------------------------------------------
  cpdef dataset_read(self, int B, int Z, int BC, int DS):

    """
    Returns a tuple with information about a boundary condition dataset.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `BC`: boundary condition id (`int`)
    * dataset id (`int`)

    - Return:
    * name of the dataset (`string`)
    * boundary condition type (`int`)
    * flag indicating if the dataset contains Dirichlet data (`int`)
    * flag indicating if the dataset contains Neumann data (`int`)

    """
    
    cdef char * name = ""
    cdef cgnslib.BCType_t bct
    cdef int dflag = 0
    cdef int nflag = 0
    self._error=cgnslib.cg_dataset_read(self._root,B,Z,BC,DS,name,&bct,&dflag,&nflag)
    return (name,bct,dflag,nflag)

  # --------------------------------------------------------------------------------------
  cpdef narrays(self):

    """
    Returns the number of data arrays under the current node. You can access a node via a
    pathname by using the `gopath` function.

    - Args:
    * None

    - Returns:
    * number of data arrays contained in a given node (`int`)
    
    """
    cdef int narrays = -1
    self._error=cgnslib.cg_narrays(&narrays)
    return narrays
  # --------------------------------------------------------------------------------------
  cpdef array_info(self, int A):

    """
    Returns a tuple with information about a given array. You need to access the parent
    node of the requested array. You can use the `gopath` function to do it.

    - Args:
    * `A` : data array id which is necessarily comprised between 1 and the number of arrays
      under the current node (`int`)

    - Return:
    * name of the data array (`string`)
    * type of data held in the `DataArray_t` node (`int`)
    * number of dimensions (`int`)
    * number of data elements in each dimension (`int`)
    
    """
    cdef char * aname = " "
    cdef cgnslib.DataType_t dt
    cdef int dd = -1
    cdef cgnslib.cgsize_t * dvptr
    dv = PNY.ones((CK.ADF_MAX_DIMENSIONS,),dtype=PNY.int32)
    dvptr = <cgnslib.cgsize_t *>CNY.PyArray_DATA(dv)
    self._error=cgnslib.cg_array_info(A,aname,&dt,&dd,dvptr)
    return (aname,dt,dd,dv[0:dd])

 # ---------------------------------------------------------------------------------------
  cpdef array_read(self, int A):

    """
    Reads a data array contained in a given node. You can set the current node by using the
    `gopath` function.

    - Args:
    * `A` : data array id which is comprised between 1 and the number of arrays
      under the current node (`int`)

    - Return:
    * data array (`numpy.ndarray`)

    """
    
    cdef int * dataptrI
    cdef float * dataptrF
    cdef double * dataptrD
    cdef char * dataptrC
    
    dt=self.array_info(A)[1]
    dv=self.array_info(A)[3]
    
    if (dt==CK.Integer):
      data=PNY.ones(dv,dtype=PNY.int32)
      dataptrI=<int *>CNY.PyArray_DATA(data)
      self._error=cgnslib.cg_array_read(A,dataptrI)
    if (dt==CK.LongInteger):
      data=PNY.ones(dv,dtype=PNY.int64)
      dataptrI=<int *>CNY.PyArray_DATA(data)
      self._error=cgnslib.cg_array_read(A,dataptrI)
    if (dt==CK.RealSingle):
      data=PNY.ones(dv,dtype=PNY.float32)
      dataptrF=<float *>CNY.PyArray_DATA(data)
      self._error=cgnslib.cg_array_read(A,dataptrF)
    if (dt==CK.RealDouble):
      data=PNY.ones(dv,dtype=PNY.float64)
      dataptrD=<double *>CNY.PyArray_DATA(data)
      self._error=cgnslib.cg_array_read(A,dataptrD)
    if (dt==CK.Character):
      data=PNY.array((""))
      dataptrC=<char *>CNY.PyArray_DATA(data)
      self._error=cgnslib.cg_array_read(A,dataptrC)

    return data
  
  # -----------------------------------------------------------------------------------------
  cpdef array_read_as(self, int A, cgnslib.DataType_t type):

    """
    Reads a data array as a certain type. You can set the node which contains the requested array
    by using the `gopath` function.

    - Args:
    * `A` : data array id which is comprised between 1 and the number of arrays
      under the current node (`int`)
    * `type` : requested type of data held in the array (`int`)

    - Return:
    * data array (`numpy.ndarray`)

    - Remarks:
    * The data array is returned only if its data type corresponds to the required data type.
      Otherwise, nothing is returned.

    """

    cdef int * dataptrI
    cdef float * dataptrF
    cdef double * dataptrD
    cdef char * dataptrC
    
    dv=self.array_info(A)[3]

    if (type==CK.Integer):
      data=PNY.ones(dv,dtype=PNY.int32)
      dataptrI=<int *>CNY.PyArray_DATA(data)
      self._error=cgnslib.cg_array_read_as(A,type,dataptrI)
    if (type==CK.LongInteger):
      data=PNY.ones(dv,dtype=PNY.int64)
      dataptrI=<int *>CNY.PyArray_DATA(data)
      self._error=cgnslib.cg_array_read_as(A,type,dataptrI)
    if (type==CK.RealSingle):
      data=PNY.ones(dv,dtype=PNY.float32)
      dataptrF=<float *>CNY.PyArray_DATA(data)
      self._error=cgnslib.cg_array_read_as(A,type,dataptrF)
    if (type==CK.RealDouble):
      data=PNY.ones(dv,dtype=PNY.float64)
      dataptrD=<double *>CNY.PyArray_DATA(data)
      self._error=cgnslib.cg_array_read_as(A,type,dataptrD)
    if (type==CK.Character):
      data=PNY.array((""))
      dataptrC=<char *>CNY.PyArray_DATA(data)
      self._error=cgnslib.cg_array_read_as(A,type,dataptrC)

    return data
              
  # -----------------------------------------------------------------------------------------
  cpdef array_write(self, char * aname, cgnslib.DataType_t dt, int dd,
                    dimv, adata):
    """
    Creates a new data array.

    - Args:
    * `aname` : name of the data array (`string`)
    * `dt` : type of data held in the array (`int`)
    * `dd` : number of dimensions of the data array (`int`)
    * `dimv` : number of data elements in each dimension (`numpy.ndarray`)
    * `adata` : data array ('numpy.ndarray`)

    - Return:
    * None

    """

    cdef int * dataptrI
    cdef float * dataptrF
    cdef double * dataptrD
    cdef char * dataptrC
    cdef cgnslib.cgsize_t * dv

    div=PNY.int32(dimv)
    dv=<cgnslib.cgsize_t *>CNY.PyArray_DATA(div)
        
    if (dt==CK.Integer):
      data=PNY.int32(adata)
      dataptrI=<int *>CNY.PyArray_DATA(data)
      self._error=cgnslib.cg_array_write(aname,dt,dd,dv,dataptrI)
    if (dt==CK.LongInteger):
      data=PNY.int64(adata)
      dataptrI=<int *>CNY.PyArray_DATA(data)
      self._error=cgnslib.cg_array_write(aname,dt,dd,dv,dataptrI)
    if (dt==CK.RealSingle):
      data=PNY.float32(adata)
      dataptrF=<float *>CNY.PyArray_DATA(data)
      self._error=cgnslib.cg_array_write(aname,dt,dd,dv,dataptrF)
    if (dt==CK.RealDouble):
      data=PNY.float64(adata)
      dataptrD=<double *>CNY.PyArray_DATA(data)
      self._error=cgnslib.cg_array_write(aname,dt,dd,dv,dataptrD)
    if (dt==CK.Character):
      dataptrC=<char *>CNY.PyArray_DATA(adata)
      self._error=cgnslib.cg_array_write(aname,dt,dd,dv,dataptrC)

  # -----------------------------------------------------------------------------------------
  cpdef nuser_data(self):

    """
    Counts the number of `UserDefinedData_t` nodes contained in the current node. You can access
    the current node by using the `gopath` function.

    - Args:
    * None

    - Return:
    * number of `UserDefinedData_t` nodes contained in the current node (`int`)

    """
    
    cdef int nuser=-1
    self._error=cgnslib.cg_nuser_data(&nuser)
    return nuser

  # -----------------------------------------------------------------------------------------
  cpdef user_data_write(self, char * usn):

    """
    Creates a new `UserDefinedData_t` node. You can set the position of the node in the `CGNS tree`
    by using the `gopath` function.

    - Args:
    * `usn` : name of the created node (`string`)

    - Return:
    * None

    """
    
    self._error=cgnslib.cg_user_data_write(usn)

  # -----------------------------------------------------------------------------------------
  cpdef user_data_read(self, int Index):

    """
    Returns the name of a given `UserDefinedData_t` node. You can access the node by using
    the `gopath` function.

    - Args:
    * `Index` : user-defined data id which is necessarily comprised between 1 and the total
      number of `UserDefinedData_t` nodes under the current node (`int`)

    - Return:
    * name of the required `UserDefinedData_t` node (`string`)

    """
    
    cdef char * usn = " "
    self._error=cgnslib.cg_user_data_read(Index,usn)
    return usn

  # -----------------------------------------------------------------------------------------
  cpdef discrete_write(self, int B, int Z, char * name):

    """
    Creates a new `DiscreteData_t` node.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `name` : name of the created node (`string`)

    - Return:
    * discreted data id (`int`)
    
    """
    
    cdef int D = -1
    self._error=cgnslib.cg_discrete_write(self._root,B,Z,name,&D)
    return D

  # ---------------------------------------------------------------------------------------
  cpdef ndiscrete(self, int B, int Z):

    """
    Returns the number of `DiscreteData_t` nodes in a given zone.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)

    - Return:
    * number of `DiscreteData_t`nodes contained in the zone (`int`)
    
    """
    
    cdef int ndiscrete = -1
    self._error=cgnslib.cg_ndiscrete(self._root,B,Z,&ndiscrete)
    return ndiscrete

  # ---------------------------------------------------------------------------------------
  cpdef discrete_read(self, int B, int Z, int D):

    """
    Returns the name of a given `DiscreteData_t` node.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `D` : discrete data id which is necessarily comprised between 1 and the total number
      of discrete data nodes under the zone (`int`)

    - Return:
    * name of discrete data node (`string`)
    
    """
    
    cdef char * name = " "
    self._error=cgnslib.cg_discrete_read(self._root,B,Z,D,name)
    return name

  # ---------------------------------------------------------------------------------------
  cpdef discrete_size(self, int B, int Z, int D):

    """
    Returns the dimensions of a `DiscreteData_t` node.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `D` : discrete data id which is necessarily comprised between 1 and the total number
      of discrete data nodes under the zone (`int`)

    - Return:
    * number of dimensions defining the discrete data (`int`). If a point set has been defined,
      this is 1, otherwise this is the current zone index dimension.
    * array of dimensions ('numpy.ndarray`)
      
    """
    
    cdef int dd = -1
    cdef cgnslib.cgsize_t * dvptr
    dv=PNY.ones((CK.ADF_MAX_DIMENSIONS,),dtype=PNY.int32)    
    dvptr = <cgnslib.cgsize_t *>CNY.PyArray_DATA(dv)
    self._error=cgnslib.cg_discrete_size(self._root,B,Z,D,&dd,dvptr)
    return (dd,dv[0:dd])

  # ---------------------------------------------------------------------------------------
  cpdef discrete_ptset_info(self, int B, int Z, int D):

    """
    Returns a tuple with information about a given discrete data node.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `D` : discrete data id which is necessarily comprised between 1 and the total number
      of discrete data nodes under the zone (`int`)

    - Return:
    * type of point set defining the interface ('int`). It can be `PointRange` or `PointList`.
    * number of points defining the interface (`int`)

    """
    
    cdef cgnslib.PointSetType_t pst 
    cdef cgnslib.cgsize_t npnts 
    self._error=cgnslib.cg_discrete_ptset_info(self._root,B,Z,D,&pst,&npnts)
    return (pst,npnts)

  # ---------------------------------------------------------------------------------------
  cpdef discrete_ptset_read(self, int B, int Z, int D):
    
    """
    Reads a point set of a given discrete data node.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `D` : discrete data id which is necessarily comprised between 1 and the total number
      of discrete data nodes under the zone (`int`)

    - Return:
    * array of points defining the interface ('numpy.ndarray`)

    """
    
    cdef cgnslib.cgsize_t * pntsptr
    npnts=self.discrete_ptset_info(B,Z,D)[1]    
    ztype=self.zone_type(B,Z)
    pdim=self.base_read(B)[3]
    if (ztype==CK.Unstructured):
      dim=1
    elif (ztype==CK.Structured):
      dim=self.base_read(B)[2]  
    pnts=PNY.zeros((npnts,dim),dtype=PNY.int32)
    pntsptr=<cgnslib.cgsize_t *>CNY.PyArray_DATA(pnts)
    self._error=cgnslib.cg_discrete_ptset_read(self._root,B,Z,D,pntsptr)
    return pnts

  # ---------------------------------------------------------------------------------------
  cpdef discrete_ptset_write(self, int B, int Z, char * name, cgnslib.GridLocation_t location,
                             cgnslib.PointSetType_t pst, cgnslib.cgsize_t npnts, pts):

    """
    Creates a new point set `DiscreteData_t` node.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `D` : discrete data id which is necessarily comprised between 1 and the total number
      of discrete data nodes under the zone (`int`)

    - Return:
    * array of points defining the interface ('numpy.ndarray`)

    """
    
    cdef cgnslib.cgsize_t * pntsptr
    cdef int D = -1
    pnts=PNY.int32(pts)
    pntsptr=<cgnslib.cgsize_t *>CNY.PyArray_DATA(pnts)
    self._error=cgnslib.cg_discrete_ptset_write(self._root,B,Z,name,location,pst,npnts,
                                                pntsptr,&D)
    return D

  # ---------------------------------------------------------------------------------------
  cpdef nzconns(self, int B, int Z):

    """
    Returns the number of `ZoneGridConnectivity_t` nodes.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)

    - Returns:
    * number of `ZoneGridConnectivity_t` nodes (`int`)

    """
    cdef int nzc
    self._error=cgnslib.cg_nzconns(self._root,B,Z,&nzc)
    return nzc

  # ---------------------------------------------------------------------------------------
  cpdef zconn_read(self, int B, int Z, int C):

    """
    Returns the name of the `ZoneGridConnectivity_t` node.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `C` : zone grid connectivity id (`int`)

    - Returns:
    * name of the `ZoneGridConnectivity_t` node (`string`)

    """
    
    cdef char * name = " "
    self._error=cgnslib.cg_zconn_read(self._root,B,Z,C,name)
    return name

  # ---------------------------------------------------------------------------------------
  cpdef zconn_write(self, int B, int Z, char * name):

    """
    Creates a new `ZoneGridConnectivity_t` node.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `name` : name of the `ZoneGridConnectivity_t` node (`string`)

    - Returns:
    * zone grid connectivity id (`int`)

    """
    
    cdef int ZC = -1
    self._error=cgnslib.cg_zconn_write(self._root,B,Z,name,&ZC)
    return ZC

  # ----------------------------------------------------------------------------------------
  cpdef zconn_get(self, int B, int Z):

    """
    Gets the current `ZoneGridConnectivity_t` node.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)

    - Returns:
    * zone grid connectivity id (`int`)

    """
    
    cdef int ZC = -1
    self._error=cgnslib.cg_zconn_get(self._root,B,Z,&ZC)
    return ZC

  # ---------------------------------------------------------------------------------------
  cpdef zconn_set(self, int B, int Z, int ZC):

    """
    Gets the current `ZoneGridConnectivity_t` node.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `ZC` : zone grid connectivity id (`int`)

    - Returns:
    * None

    """
    
    self._error=cgnslib.cg_zconn_set(self._root,B,Z,ZC)

  # ---------------------------------------------------------------------------------------
  cpdef n1to1(self, int B, int Z):

    """
    Returns the number of 1-to-1 interfaces in a zone.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)

    - Returns:
    * number of 1-to-1 interfaces contained in a `GridConnectivity1to1_t` node (`int`)

    - Remarks:
    * 1-to-1 interfaces that may be stored under `GridConnectivity_t nodes are not taken
      into account.

    """      
    cdef int n1to1 = -1
    self._error=cgnslib.cg_n1to1(self._root,B,Z,&n1to1)
    return n1to1

  # ----------------------------------------------------------------------------------------
  cpdef _1to1_read(self, int B, int Z, int I):

    """
    Returns a tuple with information about a 1-to-1 connectivity data.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `I` : interface id (`int`)

    - Returns:
    * name of the interface (`string`)
    * name of the zone interfacing with the current zone (`string`)
    * range of points for the current zone (`numpy.ndarray`)
    * range of points for the donor zone (`numpy.ndarray`)

    """
    
    cdef char * name = " "
    cdef char * dname = " "
    cdef cgnslib.cgsize_t * arangeptr
    cdef cgnslib.cgsize_t * drangeptr
    cdef int * trptr
    arange=PNY.ones((2,3),dtype=PNY.int32)
    arangeptr=<cgnslib.cgsize_t *>CNY.PyArray_DATA(arange)
    drange=PNY.ones((2,3),dtype=PNY.int32)
    drangeptr=<cgnslib.cgsize_t *>CNY.PyArray_DATA(drange)
    tr=PNY.ones((3,),dtype=PNY.int32)
    trptr=<int *>CNY.PyArray_DATA(tr)
    self._error=cgnslib.cg_1to1_read(self._root,B,Z,I,name,dname,arangeptr,drangeptr,trptr)
    return (name,dname,arange,drange,tr)

  # -----------------------------------------------------------------------------------------
  cpdef _1to1_id(self, int B, int Z, int I):
    cdef double id1to1 = -1
    self._error=cgnslib.cg_1to1_id(self._root,B,Z,I,&id1to1)
    return id1to1

  # ------------------------------------------------------------------------------------------
  cpdef _1to1_write(self, int B, int Z, char * cname, char * dname, crange, drange, tr):

    """
    Creates a new 1-to-1 connectivity node.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `cname` : name of the interface (`string`)
    * `dname` : name of the zone interfacing with the current zone (`string`)
    * `crange` : range of points for the current zone (`numpy.ndarray`)
    * `drange` : range of points for the donor zone (`numpy.ndarray`)
    * `tr` : notation for the transformation matrix defining the relative orientation
      of the two zones (`numpy.ndarray`)

    - Returns:
    * interface id (`int`)

    """
    
    cdef cgnslib.cgsize_t * crangeptr
    cdef cgnslib.cgsize_t * drangeptr
    cdef int * trptr
    cdef int I = -1
    carray=PNY.int32(crange)
    darray=PNY.int32(drange)
    tarray=PNY.int32(tr)
    crangeptr=<cgnslib.cgsize_t *>CNY.PyArray_DATA(carray)
    drangeptr=<cgnslib.cgsize_t *>CNY.PyArray_DATA(darray)
    trptr=<int *>CNY.PyArray_DATA(tarray)
    self._error=cgnslib.cg_1to1_write(self._root,B,Z,cname,dname,crangeptr,drangeptr,trptr,&I)
    return I

  # ------------------------------------------------------------------------------------------
  cpdef n1to1_global(self, int B):

    """
    Counts the number of 1-to-1 interfaces in a base.

    - Args:
    * `B` : base id (`int`)

    - Return:
    * number of 1-to-1 interfaces in the database (`int`)

    """
    
    cdef int n = -1
    self._error=cgnslib.cg_n1to1_global(self._root,B,&n)
    return n

   
  # --------------------------------------------------------------------------------------------    
  cpdef nconns(self, int B, int Z):

    """
    Returns the number of generalized connectivity data.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)

    - Returns:
    * number of interfaces (`int`)

    """
    
    cdef int nc = -1
    self._error=cgnslib.cg_nconns(self._root,B,Z,&nc)
    return nc

  # ---------------------------------------------------------------------------------------------
  cpdef conn_info(self, int B, int Z, int I):

    """
    Returns a tuple with information about a generalized connectivity data node.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `I` : interface id (`int`)

    - Returns:
    * name of the interface (`string`)
    * grid location used in the definition of the point set (`int`)
    * type of the interface. The admissible types are `Overset`, `Abutting` and `Abutting1to1`. (`int`) 
    * type of point set defining the interface in the zone. The admissible types are `PointRange` or
      `PointList`. (`int`)
    * number of points defining the interface in the zone (`int`)
    * name of the zone interfacing with the zone (`string`)
    * type of the donor zone. The admissible types are `Structured` and `Unstructured`. (`int`)
    * type of point set defining the interface in the donor zone. The admissible types are `PointListDonor`
      and `CellListDonor`. (`int`)
    * data type in which the donor points are stored in the file
    * number of points or cells in the zone. This number is the same as the number of points or cells
      contained in the donor zone. (`int`)

    """
    
    cdef char * name = " " 
    cdef cgnslib.GridLocation_t location
    cdef cgnslib.GridConnectivityType_t gtype
    cdef cgnslib.PointSetType_t pst
    cdef cgnslib.cgsize_t npnts
    cdef char * dname = " "
    cdef cgnslib.ZoneType_t dzt
    cdef cgnslib.PointSetType_t dpst
    cdef cgnslib.DataType_t ddt
    cdef cgnslib.cgsize_t ndd
    self._error=cgnslib.cg_conn_info(self._root,B,Z,I,name,&location,&gtype,&pst,&npnts,dname,
                                     &dzt,&dpst,&ddt,&ndd)
    return (name,location,gtype,pst,npnts,dname,dzt,dpst,ddt,ndd)

  # ---------------------------------------------------------------------------------------------
  cpdef conn_read(self, int B, int Z, int I):

    """
    Returns a tuple with information about a generalized connectivity data node.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `I` : interface id (`int`)

    - Returns:
    * array of points defining the interface in the zone (`numpy.ndarray`)
    * data type in which the donor points are stored in the file (`int`)
    * array of donor points or cells (`numpy.ndarray`)

    """
    
    cdef cgnslib.DataType_t ddt
    cdef cgnslib.cgsize_t * pntsptr
    cdef cgnslib.cgsize_t * ddptr
    dim=self.base_read(B)[2]
    np=self.conn_info(B,Z,I)[4]
    ndd=self.conn_info(B,Z,I)[9]
    pnts=PNY.ones((np,dim),dtype=PNY.int32)
    dd=PNY.ones((ndd,dim),dtype=PNY.int32)
    pntsptr=<cgnslib.cgsize_t *>CNY.PyArray_DATA(pnts)
    ddptr=<cgnslib.cgsize_t *>CNY.PyArray_DATA(dd)
    self._error=cgnslib.cg_conn_read(self._root,B,Z,I,pntsptr,ddt,ddptr)
    return (pnts,ddt,dd)
    
  # ---------------------------------------------------------------------------------------------
  cpdef conn_write(self, int B, int Z, char * cname, cgnslib.GridLocation_t loc,
                   cgnslib.GridConnectivityType_t gct, cgnslib.PointSetType_t pst,
                   cgnslib.cgsize_t npnts, pnts, char * dname, cgnslib.ZoneType_t dzt,
                   cgnslib.PointSetType_t dpst, cgnslib.DataType_t ddt, cgnslib.cgsize_t ndd,
                   dd):
    """
    Creates a new generalized connectivity data node.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `cname` : name of the interface (`string`)
    * `loc` : grid location used for the point set (`int`)
    * `gct` : type of interface. The admissible types are `Overset`, `Abutting` and `Abutting1to1`.
      (`int`)
    * `pst` : type of point set defining the interface in the current zone. The admissible types are
      `PointRange` and `PointList`. (`int`)
    * `npnts` : number of points defining the interface in the current zone.For a type of point set
      as `PointRange`, `npnts` is always two. For a type of point set as `PointList` , `npnts` is equal
      to the number of points defined in the `PointList`. (`int`)
    * `pnts` : array of points defining the interface in the zone (`numpy.ndarray`)
    * `dname` : name of the donnor zone (`string`)
    * `dzt` : type of the donnor zone. The admissible types are `Structured` and `Unstructured`. (`int`)
    * `dpst` : type of point set of the donnor zone (`int`)
    * `ddt` : data type of the donor points (`int`)
    * `ndd` : number of points or cells in the current zone (`int`)
    * `dd` : array of donor points or cells whose dimension corresponds to the number `ndd`(`numpy.ndarray`) 

    - Returns:
    * interface id (`int`)

    """
    
    cdef cgnslib.cgsize_t * dataptr
    cdef cgnslib.cgsize_t * ddataptr
    cdef int I = -1
    carray=PNY.int32(pnts)
    darray=PNY.int32(dd)
    dataptr=<cgnslib.cgsize_t *>CNY.PyArray_DATA(carray)
    ddataptr=<cgnslib.cgsize_t *>CNY.PyArray_DATA(darray)
    self._error=cgnslib.cg_conn_write(self._root,B,Z,cname,loc,gct,pst,npnts,dataptr,dname,
                                      dzt,dpst,ddt,ndd,ddataptr,&I)
    return I

  # ---------------------------------------------------------------------------------------------
  cpdef conn_id(self, int B, int Z, int I):
    cdef double cid
    self._error=cgnslib.cg_conn_id(self._root,B,Z,I,&cid)
    return cid

  # ---------------------------------------------------------------------------------------------
  cpdef conn_read_short(self, int B, int Z, int I):

    """
    Reads generalized connectivity data without donor information.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `I` : interface id (`int`)

    - Return:
    * array of points defining the interface in the current zone (`numpy.ndarray`)

    """
    
    cdef cgnslib.cgsize_t * pntsptr
    dim=self.base_read(B)[2]
    np=self.conn_info(B,Z,I)[4]
    pnts=PNY.ones((np,dim),dtype=PNY.int32)
    pntsptr=<cgnslib.cgsize_t *>CNY.PyArray_DATA(pnts)
    self._error=cgnslib.cg_conn_read_short(self._root,B,Z,I,pntsptr)
    return pnts

  # ---------------------------------------------------------------------------------------------
  cpdef conn_write_short(self, int B, int Z, char * name, cgnslib.GridLocation_t location,
                         cgnslib.GridConnectivityType_t gct, cgnslib.PointSetType_t pst,
                         cgnslib.cgsize_t npnts, pnts, char * dname):

    """
    Creates a new generalized connectivity data node without donor information.

    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `name` : name of the interface (`string`)
    * `location` : grid location used for the point set (`int`)
    * `gct` : type of interface. The admissible types are `Overset`, `Abutting` and `Abutting1to1`.
      (`int`)
    * `pst` : type of point set defining the interface in the current zone. The admissible types are
      `PointRange` and `PointList`. (`int`)
    * `npnts` : number of points defining the interface in the current zone.For a type of point set
      as `PointRange`, `npnts` is always two. For a type of point set as `PointList` , `npnts` is equal
      to the number of points defined in the `PointList`. (`int`)
    * `pnts` : array of points defining the interface in the zone (`numpy.ndarray`)
    * `dname` : name of the donnor zone (`string`)   

    """
    
    cdef int I = -1
    cdef cgnslib.cgsize_t * dataptr
    carray=PNY.int32(pnts)
    pntsptr=<cgnslib.cgsize_t *>CNY.PyArray_DATA(carray)
    self._error=cgnslib.cg_conn_write_short(self._root,B,Z,name,location,gct,pst,npnts,pntsptr,dname,&I)
    return I

  # --------------------------------------------------------------------------------------------
  cpdef convergence_write(self, int iter, char * ndef):

    """
    Creates a convergence history node.

    - Args:
    * `iter` : number of iterations for which convergence information is recorded (`int`)
    * `ndef` : description of the convergence information (`string`)

    - Return:
    * None

    """
    
    self._error=cgnslib.cg_convergence_write(iter,ndef)

  # --------------------------------------------------------------------------------------------
  cpdef convergence_read(self):

    """
    Reads a convergence history node.

    - Args:
    * None

    - Return:
    * number of iterations for which convergence information is recorded (`int`)
    * description of the convergence information (`string`)

    """
    
    cdef int iter = -1
    cdef char * ndef = ""
    self._error=cgnslib.cg_convergence_read(&iter,&ndef)
    return (iter,ndef)

  # --------------------------------------------------------------------------------------------
  cpdef state_write(self, char * sdes):

    """
    Creates a reference state node.

    - Args:
    * `sdes` : description of the reference state (`string`)

    - Return:
    * None

    """
    
    self._error=cgnslib.cg_state_write(sdes)

  # --------------------------------------------------------------------------------------------
  cpdef state_read(self):
    cdef char * des = ""
    self._error=cgnslib.cg_state_read(&des)
    return des

  # --------------------------------------------------------------------------------------------
  cpdef equationset_write(self, int eqdim):

    """
    Creates a convergence history node.

    - Args:
    * `eqdim` : dimensionality of the governing equations (`int`)
      Dimensionality is the number of spatial variables describing the flow 
      
    - Return:
    * None

    """
    
    self._error=cgnslib.cg_equationset_write(eqdim)

  # --------------------------------------------------------------------------------------------
  cpdef equationset_read(self):

    """
    Returns a tuple with information about the flow equation node.

    - Args:
    * None
      
    - Return:
    * dimensionality of the governing equations (`int`)
    * flag indicating if the node contains the definition of the governing equations (`int`)
      0 if it doesn't, 1 if it does. 
    * flag indicating if the node contains the definition of a gas model (`int`)
      0 if it doesn't, 1 if it does.
    * flag indicating if the node contains the definition of a viscosity model (`int`)
      0 if it doesn't, 1 if it does.
    * flag indicating if the node contains the definition of a thermal conductivity model (`int`)
      0 if it doesn't, 1 if it does.       
    * flag indicating if the node contains the definition of the turbulence closure (`int`)
      0 if it doesn't, 1 if it does.
    * flag indicating if the node contains the definition of a turbulence model (`int`)
      0 if it doesn't, 1 if it does.
      
    """
    cdef int eqdim = -1
    cdef int geq = -1
    cdef int gasflag = -1
    cdef int visflag = -1
    cdef int thermflag = -1
    cdef int turbcflag = -1
    cdef int turbmflag = -1

    self._error=cgnslib.cg_equationset_read(&eqdim,&geq,&gasflag,&visflag,&thermflag,&turbcflag,&turbmflag)
    return (eqdim,geq,gasflag,visflag,thermflag,turbcflag,turbmflag)

  # --------------------------------------------------------------------------------------------
  cpdef equationset_chemistry_read(self):
    
    """
    Returns a tuple with information about the chemistry equation node.

    - Args:
    * None
      
    - Return:
    * flag indicating if the node contains the definition of a thermal relaxation model (`int`)
      0 if it doesn't, 1 if it does. 
    * flag indicating if the node contains the definition of a chemical kinetics model (`int`)
      0 if it doesn't, 1 if it does.

    """
    
    cdef int trflag = -1
    cdef int ckflag = -1

    self._error=cgnslib.cg_equationset_chemistry_read(&trflag,&ckflag)
    return (trflag,ckflag)

  # --------------------------------------------------------------------------------------------
  cpdef equationset_elecmagn_read(self):

    """
    Returns a tuple with information about the electromagnetic equation node.

    - Args:
    * None
      
    - Return:
    * flag indicating if the node contains the definition of an electric field model for
      electromagnetic flows (`int`). 0 if it doesn't, 1 if it does. 
    * flag indicating if the node contains the definition a magnetic field model for
      electromagnetic flows(`int`). 0 if it doesn't, 1 if it does.
      * flag indicating if the node contains the definition of a conductivity model for
        electromagnetic flows (`int`). 0 if it doesn't, 1 if it does.

    """
    cdef int eflag = -1
    cdef int mflag = -1
    cdef int cflag = -1

    self._error=cgnslib.cg_equationset_elecmagn_read(&eflag,&mflag,&cflag)
    return (eflag,mflag,cflag)

  # --------------------------------------------------------------------------------------------
  cpdef governing_read(self):

    """
    Returns type of the governing equations.

    - Args:
    * None
      
    - Return:
    * type of governing equations (`int`)

    """

    cdef cgnslib.GoverningEquationsType_t etype
    
    self._error=cgnslib.cg_governing_read(&etype)
    return etype

  # -------------------------------------------------------------------------------------------
  cpdef governing_write(self, cgnslib.GoverningEquationsType_t etype):
    
    """
    Creates type of the governing equations.

    - Args:
    * `etype`: type of governing equations (`int`)
      
    - Return:
    * None

    """
    
    self._error=cgnslib.cg_governing_write(etype)

   # ------------------------------------------------------------------------------------------
  cpdef diffusion_write(self, int dmodel):

    """
    Creates a diffusion model node.

    - Args:
    * `dmodel` : flags defining which diffusion terms are included in the governing equations (`int`)
      This is only suitable for the Navier-Stokes equations with structured grids.
      
    - Return:
    * None

    """
    
    self._error=cgnslib.cg_diffusion_write(&dmodel)

  # ------------------------------------------------------------------------------------------
  cpdef diffusion_read(self):

    """
    Reads a diffusion model node.

    - Args:
    * None

    - Return:
    * flags defining which diffusion terms are included in the governing equations (`int`)
    
    """
    
    cdef int dmodel = -1
    self._error=cgnslib.cg_diffusion_read(&dmodel)
    return dmodel

  # ------------------------------------------------------------------------------------------
  cpdef model_write(self, char * label, cgnslib.ModelType_t mtype):

    """
    Writes auxiliary model types.

    - Args:
    * `label` : CGNS label of the defined model (`string`)
      The admissible types are:
      `GasModel_t`
      `ViscosityModel_t`
      `ThermalConductivityModel_t`
      `TurbulenceClosure_t`
      `TurbulenceModel_t`
      `ThermalRelaxationModel_t`
      `ChemicalKineticsModel_t`
      `EMElectricFieldModel_t`
      `EMMagneticFieldModel_t`
      `EMConductivityModel_t`
    * model type allowed for the label selected (`int`)

    - Return:
    * None

    """
    
    self._error=cgnslib.cg_model_write(label,mtype)

  # ------------------------------------------------------------------------------------------
  cpdef model_read(self, char * label ):

    """
    Reads auxiliary model types.

    - Args:
    * `label` : CGNS label of the defined model (`string`)
      The admissible types are:
      `GasModel_t`
      `ViscosityModel_t`
      `ThermalConductivityModel_t`
      `TurbulenceClosure_t`
      `TurbulenceModel_t`
      `ThermalRelaxationModel_t`
      `ChemicalKineticsModel_t`
      `EMElectricFieldModel_t`
      `EMMagneticFieldModel_t`
      `EMConductivityModel_t`

    - Return:
    * model type allowed for the label selected (`int`)
    
    """
    
    cdef cgnslib.ModelType_t mtype
    self._error=cgnslib.cg_model_read(label,&mtype)
    return mtype

  # ------------------------------------------------------------------------------------------
  cpdef nintegrals(self):

    """
    Returns the number of integral data nodes.

    - Args:
    * None

    - Return:
    * number of integral data nodes contained in the current node (`int`)
    
    """
    
    cdef int nint = -1
    self._error=cgnslib.cg_nintegrals(&nint)
    return nint

  # ------------------------------------------------------------------------------------------
  cpdef integral_write(self, char * name):

    """
    Creates a new integral data node.

    - Args:
    * `name` : name of the integral data node (`string`)

    - Return:
    * number of integral data nodes contained in the current node (`int`)
    
    """
    
    self._error=cgnslib.cg_integral_write(name)

  # ------------------------------------------------------------------------------------------
  cpdef integral_read(self, int idx):

    """
    Returns the name of a integral data node.

    - Args:
    * `idx` : integral data id (`int`)

    - Return:
    * name of the integral data node (`string`)
    
    """
    
    cdef char * name = " "
    self._error=cgnslib.cg_integral_read(idx,name)
    return name
  
  # ------------------------------------------------------------------------------------------
  cpdef descriptor_write(self, char * dname, char * dtext):

    """
    Writes descriptive text.

    - Args:
    * `dname` : name of the descriptor node (`string`)
    * `dtext` : description contained in the descriptor node (`string`)

    - Return:
    * None
    
    """
    
    self._error=cgnslib.cg_descriptor_write(dname,dtext)

  # ------------------------------------------------------------------------------------------
  cpdef ndescriptors(self):

    """
    Returns the number of descriptor nodes contained in the current node.

    - Args:
    * None

    - Return:
    * number of descriptor nodes under the current node (`int`)
    
    """
    
    cdef int ndes = -1
    self._error=cgnslib.cg_ndescriptors(&ndes)
    return ndes

  # ------------------------------------------------------------------------------------------
  cpdef units_write(self, cgnslib.MassUnits_t m,cgnslib.LengthUnits_t l, cgnslib.TimeUnits_t tps,
                    cgnslib.TemperatureUnits_t t, cgnslib.AngleUnits_t a):
    
    """
    Writes the first five dimensional units in a new node.

    - Args:
    * `m` : mass units (`int`)
      The admissible values are CG_Null, CG_UserDefined, Kilogram, Gram, Slug, and PoundMass. 
    * `l` : length units (`int`)
      The admissible values are CG_Null, CG_UserDefined, Meter, Centimeter, Millimeter, Foot, and Inch. 
    * `tps`: mass units (`int`)
      The admissible values are CG_Null, CG_UserDefined, and Second. 
    * `t`: mass units (`int`)
      The admissible values are CG_Null, CG_UserDefined, Kelvin, Celsius, Rankine, and Fahrenheit. 
    * `a`: mass units (`int`)
      The admissible values are CG_Null, CG_UserDefined, Degree, and Radian. 

    - Return:
    * None
    
    """
    
    self._error=cgnslib.cg_units_write(m,l,tps,t,a)

  # ------------------------------------------------------------------------------------------
  cpdef nunits(self):

    """
    Returns the number of dimensional units.

    - Args:
    * None
    
    - Return:
    * number of units used in the file (`int`)
    
    """
    
    cdef int n = -1
    self._error=cgnslib.cg_nunits(&n)
    return n

  # ------------------------------------------------------------------------------------------
  cpdef units_read(self):

    """
    Reads the first five dimensional units.

    - Args:
    * None

    - Return:
    * `m` : mass units (`int`)
    * `l` : length units (`int`)
    * `tps`: mass units (`int`)
    * `t`: mass units (`int`)
    * `a`: mass units (`int`)
    
    """
    
    cdef cgnslib.MassUnits_t m
    cdef cgnslib.LengthUnits_t l
    cdef cgnslib.TimeUnits_t tps
    cdef cgnslib.TemperatureUnits_t t
    cdef cgnslib.AngleUnits_t a
    
    self._error=cgnslib.cg_units_read(&m,&l,&tps,&t,&a)
    return (m,l,tps,t,a)

  # ------------------------------------------------------------------------------------------
  cpdef unitsfull_write(self, cgnslib.MassUnits_t m,cgnslib.LengthUnits_t l, cgnslib.TimeUnits_t tps,
                        cgnslib.TemperatureUnits_t t, cgnslib.AngleUnits_t a, cgnslib.ElectricCurrentUnits_t c,
                        cgnslib.SubstanceAmountUnits_t sa, cgnslib.LuminousIntensityUnits_t i):

    """
    Writes all eight dimensional units.

    - Args:
    * `m` : mass units (`int`)
      The admissible values are CG_Null, CG_UserDefined, Kilogram, Gram, Slug, and PoundMass. 
    * `l` : length units (`int`)
      The admissible values are CG_Null, CG_UserDefined, Meter, Centimeter, Millimeter, Foot, and Inch. 
    * `tps`: mass units (`int`)
      The admissible values are CG_Null, CG_UserDefined, and Second. 
    * `t`: mass units (`int`)
      The admissible values are CG_Null, CG_UserDefined, Kelvin, Celsius, Rankine, and Fahrenheit. 
    * `a`: mass units (`int`)
      The admissible values are CG_Null, CG_UserDefined, Degree, and Radian.
    * `c`: electric current units (`int`)
      The admissible values are CG_Null, CG_UserDefined, Ampere, Abampere, Statampere, Edison, and auCurrent. 
    * `sa`: admissible value units (`int`)
      The admissible values are CG_Null, CG_UserDefined, Mole, Entities, StandardCubicFoot, and StandardCubicMeter.
    * `i`: luminous intensity units (`int`)
      The admissible values are CG_Null, CG_UserDefined, Candela, Candle, Carcel, Hefner, and Violle. 
    
    - Return:
    * None
    
    """
    
    self._error=cgnslib.cg_unitsfull_write(m,l,tps,t,a,c,sa,i)

  # ------------------------------------------------------------------------------------------
  cpdef unitsfull_read(self):

    """
    Returns all eight dimensional units.

    - Args:
    * None

    - Return:
    * `m` : mass units (`int`)
    * `l` : length units (`int`)
    * `tps`: mass units (`int`)
    * `t`: mass units (`int`)
    * `a`: mass units (`int`)
    * `c`: electric current units (`int`)
    * `sa`: admissible value units (`int`)
    * `i`: luminous intensity units (`int`)
    
    """
    
    cdef cgnslib.MassUnits_t m
    cdef cgnslib.LengthUnits_t l
    cdef cgnslib.TimeUnits_t tps
    cdef cgnslib.TemperatureUnits_t t
    cdef cgnslib.AngleUnits_t a
    cdef cgnslib.ElectricCurrentUnits_t c
    cdef cgnslib.SubstanceAmountUnits_t sa
    cdef cgnslib.LuminousIntensityUnits_t i
    
    self._error=cgnslib.cg_unitsfull_read(&m,&l,&tps,&t,&a,&c,&sa,&i)
    return (m,l,tps,t,a,c,sa,i)

  # ------------------------------------------------------------------------------------------
  cpdef exponents_write(self, cgnslib.DataType_t dt, e):

    """
    Writes the first five dimensional exponents in a new node.

    - Args:
    * `dt` : data type in which the exponents are recorded (`int`)
      The admissible data types for the exponents are RealSingle and RealDouble. 
    * `e` : exponents for the dimensional units are written in that order: mass, length, time,
      temperature and angle (`numpy.ndarray`)

    - Return:
    * None
    
    """
    
    cdef float * sexptr
    cdef double * dexptr
    if (e.shape!=(5,)):
      print "Bad 2nd arg size: should be 5"
      return 
    if (dt==CK.RealSingle):
      exp=PNY.float32(e)
      sexptr=<float *>CNY.PyArray_DATA(exp)
      self._error=cgnslib.cg_exponents_write(dt,sexptr)
    elif (dt==CK.RealDouble):
      exp=PNY.float64(e)
      dexptr=<double *>CNY.PyArray_DATA(exp)
      self._error=cgnslib.cg_exponents_write(dt,dexptr)
    else:
      print "First arg should be CG_RealDouble or CG_RealSingle"
      return            

  # ------------------------------------------------------------------------------------------
  cpdef exponents_info(self):

    """
    Returns the exponent data type.

    - Args:
    * None

    - Return:
    * data type of the exponents (`int`)
    
    """
    
    cdef cgnslib.DataType_t dtype
    self._error=cgnslib.cg_exponents_info(&dtype)
    return dtype
  
  # ------------------------------------------------------------------------------------------
  cpdef nexponents(self):

    """
    Returns the number of dimensional exponents.

    - Args:
    * None

    - Return:
    * number of exponents used in the file (`int`)
    
    """
    
    cdef int nexp = -1
    self._error=cgnslib.cg_nexponents(&nexp)
    return nexp
  
  # ------------------------------------------------------------------------------------------
  cpdef exponents_read(self):

    """
    Reads the first five dimensional exponents.

    - Args:
    * None

    - Return:
    * exponents for the dimensional units are written in that order: mass, length, time,
      temperature and angle (`numpy.ndarray`)
    
    """
    
    cdef float * sexptr
    cdef double * dexptr
    e=PNY.ones((5,))
    dt=self.exponents_info()
    if (dt==CK.RealSingle):
      exp=PNY.float32(e)
      sexptr=<float *>CNY.PyArray_DATA(exp)
      self._error=cgnslib.cg_exponents_read(sexptr)
    else:
      exp=PNY.float64(e)
      dexptr=<double *>CNY.PyArray_DATA(exp)
      self._error=cgnslib.cg_exponents_read(dexptr)
    return exp

  # ------------------------------------------------------------------------------------------
  cpdef expfull_write(self, cgnslib.DataType_t dt, e):

    """
    Writes all height dimensional exponents.

    - Args:
    * `dt` : data type in which the exponents are recorded (`int`)
      The admissible data types for the exponents are RealSingle and RealDouble. 
    * `e` : exponents for the dimensional units are written in that order: mass, length, time,
      temperature, angle, electric current, substance amount, and luminous intensity (`numpy.ndarray`)

    - Return:
    * None
    
    """
    
    cdef float * sexptr
    cdef double * dexptr
    if (e.shape!=(8,)):
      print "Bad 2nd arg size: should be 8"
      return 
    if (dt==CK.RealSingle):
      exp=PNY.float32(e)
      sexptr=<float *>CNY.PyArray_DATA(exp)
      self._error=cgnslib.cg_expfull_write(dt,sexptr)
    elif (dt==CK.RealDouble):
      exp=PNY.float64(e)
      dexptr=<double *>CNY.PyArray_DATA(exp)
      self._error=cgnslib.cg_expfull_write(dt,dexptr)
    else:
      print "First arg should be CG_RealDouble or CG_RealSingle"
      return

  # ------------------------------------------------------------------------------------------
  cpdef expfull_read(self):

    """
    Reads all eight dimensional exponents.

    - Args:
    * None

    - Return:
    * exponents for the dimensional units are written in that order: mass, length, time,
      temperature, angle, electric current, substance amount, and luminous intensity (`numpy.ndarray`)
    
    """
    
    cdef float * sexptr
    cdef double * dexptr
    e=PNY.ones((8,))
    dt=self.exponents_info()
    if (dt==CK.RealSingle):
      exp=PNY.float32(e)
      sexptr=<float *>CNY.PyArray_DATA(exp)
      self._error=cgnslib.cg_expfull_read(sexptr)
    else:
      exp=PNY.float64(e)
      dexptr=<double *>CNY.PyArray_DATA(exp)
      self._error=cgnslib.cg_expfull_read(dexptr)
    return exp

  # ------------------------------------------------------------------------------------------
  cpdef conversion_write(self, cgnslib.DataType_t dt, fact):

    """
    Writes a conversion factors node.

    - Args:
    * `dt` : data type in which the exponents are recorded (`int`)
      The admissible data types for conversion factors are RealSingle and RealDouble. 
    * `fact` : two-element array which contains the scaling and the offset factors (`numpy.ndarray`)

    - Return:
    * None
    
    """

    cdef float * sfactptr
    cdef double * dfactptr
    if (dt==CK.RealSingle):
      cfact=PNY.float32(fact)
      sfactptr=<float *>CNY.PyArray_DATA(cfact)
      self._error=cgnslib.cg_conversion_write(dt,sfactptr)
    elif (dt==CK.RealDouble):
      cfact=PNY.float64(fact)
      dfactptr=<double *>CNY.PyArray_DATA(cfact)
      self._error=cgnslib.cg_conversion_write(dt,dfactptr)
    else:
      print "First arg should be CG_RealDouble or CG_RealSingle"
      return

  # ------------------------------------------------------------------------------------------
  cpdef conversion_info(self):

    """
    Returns the conversion factors data type.

    - Args:
    * None

    - Return:
    * data type of the conversion factors (`int`)
    
    """
    
    cdef cgnslib.DataType_t dt
    self._error=cgnslib.cg_conversion_info(&dt)
    return dt

  # ------------------------------------------------------------------------------------------
  cpdef conversion_read(self):

    """
     Returns conversion factors.

    - Args:
    * None

    - Return:
    * two-element array which contains the scaling and the offset factors (`numpy.ndarray`)
    
    """

    cdef float * sfactptr
    cdef double * dfactptr
    fact=PNY.ones((2,))
    dt=self.conversion_info()
    if (dt==CK.RealSingle):
      cfact=PNY.float32(fact)
      sfactptr=<float *>CNY.PyArray_DATA(cfact)
      self._error=cgnslib.cg_conversion_read(sfactptr)
    else:
      cfact=PNY.float64(fact)
      dfactptr=<double *>CNY.PyArray_DATA(cfact)
      self._error=cgnslib.cg_conversion_read(dfactptr)
    return cfact

  # ------------------------------------------------------------------------------------------
  cpdef dataclass_write(self, cgnslib.DataClass_t dclass):

    """
    Writes a data class.

    - Args:
    * `dclass` : data class for the nodes at this level (`int`)
      The admissible data classes are `Dimensional`, `NormalizedByDimensional`,
      `NormalizedByUnknownDimensional`, `NondimensionalParameter` and `DimensionlessConstant`.

    - Return:
    * None
    
    """
    
    self._error=cgnslib.cg_dataclass_write(dclass)

  # ------------------------------------------------------------------------------------------
  cpdef dataclass_read(self):

    """
    Returns a data class.

    - Args:
    * None

    - Return:
    * `dclass` : data class for the nodes at this level (`int`)
    
    """
    
    cdef cgnslib.DataClass_t dclass
    self._error=cgnslib.cg_dataclass_read(&dclass)
    return dclass

  # ------------------------------------------------------------------------------------------
  cpdef gridlocation_write(self, cgnslib.GridLocation_t gloc):

    """
    Writes a grid location.

    - Args:
    * `gloc` : location in the grid (`int`)
      The admissible locations are `CG_Null`, `CG_UserDefined`, `Vertex`, `CellCenter`,
      `FaceCenter`, `IFaceCenter`, `JFaceCenter`, `KFaceCenter`, and `EdgeCenter`.
      
    - Return:
    * None

    - Remarks:
    * You must use the `gopath` function to access the node in which you want to write the
      grid location.
    
    """
    
    self._error=cgnslib.cg_gridlocation_write(gloc)

  # ------------------------------------------------------------------------------------------
  cpdef gridlocation_read(self):

    """
    Reads a grid location.

    - Args:
    * None
      
    - Return:
    * location in the grid (`int`)

    - Remarks:
    * You must use the `gopath` function to access the node in which you want to read the
      grid location.
    
    """
    
    cdef cgnslib.GridLocation_t gloc
    self._error=cgnslib.cg_gridlocation_read(&gloc)
    return gloc

  # ------------------------------------------------------------------------------------------
  cpdef ordinal_write(self, int ord):

    """
    Writes an ordinal value.

    - Args:
    * `ord` : any integer value  (`int`)
      
    - Return:
    * None

    - Remarks:
    * You must use the `gopath` function to access the node in which you want to write the
      ordinal value.
    
    """
    
    self._error=cgnslib.cg_ordinal_write(ord)

  # ------------------------------------------------------------------------------------------
  cpdef ordinal_read(self):

    """
    Reads an ordinal value.

    - Args:
    * None 
      
    - Return:
    * any integer value (`int`)

    - Remarks:
    * You must use the `gopath` function to access the node in which you want to read the
      ordinal value.
    
    """
    
    cdef int o
    self._error=cgnslib.cg_ordinal_read(&o)
    return o

  # ------------------------------------------------------------------------------------------
  cpdef ptset_info(self):

    """
    Returns a tuple with information about a point set.
  
    - Args:
    * None
      
    - Return:
    * point set type (`int`)
      The admissible types are PointRange for a range of points or cells, and PointList for a
      list of discrete points or cells.
    * number of points or cells in the point set (`int`)

    - Remarks:
    * You must use the `gopath` function to access the node in which you want to extract information.
      

    """
    
    cdef cgnslib.PointSetType_t pst
    cdef cgnslib.cgsize_t npnts
    self._error=cgnslib.cg_ptset_info(&pst,&npnts)
    return (pst,npnts)

  # ------------------------------------------------------------------------------------------
  cpdef ptset_write(self, cgnslib.PointSetType_t pst, cgnslib.cgsize_t npnts, pnts):

    """
    Creates point set data.
    
    - Args:
    * `pst` : point set type (`int`)
    * `npnts` : number of points or cells used to define the point set (`int`)
      For a point set type of PointRange, the number is always two.
      For a point set type of PointList, this is the number of points or cells in the list. 
    * `pnts` : array of point or cell indices used to define the point set  (`numpy.ndarray`)

    - Returns:
    * None

    - Remarks:
    * You must use the `gopath` function to access the node in which you want to write point
      set data.

    """
    
    cdef cgnslib.cgsize_t * pntsptr
    points=PNY.int32(pnts)
    pntsptr=<cgnslib.cgsize_t *>CNY.PyArray_DATA(points)
    self._error=cgnslib.cg_ptset_write(pst,npnts,pntsptr)

  # ------------------------------------------------------------------------------------------  
  cpdef famname_write(self, char * name):

    """
    Writes a family name.
    
    - Args:
    * `name` : family name (`string`)

    - Returns:
    * None

    - Remarks:
    * You must use the `gopath` function to access the node in which you want to write the
      family name.

    """
    
    self._error=cgnslib.cg_famname_write(name)

  # ------------------------------------------------------------------------------------------
  cpdef famname_read(self):

    """
    Returns a family name.
    
    - Args:
    * None

    - Returns:
    * family name (`string`)

    - Remarks:
    * You must use the `gopath` function to access the node in which you want to read the
      family name.

    """
    
    cdef char * name = ""
    self._error=cgnslib.cg_famname_read(name)
    return name

  # ------------------------------------------------------------------------------------------
  cpdef field_write(self, int B, int Z, int S, cgnslib.DataType_t dt, char * name, array):

    """
    Writes flow solution data.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `S` : flow solution id (`int`)
    * `dt` : data type of the solution array (`int`)
      The admissible data types for a solution array are `Integer`, `RealSingle`, and `RealDouble`. 
    * `name` : name of the solution array (`string`)
    * `array` : array of solution values (`numpy.ndarray`)

    - Returns:
    * solution array id (`int`)

    """
    
    cdef int F = -1
    cdef int * iptr
    cdef float * sptr
    cdef double * dptr
    
    if (dt==CK.RealSingle):
      sarray=PNY.float32(array)
      sptr=<float *>CNY.PyArray_DATA(sarray)
      self._error=cgnslib.cg_field_write(self._root,B,Z,S,dt,name,sptr,&F)
    elif (dt==CK.RealDouble):
      darray=PNY.float64(array)
      dptr=<double *>CNY.PyArray_DATA(darray)
      self._error=cgnslib.cg_field_write(self._root,B,Z,S,dt,name,dptr,&F)
    elif (dt==CK.Integer):
      iarray=PNY.int32(array)
      iptr=<int *>CNY.PyArray_DATA(iarray)
      self._error=cgnslib.cg_field_write(self._root,B,Z,S,dt,name,iptr,&F)
    else:
      print "Fourth arg should be CG_RealDouble, CG_RealSingle or CG_Integer"
      return
    return F

  # ------------------------------------------------------------------------------------------
  cpdef nfields(self, int B, int Z, int S):

    """
    Returns the number of flow solution arrays.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `S` : flow solution id (`int`)

    - Returns:
    * number of data arrays in the flow solution node (`int`)

    """
    
    cdef int n = -1
    self._error=cgnslib.cg_nfields(self._root,B,Z,S,&n)
    return n
  
  # ------------------------------------------------------------------------------------------
  cpdef field_info(self, int B, int Z, int S, int F):

    """
    Returns a tuple with information about a flow solution array.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `S` : flow solution id (`int`)
    * `F` : solution array id (`int`)

    - Returns:
    * data type of the solution array (`int`)
    * name of the solution array (`string`)

    """
    
    cdef cgnslib.DataType_t dt
    cdef char * name = " "
    self._error=cgnslib.cg_field_info(self._root,B,Z,S,F,&dt,name)
    return (dt,name)

  # ------------------------------------------------------------------------------------------
  cpdef field_read(self, int B, int Z, int S, char * name, cgnslib.DataType_t dt,
                   rmin, rmax):

    """
    Reads flow solution data for a given range.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `S` : flow solution id (`int`)
    * `dt` : data type of the solution array (`int`)
      The admissible data types for a solution array are `Integer`, `RealSingle`, and `RealDouble`. 
    * `rmin` : lower range index (`numpy.ndarray`)
    * `rmax` : upper range index (`numpy.ndarray`)

    - Returns:
    * array of solution values for the range [`rmin`,`rmax`] (`numpy.ndarray`)

    - Remarks:
    * The requested data type can be different as the one in which the solution values are recorded
      in the file. 

    """
    
    cdef cgnslib.cgsize_t * rminptr
    cdef cgnslib.cgsize_t * rmaxptr
    cdef int * iptr
    cdef float * sptr
    cdef double * dptr
    
    ndim=self.base_read(B)[2]
    rminarray=PNY.int32(rmin)
    rmaxarray=PNY.int32(rmax)
    rminptr=<cgnslib.cgsize_t *>CNY.PyArray_DATA(rminarray) 
    rmaxptr=<cgnslib.cgsize_t *>CNY.PyArray_DATA(rmaxarray)
    irng=[rmaxarray[i]-rminarray[i]+1 for i in range(ndim)]
    array=PNY.ones((irng[0],irng[1],irng[2]))    

    if (dt==CK.RealSingle):
      sarray=PNY.float32(array)
      sptr=<float *>CNY.PyArray_DATA(sarray)
      self._error=cgnslib.cg_field_read(self._root,B,Z,S,name,dt, rminptr,rmaxptr,sptr)
      return sarray
    elif (dt==CK.RealDouble):
      darray=PNY.float64(array)
      dptr=<double *>CNY.PyArray_DATA(darray)
      self._error=cgnslib.cg_field_read(self._root,B,Z,S,name,dt,rminptr,rmaxptr,dptr)
      return darray
    elif (dt==CK.Integer):
      iarray=PNY.int32(array)
      iptr=<int *>CNY.PyArray_DATA(iarray)
      self._error=cgnslib.cg_field_read(self._root,B,Z,S,name,dt,rminptr,rmaxptr,iptr)
      return iarray
    else:
      print "Fourth arg should be CG_RealDouble, CG_RealSingle or CG_Integer"
      return       
     
  # ------------------------------------------------------------------------------------------
  cpdef field_id(self, int B, int Z, int S, int F):
    cdef double fid = -1
    self._error=cgnslib.cg_field_id(self._root,B,Z,S,F,&fid)
    return fid

  # ------------------------------------------------------------------------------------------
  cpdef field_partial_write(self, int B, int Z, int S, cgnslib.DataType_t dt, char * name,
                            rmin, rmax, array):

    """
    Writes flow solution data for a given range.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `S` : flow solution id (`int`)
    * `dt` : data type of the solution array (`int`)
      The admissible data types for a solution array are `Integer`, `RealSingle`, and `RealDouble`. 
    * `name` : name of the solution array (`string`)
    * `rmin` : lower range index (`numpy.ndarray`)
    * `rmax` : upper range index (`numpy.ndarray`)
    * `array` : array of solution values (`numpy.ndarray`)

    - Returns:
    * solution array id (`int`)

    """

    cdef int F = -1
    cdef int * iptr
    cdef float * sptr
    cdef double * dptr
    ndim=self.base_read(B)[2]
    rminarray=PNY.int32(rmin)
    rmaxarray=PNY.int32(rmax)
    rminptr=<cgnslib.cgsize_t *>CNY.PyArray_DATA(rminarray) 
    rmaxptr=<cgnslib.cgsize_t *>CNY.PyArray_DATA(rmaxarray)
    if (dt==CK.RealSingle):
      sarray=PNY.float32(array)
      sptr=<float *>CNY.PyArray_DATA(sarray)
      self._error=cgnslib.cg_field_partial_write(self._root,B,Z,S,dt,name,rminptr,rmaxptr,sptr,&F)
    elif (dt==CK.RealDouble):
      darray=PNY.float64(array)
      dptr=<double *>CNY.PyArray_DATA(darray)
      self._error=cgnslib.cg_field_partial_write(self._root,B,Z,S,dt,name,rminptr,rmaxptr,dptr,&F)
    elif (dt==CK.Integer):
      iarray=PNY.int32(array)
      iptr=<int *>CNY.PyArray_DATA(iarray)
      self._error=cgnslib.cg_field_partial_write(self._root,B,Z,S,dt,name,rminptr,rmaxptr,iptr,&F)
    else:
      print "Fourth arg should be CG_RealDouble, CG_RealSingle or CG_Integer"
      return
    return F

  # ------------------------------------------------------------------------------------------
  cpdef sol_ptset_write(self, int B, int Z, char * name, cgnslib.GridLocation_t loc,
                        cgnslib.PointSetType_t pst, cgnslib.cgsize_t npnts, pnts):

    """
    Creates a point set flow solution node.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `name` : name of the flow solution node (`string`)
    * `loc` : grid location used to write the solution (`int`)
      The admissible locations are `Vertex`, `IFaceCenter`, `JFaceCenter` and `KFaceCenter`. 
    * `pst` : point set type defining the interface for the solution data (`int`)
    * `npnts` : number of points defining the interface for the solution data (`int`)
    * `pnts` : array of points defining the interface for the solution data (`numpy.ndarray`)

    - Returns:
    * flow solution id (`int`)
   
    """
      
    cdef int S = -1
    cdef cgnslib.cgsize_t * pntsptr
    array=PNY.int32(pnts)
    pntsptr=<cgnslib.cgsize_t *>CNY.PyArray_DATA(array)
    self._error=cgnslib.cg_sol_ptset_write(self._root,B,Z,name,loc,pst,npnts,pntsptr,&S)
    return S

  # ------------------------------------------------------------------------------------------
  cpdef sol_ptset_info(self, int B, int Z, int S):

    """
    Returns a tuple with information about a point set flow solution node.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `S` : flow solution id (`int`)

    - Returns:
    * point set type defining the interface for the solution data (`int`)
    * number of points defining the interface for the solution data (`int`)
    
    """
      
    cdef cgnslib.PointSetType_t pst
    cdef cgnslib.cgsize_t npnts
    self._error=cgnslib.cg_sol_ptset_info(self._root,B,Z,S,&pst,&npnts)
    return (pst,npnts)

  # ------------------------------------------------------------------------------------------
  cpdef sol_ptset_read(self, int B, int Z, int S):

    """
    Returns the array of points which defines the interface for solution data. 
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `S` : flow solution id (`int`)

    - Returns:
    * array of points defining the interface for the solution data (`numpy.ndarray`)
   
    """
    
    cdef cgnslib.cgsize_t * pntsptr      
    ndim=self.base_read(B)[2]
    npnts=self.sol_ptset_info(B,Z,S)[1]
    pnts=PNY.ones((npnts,ndim),dtype=PNY.int32)
    pntsptr=<cgnslib.cgsize_t *>CNY.PyArray_DATA(pnts)
    self._error=cgnslib.cg_sol_ptset_read(self._root,B,Z,S,pntsptr)
    return pnts

  # ------------------------------------------------------------------------------------------
  cpdef subreg_ptset_write(self, int  B, int Z, char * regname, int dim, cgnslib.GridLocation_t loc,
                           cgnslib.PointSetType_t pst, cgnslib.cgsize_t npnts,pnts):

    """
    Creates a point set zone subregion node.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `regname` : name of the zone subregion node (`string`)
    * `dim` : dimensionality of the subregion (`int`)
      The dimensionality equals 1 for lines, 2 for faces and 3 for volumes.
    * `loc` : grid location used to define the point set (`int`)
      The admissible locations are `Vertex` and `CellCenter`.
    * `pst` : point set type defining the interface for the zone subregion data (`int`)
    * `npnts` : number of points defining the interface for the subregion data (`int`)
    * `pnts` : array of points defining the interface for the zone subregion data (`numpy.ndarray`)

    - Returns:
    * zone subregion id (`int`)
   
    """
    
    cdef int S = -1
    cdef cgnslib.cgsize_t * pntsptr
    array=PNY.int32(pnts)
    pntsptr=<cgnslib.cgsize_t *>CNY.PyArray_DATA(array)
    self._error=cgnslib.cg_subreg_ptset_write(self._root,B,Z,regname,dim,loc,pst,npnts,pntsptr,&S)
    return S

  # ------------------------------------------------------------------------------------------
  cpdef subreg_bcname_write(self, int B, int Z, char * regname, int dim, char * bcname):

    """
    Creates a zone subregion node that references a boundary condition node.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `regname` : name of the zone subregion node (`string`)
    * `dim` : dimensionality of the subregion (`int`)
      The dimensionality equals 1 for lines, 2 for faces and 3 for volumes.
    * `bcname` : name of the boundary condition node defining the zone subregion (`string`)

    - Returns:
    * zone subregion id (`int`)

    """
    
    cdef int S = -1
    self._error=cgnslib.cg_subreg_bcname_write(self._root,B,Z,regname,dim,bcname,&S)
    return S

  # ------------------------------------------------------------------------------------------
  cpdef subreg_gcname_write(self, int B, int Z, char *regname, int dim, char * gcname):

    """
    Creates a zone subregion node that references a grid connectivity node.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `regname` : name of the zone subregion node (`string`)
    * `dim` : dimensionality of the subregion (`int`)
      The dimensionality equals 1 for lines, 2 for faces and 3 for volumes.
    * `gcname` : name of the generalized grid connectivity node or name of the 1to1 grid connectivity
      node defining the zone subregion (`string`)

    - Returns:
    * zone subregion id (`int`)

    """
    
    cdef int S = -1
    self._error=cgnslib.cg_subreg_gcname_write(self._root,B,Z,regname,dim,gcname,&S)
    return S

  # ------------------------------------------------------------------------------------------
  cpdef nsubregs(self, int B, int Z):

    """
    Returns the number of zone subregion nodes.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)

    - Returns:
    * number of zone subregion nodes in the zone (`int`)

    """
    
    cdef int n = -1
    self._error=cgnslib.cg_nsubregs(self._root,B,Z,&n)
    return n

  # ------------------------------------------------------------------------------------------
  cpdef subreg_info(self, int B, int Z, int S):

    """
    Returns a tuple with information about a zone subregion node.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `S` : zone subregion id (`int`)

    - Returns:
    * name of the zone subregion node (`string`)
    * dimensionality of the subregion (`int`)
      The dimensionality equals 1 for lines, 2 for faces and 3 for volumes.
    * grid location used to define the point set (`int`)
      The admissible locations are `Vertex` and `CellCenter`.
    * point set type defining the interface for the subregion data (`int`)
    * number of points defining the interface for the subregion data (`int`)
    * string length of a boundary condition node name (`int`)
    * string length of a grid connectivity node name (`int`)

    """
      
    cdef char * regname = ""
    cdef int dim = -1
    cdef cgnslib.GridLocation_t loc
    cdef cgnslib.PointSetType_t pst
    cdef cgnslib.cgsize_t npnts
    cdef int bcl = -1
    cdef int gcl = -1
    self._error=cgnslib.cg_subreg_info(self._root,B,Z,S,regname,&dim,&loc,&pst,&npnts,&bcl,&gcl)
    return (regname,dim,loc,pst,npnts,bcl,gcl)

  # ------------------------------------------------------------------------------------------
  cpdef subreg_ptset_read(self, int B, int Z, int S):

    """
    Returns the array of points defining a zone subregion interface.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `S` : zone subregion id (`int`)

    - Returns:
    * array of points defining the interface for the zone subregion data (`numpy.ndarray`)
   
    """
    
    cdef cgnslib.cgsize_t * pntsptr
    npnts=self.subreg_info(B,Z,S)[4]
    ndim=self.base_read(B)[2]
    pnts=PNY.ones((npnts,ndim),dtype=PNY.int32)
    pntsptr=<cgnslib.cgsize_t *>CNY.PyArray_DATA(pnts)
    self._error=cgnslib.cg_subreg_ptset_read(self._root,B,Z,S,pntsptr)
    return pnts

  # ------------------------------------------------------------------------------------------
  cpdef subreg_bcname_read(self, int B, int Z, int S):

    """
    Returns the boundary condition node name for a zone subregion node.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `S` : zone subregion id (`int`)

    - Returns:
    * name of the boundary condition node defining the subregion (`string`)

    """
    
    cdef char * bcname = ""
    self._error=cgnslib.cg_subreg_bcname_read(self._root,B,Z,S,bcname)
    return bcname

  # ------------------------------------------------------------------------------------------
  cpdef subreg_gcname_read(self, int B, int Z, int S):

    """
    Returns the grid connectivity node name for a zone subregion node.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `S` : zone subregion id (`int`)

    - Returns:
    * name of the generalized grid connectivity node or name of the 1to1 grid connectivity node
      which defines the subregion (`string`)

    """
    
    cdef char * gcname = ""
    self._error=cgnslib.cg_subreg_gcname_read(self._root,B,Z,S,gcname)
    return gcname

  # ------------------------------------------------------------------------------------------
  cpdef hole_write(self, int B, int Z, char * name, cgnslib.GridLocation_t loc,
                   cgnslib.PointSetType_t pst, int nptsets, cgnslib.cgsize_t npnts,
                   pnts):

    """
    Creates an overset hole data node.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `name` : name of the overset hole (`string`)
    * `loc` : grid location used to define the point set (`int`)
    * `pst` : point set type used to define the hole (`int`)
    * `nptsets` : number of point sets used to define the hole (`int`)
    * `npnts` : number of points or cells in the point set (`int`)
    * `pnts` : array of points or cells in the point set (`numpy.ndarray`)

    - Returns:
    * overset hole id (`int`)

    """
    
    cdef int I = -1
    cdef cgnslib.cgsize_t * pntsptr
    array=PNY.int32(pnts)
    pntsptr=<cgnslib.cgsize_t *>CNY.PyArray_DATA(array)
    self._error=cgnslib.cg_hole_write(self._root,B,Z,name,loc,pst,nptsets,npnts,pntsptr,&I)
    return I

  # ------------------------------------------------------------------------------------------
  cpdef nholes(self, int B, int Z):

    """
    Returns the number of overset hole data nodes.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)

    - Returns:
    * number of overset hole data nodes in the zone (`int`)

    """
    
    cdef int n = -1
    self._error=cgnslib.cg_nholes(self._root,B,Z,&n)
    return n

  # ------------------------------------------------------------------------------------------
  cpdef hole_info(self, int B, int Z, int I):

    """
    Returns a tuple with information about an overset hole data node.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `I` : overset hole id (`int`)

    - Returns:
    * name of the overset hole (`string`)
    * grid location used to define the point set (`int`)
    * point set type used to define the hole (`int`)
    * number of point sets used to define the hole (`int`)
    * number of points or cells in the point set (`int`)

    """
    
    cdef char * name = ""
    cdef cgnslib.GridLocation_t loc
    cdef cgnslib.PointSetType_t pst
    cdef int nptsets = -1
    cdef cgnslib.cgsize_t npnts
    self._error=cgnslib.cg_hole_info(self._root,B,Z,I,name,&loc,&pst,&nptsets,&npnts)
    return (name,loc,pst,nptsets,npnts)

  # ------------------------------------------------------------------------------------------
  cpdef hole_read(self, int B, int Z, int I):

    """
    Returns the array of points defining an overset hole.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `I` : overset hole id (`int`)

    - Returns:
    * array of points or cells in the point set (`numpy.ndarray`)

    """

    cdef cgnslib.cgsize_t * pntsptr 
    npnts=self.hole_info(B,Z,I)[4]
    ndim=self.base_read(B)[2]
    pnts=PNY.ones((npnts,ndim),dtype=PNY.int32)
    pntsptr=<cgnslib.cgsize_t *>CNY.PyArray_DATA(pnts)
    self._error=cgnslib.cg_hole_read(self._root,B,Z,I,pntsptr)
    return pnts

  # ------------------------------------------------------------------------------------------
  cpdef hole_id(self, int B, int Z, int I):
    cdef double hid
    self._error=cgnslib.cg_hole_id(self._root,B,Z,I,&hid)
    return hid


  # ------------------------------------------------------------------------------------------
  cpdef rigid_motion_write(self, int B, int Z, char * name, cgnslib.RigidGridMotionType_t rgmt):

    """
    Creates a rigid grid motion node.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `name` : name of the node (`string`)
    * `rgmt` : rigid grid motion type (`int`)

    - Returns:
    * rigid grid motion id (`int`)

    """
    
    cdef int R = -1
    self._error=cgnslib.cg_rigid_motion_write(self._root,B,Z,name,rgmt,&R)
    return R

  # ------------------------------------------------------------------------------------------
  cpdef n_rigid_motions(self, int B, int Z):

    """
    Returns the number of rigid grid motion nodes.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)

    - Returns:
    * number of rigid grid motions in the zone (`int`)

    """
    
    cdef int nrm = -1
    self._error=cgnslib.cg_n_rigid_motions(self._root,B,Z,&nrm)
    return nrm

  # ------------------------------------------------------------------------------------------
  cpdef rigid_motion_read(self, int B, int Z, int R):

    """
    Returns a tuple with information about a rigid grid motion node.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `R` : arbitrary grid motion id (`int`)

    - Returns:
    * name of the node (`string`)
    * rigid grid motion type (`int`)

    """
    
    cdef char * name = " "
    cdef cgnslib.RigidGridMotionType_t rgmt
    print cgnslib.cg_get_error()
    self._error=cgnslib.cg_rigid_motion_read(self._root,B,Z,R,name,&rgmt)
    return (name,rgmt)

  # ------------------------------------------------------------------------------------------
  cpdef arbitrary_motion_read(self, int B, int Z, int A):

    """
    Returns a tuple with information about an arbitrary grid motion node.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `A` : arbitrary grid motion id (`int`)

    - Returns:
    * name of the node (`string`)
    * arbitrary grid motion type (`int`)

    """
    
    cdef char * name = ""
    cdef cgnslib.ArbitraryGridMotionType_t agmt 
    self._error=cgnslib.cg_arbitrary_motion_read(self._root,B,Z,A,name,&agmt)    
    return (name,agmt)

  # ------------------------------------------------------------------------------------------
  cpdef arbitrary_motion_write(self, int B, int Z, char * name,
                               cgnslib.ArbitraryGridMotionType_t agmt):

    """
    Creates an arbitrary grid motion node.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `name` : name of the node (`string`)
    * `agmt` : arbitrary grid motion type (`int`)

    - Returns:
    * arbitrary grid motion id (`int`)

    """
    
    cdef int A = -1
    self._error=cgnslib.cg_arbitrary_motion_write(self._root,B,Z,name,agmt,&A)
    return A

  # ------------------------------------------------------------------------------------------
  cpdef n_arbitrary_motions(self, int B, int Z):

    """
    Returns the number of arbitrary grid motion nodes.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)

    - Returns:
    * number of arbitrary grid motion nodes in the zone (`int`)

    """
    
    cdef int n = -1
    self._error=cgnslib.cg_n_arbitrary_motions(self._root,B,Z,&n)
    return n

  # ------------------------------------------------------------------------------------------
  cpdef simulation_type_write(self, int B, cgnslib.SimulationType_t st):

    """
    Writes the simulation type.
    
    - Args:
    * `B` : base id (`int`)
    * `st` : simulation type (`int`)

    - Returns:
    * None

    """
    
    self._error=cgnslib.cg_simulation_type_write(self._root,B,st)

  # ------------------------------------------------------------------------------------------
  cpdef simulation_type_read(self, int B):

    """
    Reads the simulation type.
    
    - Args:
    * `B` : base id (`int`)

    - Returns:
    * simulation type (`int`)

    """
    
    cdef cgnslib.SimulationType_t st
    self._error=cgnslib.cg_simulation_type_read(self._root,B,&st)
    return st

  # ------------------------------------------------------------------------------------------
  cpdef biter_write(self, int B, char * name, int nsteps):

    """
    Writes the number of iterations.
    
    - Args:
    * `B` : base id (`int`)
    * `name` : name of the node (`string`)
    * `nsteps` : number of time steps or iterations (`int`)

    - Returns:
    * None

    """
    
    self._error=cgnslib.cg_biter_write(self._root,B,name,nsteps)

  # ------------------------------------------------------------------------------------------
  cpdef biter_read(self, int B):

    """
    Returns the number of iterations.
    
    - Args:
    * `B` : base id (`int`)

    - Returns:
    * `nsteps` : number of time steps or iterations (`int`)
    
    """
    
    cdef char * name = ""
    cdef int nsteps = -1
    self._error=cgnslib.cg_biter_read(self._root,B,name,&nsteps)
    return nsteps

  # ------------------------------------------------------------------------------------------
  cpdef ziter_write(self, int B, int Z, char * zname):

    """
    Creates a `ZoneIterativeData_t` node.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `zname` : name of the node (`string`)

    - Returns:
    * None

    - Remarks:
    * If there are no `BaseIterativeData_t` nodes in the tree, the `ziter_read` function can't read
      the name of the node. That's why, you must create a `BaseIterativeData_t` node with a
      `ZoneIterativeData_t` node.

    """
    
    self._error=cgnslib.cg_ziter_write(self._root,B,Z,zname)

  # ------------------------------------------------------------------------------------------
  cpdef ziter_read(self, int B, int Z):

    """
    Reads the name of a `ZoneIterativeData_t` node.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)

    - Returns:
    * name of the node (`string`)

    - Remarks:
    * If there are no `BaseIterativeData_t` nodes in the tree, the `ziter_read` function can't read
      the name of the node. That's why, you must create a `BaseIterativeData_t` node with a
      `ZoneIterativeData_t` node.

    """
    
    cdef char * zname = ""
    biter=self.biter_read(B)
    if (biter<0):
      print 'You must create a BaseIterativeData_t t node to read the ZoneIterativeData_t node'
      return
    else:
      self._error=cgnslib.cg_ziter_read(self._root,B,Z,zname)
      return zname

  # ------------------------------------------------------------------------------------------
  cpdef gravity_write(self, B, gvector):

    """
    Creates a `Gravity_t` node containing the gravity vector coordinates.
    
    - Args:
    * `B` : base id (`int`)
    * `gravector` : array of size equal to the physicial dimensions of the base which stores
      the gravity vector components (`numpy.ndarray`)

    - Returns:
    * None

    """
  
    cdef float * vectorptr
    gravity_vector=PNY.float32(gvector)
    vectorptr=<float *>CNY.PyArray_DATA(gravity_vector)
    self._error=cgnslib.cg_gravity_write(self._root,B,vectorptr)

  # ------------------------------------------------------------------------------------------
  cpdef gravity_read(self, B):
 
    """
    Returns the gravity vector coordinates.
    
    - Args:
    * `B` : base id (`int`)

    - Returns:
    * array of size equal to the physicial dimensions of the base which stores
      the gravity vector components (`numpy.ndarray`)

    """
  
    cdef float * vectorptr
    pdim=self.base_read(B)[3]
    vector=PNY.ones((pdim,),dtype=PNY.float32)
    vectorptr=<float *>CNY.PyArray_DATA(vector)
    self._error=cgnslib.cg_gravity_read(self._root,B,vectorptr)
    return vector

  # ------------------------------------------------------------------------------------------
  cpdef axisym_write(self, int B, refpt, axis):

    """
    Creates a `Axisymmetry_t` node which stores axisymmetry data.
    
    - Args:
    * `B` : base id (`int`)
    * `refpt` : array of 2 elements containing the origin coordinates used for defining the
      rotation axis (`numpy.ndarray`)
    * `axis` : array of 2 elements containing the direction cosines of the rotation axis
      (`numpy.ndarray`)

    - Returns:
    * None

    - Remarks:
    * This function can only be used if the physical dimensions of the base are equal to 2.

    """
    
    cdef float * refptptr
    cdef float * axisptr
    refpoint=PNY.float32(refpt)
    ax=PNY.float32(axis)
    refptptr=<float *>CNY.PyArray_DATA(refpoint)
    axisptr=<float *>CNY.PyArray_DATA(ax)
    self._error=cgnslib.cg_axisym_write(self._root,B,refptptr,axisptr)

  # ------------------------------------------------------------------------------------------
  cpdef axisym_read(self, int B):

    """
    Returns a tuple with information about the axisymmetry data.
    
    - Args:
    * `B` : base id (`int`)
    
    - Returns:
    * array of 2 elements containing the origin coordinates used for defining the rotation axis
      (`numpy.ndarray`)
    * array of 2 elements containing the direction cosines of the rotation axis (`numpy.ndarray`)

    """
    
    cdef float * refptptr
    cdef float * axisptr
    refpoint=PNY.ones((2,),dtype=PNY.float32)
    ax=PNY.ones((2,),dtype=PNY.float32)
    refptptr=<float *>CNY.PyArray_DATA(refpoint)
    axisptr=<float *>CNY.PyArray_DATA(ax)
    self._error=cgnslib.cg_axisym_read(self._root,B,refptptr,axisptr)
    return (refpoint,ax)

  # ------------------------------------------------------------------------------------------
  cpdef rotating_write(self, rotrate, rotcenter):

    """
    Creates a rotating coordinates data node.
    
    - Args:
    * `rotrate` : components of the angular velocity of the grid about the center of rotation
      (`numpy.ndarray`)
    * `rotcenter` : coordinates of the center of rotation (`numpy.ndarray`)

    - Returns:
    * None

    - Remarks:
    * You must use the `gopath` function to access the node in which you want to create the rotating
      coordinates data.

    """
    
    cdef float * rateptr
    cdef float * rotptr
    rate=PNY.float32(rotrate)
    rot=PNY.float32(rotcenter)
    rateptr=<float *>CNY.PyArray_DATA(rate)
    rotptr=<float *>CNY.PyArray_DATA(rot)
    self._error=cgnslib.cg_rotating_write(rateptr,rotptr)

  # ------------------------------------------------------------------------------------------
##   cpdef rotating_read(self):

##     """
##     Returns a tuple with information about the rotating coordinates.
    
##     - Args:
##     * None
    
##     - Returns:
##     * components of the angular velocity of the grid about the center of rotation (`numpy.ndarray`)
##     * coordinates of the center of rotation (`numpy.ndarray`)

##     - Remarks:
##     * You must use the `gopath` function to access the node in which you want to read rotating coordinates data.

##     """
    
##     cdef float * rateptr
##     cdef float * rotptr
##     B=self.where()[1]
##     pdim=self.base_read(B)[3]
##     rate=PNY.ones((pdim,),dtype=PNY.float32)
##     rot=PNY.ones((pdim,),dtype=PNY.float32)
##     rateptr=<float *>CNY.PyArray_DATA(rate)
##     rotptr=<float *>CNY.PyArray_DATA(rot)
##     self._error=cgnslib.cg_rotating_read(rateptr,rotptr)
##     return (rate,rot)

  # ------------------------------------------------------------------------------------------
  cpdef bc_wallfunction_write(self, int B, int Z, int BC, cgnslib.WallFunctionType_t wft):

    """
    Creates a `WallFunction_t` node which stores data about the wall functions.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `BC` : boundary condition id (`int`)
    * `wft` : wall function type (`int`)

    - Returns:
    * None

    - Remarks:
    * The `WallFunction_t` nodes  are stored in the `BCProperty_t` nodes.
      If no nodes of this kind exists, the function `bc_area_write` will create
      a `BCProperty_t` node.
    * Several `WallFunction_t` nodes may be created under the same `BCProperty_t`
      node.

    """
    
    self._error=cgnslib.cg_bc_wallfunction_write(self._root,B,Z,BC,wft)

  # ------------------------------------------------------------------------------------------
  cpdef bc_wallfunction_read(self, int B, int Z, int BC):

    """
    Returns a tuple with information about the wall functions.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `BC` : boundary condition id (`int`)

    - Returns:
    * wall function type (`int`)

    """
    
    cdef cgnslib.WallFunctionType_t wft
    self._error=cgnslib.cg_bc_wallfunction_read(self._root,B,Z,BC,&wft)
    return wft

  # ------------------------------------------------------------------------------------------
  cpdef bc_area_write(self, int B, int Z, int BC, cgnslib.AreaType_t atype, float sarea, char * name):

    """
    Creates a `Area_t` node which stores boundary condition properties.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `BC` : boundary condition id (`int`)
    * `atype` : type of area (`int`)
    * `sarea` : size of the area (`float`)
    * `name` : region name (`string`)

    - Returns:
    * None

    - Remarks:
    * The `Area_t` nodes  are stored in the `BCProperty_t` nodes.
      If no nodes of this kind exists, the function `bc_area_write` will create
      a `BCProperty_t` node.
    * Several `Area_t` nodes may be created under the same `BCProperty_t`
      node.

    """
    
    self._error=cgnslib.cg_bc_area_write(self._root,B,Z,BC,atype,sarea,name)

  # ------------------------------------------------------------------------------------------
  cpdef bc_area_read(self, int B, int Z, int BC):

    """
    Returns a tuple with information about the boundary condition properties.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `BC` : boundary condition id (`int`)

    - Returns:
    * type of area (`int`)
    * size of the area (`float`)
    * region name (`string`)

    """
    
    cdef cgnslib.AreaType_t atype
    cdef float sarea
    cdef char * name = ""
    self._error=cgnslib.cg_bc_area_read(self._root,B,Z,BC,&atype,&sarea,name)
    return (atype,sarea,name)

  # ------------------------------------------------------------------------------------------
  cpdef conn_periodic_write(self, int B, int Z, int I, rotcenter, rotangle, tr):

    """
    Creates a `Periodic_t` node which stores data for periodic interfaces in the case of
    generalized connectivities.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `I` : grid connectivity id (`int`)
    * `rotcenter` : array of size equal to the physical dimensions which contains the coordinates
      of the origin for defining the rotation angle between the periodic interfaces (`numpy.ndarray`)
    * `rotangle` : array of size equal to the physical dimensions which stores the rotation angle
      from the current interface to the connecting interface (`numpy.ndarray`)
    * `tr` : array of size equal to the physical dimensions which contains the translation from
      the current interface to the connecting interface (`numpy.ndarray`)

    - Returns:
    * None

    - Remarks:
    * The `Periodic_t` nodes  are contained in the `GridConnectivityProperty_t` nodes.
      If no nodes of this kind exists, the function `_1to1_periodic_write` will create
      a `GridConnectivityProperty_t` node.
    * Several `Periodic_t` nodes may be created under the same `GridConnectivityProperty_t`
      node.

    """
    
    cdef float * rotcenterptr
    cdef float * rotangleptr
    cdef float * translationptr
    center=PNY.float32(rotcenter)
    angle=PNY.float32(rotangle)
    translation=PNY.float32(tr)
    rotcenterptr=<float *>CNY.PyArray_DATA(center)
    rotangleptr=<float *>CNY.PyArray_DATA(angle)
    translationptr=<float *>CNY.PyArray_DATA(translation)
    self._error=cgnslib.cg_conn_periodic_write(self._root,B,Z,I,rotcenterptr,rotangleptr,translationptr)

  # ------------------------------------------------------------------------------------------
  cpdef conn_periodic_read(self, int B, int Z, int I):
    cdef float * rotcenterptr

    """
    Returns a tuple with data about periodic interfaces contained in the `GridConnectivityProperty_t` node
    for generalized grid connectivities.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `I` : grid connectivity id (`int`)      

    - Returns:
    * array of size equal to the physical dimensions which contains the coordinates
      of the origin for defining the rotation angle between the periodic interfaces (`numpy.ndarray`)
    * array of size equal to the physical dimensions which stores the rotation angle
      from the current interface to the connecting interface (`numpy.ndarray`)
    * array of size equal to the physical dimensions which contains the translation from
      the current interface to the connecting interface (`numpy.ndarray`)

    """
    
    cdef float * rotangleptr
    cdef float * translationptr
    pdim=self.base_read(B)[3]
    center=PNY.ones((pdim,),dtype=PNY.float32)
    angle=PNY.ones((pdim,),dtype=PNY.float32)
    translation=PNY.ones((pdim,),dtype=PNY.float32)
    rotcenterptr=<float *>CNY.PyArray_DATA(center)
    rotangleptr=<float *>CNY.PyArray_DATA(angle)
    translationptr=<float *>CNY.PyArray_DATA(translation)
    self._error=cgnslib.cg_conn_periodic_read(self._root,B,Z,I,rotcenterptr,rotangleptr,translationptr)
    return (center,angle,translation)

  # ------------------------------------------------------------------------------------------
  cpdef _1to1_periodic_write(self, int B, int Z, int I, rotcenter, rotangle, tr):

    """
    Creates a `Periodic_t` node which stores data for periodic interfaces in the case of
    1-to-1 grid connectivities.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `I` : grid connectivity id (`int`)
    * `rotcenter` : array of size equal to the physical dimensions which contains the coordinates
      of the origin for defining the rotation angle between the periodic interfaces (`numpy.ndarray`)
    * `rotangle` : array of size equal to the physical dimensions which stores the rotation angle
      from the current interface to the connecting interface (`numpy.ndarray`)
    * `tr` : array of size equal to the physical dimensions which contains the translation from
      the current interface to the connecting interface (`numpy.ndarray`)

    - Returns:
    * None

    - Remarks:
    * The `Periodic_t`  nodes are contained in the `GridConnectivityProperty_t` nodes.
      If no nodes of this kind exists, the function `_1to1_periodic_write` will create
      a `GridConnectivityProperty_t` node.
    * Several `Periodic_t` nodes may be created under the same `GridConnectivityProperty_t`
      node.

    """
    
    cdef float * rotcenterptr
    cdef float * rotangleptr
    cdef float * translationptr
    center=PNY.float32(rotcenter)
    angle=PNY.float32(rotangle)
    translation=PNY.float32(tr)
    rotcenterptr=<float *>CNY.PyArray_DATA(center)
    rotangleptr=<float *>CNY.PyArray_DATA(angle)
    translationptr=<float *>CNY.PyArray_DATA(translation)
    self._error=cgnslib.cg_1to1_periodic_write(self._root,B,Z,I,rotcenterptr,rotangleptr,translationptr)

  # ------------------------------------------------------------------------------------------
  cpdef _1to1_periodic_read(self, int B, int Z, int I):

    """
    Returns a tuple with data about periodic interfaces contained in the `GridConnectivityProperty_t` node
    for 1-to-1 grid connectivities.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `I` : grid connectivity id (`int`)      

    - Returns:
    * array of size equal to the physical dimensions which contains the coordinates
      of the origin for defining the rotation angle between the periodic interfaces (`numpy.ndarray`)
    * array of size equal to the physical dimensions which stores the rotation angle
      from the current interface to the connecting interface (`numpy.ndarray`)
    * array of size equal to the physical dimensions which contains the translation from
      the current interface to the connecting interface (`numpy.ndarray`)

    """
    
    cdef float * rotcenterptr
    cdef float * rotangleptr
    cdef float * translationptr
    pdim=self.base_read(B)[3]
    center=PNY.ones((pdim,),dtype=PNY.float32)
    angle=PNY.ones((pdim,),dtype=PNY.float32)
    translation=PNY.ones((pdim,),dtype=PNY.float32)
    rotcenterptr=<float *>CNY.PyArray_DATA(center)
    rotangleptr=<float *>CNY.PyArray_DATA(angle)
    translationptr=<float *>CNY.PyArray_DATA(translation)
    self._error=cgnslib.cg_1to1_periodic_read(self._root,B,Z,I,rotcenterptr,rotangleptr,translationptr)
    return (center,angle,translation)

  # ------------------------------------------------------------------------------------------
  cpdef conn_average_write(self, int B, int Z, int I, cgnslib.AverageInterfaceType_t ait):

    """
    Creates a `AverageInterface_t` node which stores the type of averaging applied to
    generalized grid connectivities. 
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `I` : grid connectivity id (`int`)
    * `ait` : type of averaging for the interface (`int`)      

    - Returns:
    * None

    - Remarks:
    * The `AverageInterface_t` nodes are contained in the `GridConnectivityProperty_t` nodes.
      If no nodes of this kind exists, the function `_1to1_average_write` will create
      a `GridConnectivityProperty_t` node.
    * Several `AverageInterface_t` nodes may be created under the same `GridConnectivityProperty_t`
      node.

    """
    
    self._error=cgnslib.cg_conn_average_write(self._root,B,Z,I,ait)

  # ------------------------------------------------------------------------------------------
  cpdef conn_average_read(self, int B, int Z, int I):

    """
    Returns the type of averaging recorded under the `GridConnectivityProperty_t` node applied
    to generalized grid connectivities.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `I` : grid connectivity id (`int`)      

    - Returns:
    * type of averaging for the interface (`int`)

    """
    
    cdef cgnslib.AverageInterfaceType_t ait
    self._error=cgnslib.cg_conn_average_read(self._root,B,Z,I,&ait)
    return ait

  # ------------------------------------------------------------------------------------------
  cpdef _1to1_average_write(self, int B, int Z, int I, cgnslib.AverageInterfaceType_t ait):

    """
    Creates a `AverageInterface_t` node which stores the type of averaging applied to
    1-to-1 grid connectivities. 
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `I` : grid connectivity id (`int`)
    * `ait` : type of averaging for the interface (`int`)      

    - Returns:
    * None

    - Remarks:
    * The `AverageInterface_t` nodes are contained in the `GridConnectivityProperty_t` nodes.
      If no nodes of this kind exists, the function `_1to1_average_write` will create
      a `GridConnectivityProperty_t` node.
    * Several `AverageInterface_t` nodes may be created under the same `GridConnectivityProperty_t`
      node.

    """

    self._error=cgnslib.cg_1to1_average_write(self._root,B,Z,I,ait)

  # ------------------------------------------------------------------------------------------
  cpdef _1to1_average_read(self, int B, int Z, int I):

    """
    Returns the type of averaging recorded under the `GridConnectivityProperty_t` node applied to
    1-to-1 grid connectivities.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `I` : grid connectivity id (`int`)      

    - Returns:
    * type of averaging for the interface (`int`)

    """
    
    cdef cgnslib.AverageInterfaceType_t ait
    self._error=cgnslib.cg_1to1_average_read(self._root,B,Z,I,&ait)
    return ait

  # ------------------------------------------------------------------------------------------
  cpdef rind_write(self, data):

    """
    Creates a linked node at the current location. 
    
    
    - Args:
    * `data` : number of rind layers for each computational direction in the case of a structured
      grid, otherwise number of rind points or elements for unstructured grids (`numpy.ndarray`)

    - Returns:
    * None

    """
    
    cdef int * dataptr
    rdata=PNY.int32(data)
    dataptr=<int *>CNY.PyArray_DATA(rdata)
    self._error=cgnslib.cg_rind_write(dataptr)

  # ------------------------------------------------------------------------------------------
  cpdef rind_read(self):
    pass
#     cdef int * dataptr
#     ztype=self.zone_type(B,Z)
#     pdim=self.base_read(B)[3]
#     if (ztype==CK.Unstructured):
#       dim=1
#     elif (ztype==CK.Structured):
#       dim=self.base_read(B)[2]

  # ------------------------------------------------------------------------------------------
  cpdef link_write(self, char * nodename, char * filename, char * name_in_file):

    """
    Creates a linked node at the current location. 
    
    
    - Args:
    * `nodename` : name of the linked node (`string`)
    * `filename` : name of the linked file (`string`)
      If the link is within the same file, the name is an empty string.
    * `name_in_file` : path name of the node which the link points to (`string`)

    - Returns:
    * None

    """
    
    self._error=cgnslib.cg_link_write(nodename,filename,name_in_file)

  # ------------------------------------------------------------------------------------------
  cpdef is_link(self):

    """
    Tests if a node in the tree is a link. 
    
    
    - Args:
    * None

    - Returns:
    * length of the path name of the linked node (`int`)
      If there isn't linked node, the returned value is 0.

    """
    
    cdef int plength = -1
    self._error=cgnslib.cg_is_link(&plength)
    return plength

  # ------------------------------------------------------------------------------------------
  cpdef cell_dim(self, int B):

    """
    Returns the cell dimension for the base.
    
    - Args:
    * `B` : base id (`int`)

    - Returns:
    * dimension of the cells (`int`)

    """

    cdef int dim = -1
    self._error=cgnslib.cg_cell_dim(self._root,B,&dim)
    return dim

  # ------------------------------------------------------------------------------------------
  cpdef index_dim(self, int B, int Z):

    """
    Returns the index dimension for the zone.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)    

    - Returns:
    * index dimension of the zone (`int`)

    """
    
    cdef int dim = -1
    self._error=cgnslib.cg_index_dim(self._root,B,Z,&dim)
    return dim

  # ------------------------------------------------------------------------------------------
  cpdef bcdataset_write(self, char * name, cgnslib.BCType_t bct, cgnslib.BCDataType_t bcdt):

    """
    Creates a boundary condition dataset node. 
    
    - Args:
    * `name` : name of the dataset (`string`)
    * `bct` : boundary condition type of the dataset (`int`)
      The FamilySpecified type is not allowed here.
    * `bcdt` : type of the boundary condition in the dataset (`int`)
      The admissible types are Dirichlet and Neumann.

    - Returns:
    * None

    - Remarks:
    * This node should be created under a `FamilyBCDataSet_t` node with the gopath funtion.

    """
    
    self._error=cgnslib.cg_bcdataset_write(name,bct,bcdt)

  # ------------------------------------------------------------------------------------------
  cpdef bcdataset_info(self):

    """
    Returns the number of boundary condition dataset nodes.
    
    - Args:
    * None

    - Returns:
    * number of boundary condition dataset nodes contained in the current family boundary
      condition node (`int`)

    """
    
    cdef int data = -1
    self._error=cgnslib.cg_bcdataset_info(&data)
    return data

  # ------------------------------------------------------------------------------------------
  cpdef bcdataset_read(self, int id):

    """
    Returns a tuple with information about a boundary condition dataset node.
    
    - Args:
    * `id` : dataset id (`int`)

    - Returns:
    * dataset node name (`string`)
    * boundary condition type of the dataset (`int`)
    * flag indication if the dataset contains Dirichlet data (`int`)
    * flag indication if the dataset contains Neumann data (`int`)
    
    """
    
    cdef char * name = ""
    cdef cgnslib.BCType_t bct
    cdef int dflag = -1
    cdef int nflag = -1
    self._error=cgnslib.cg_bcdataset_read(id,name,&bct,&dflag,&nflag)
    return (name,bct,dflag,nflag)

  # ------------------------------------------------------------------------------------------
  cpdef bcdata_write(self, int B, int Z, int BC, int ds, cgnslib.BCDataType_t bcdt):

    """
    Creates a boundary condition data node.
    
    - Args:
    * `B` : base id (`int`)
    * `Z` : zone id (`int`)
    * `BC` : boundary condition id (`int`)
    * `ds` : dataset id (`int`)
    * `bcdt` : type of the boundary condition in the dataset (`int`)
      The admissible types are `Dirichlet` and `Neumann`.

    - Returns:
    * None

    """
    
    self._error=cgnslib.cg_bcdata_write(self._root,B,Z,BC,ds,bcdt)

  # ------------------------------------------------------------------------------------------
