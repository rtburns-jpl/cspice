set(headers
SpiceSPK.h
SpiceEK.h
SpiceDLA.h
SpiceCel.h
SpiceSrf.h
SpiceZad.h
SpiceZim.h
fp.h
SpiceZdf.h
f2cMang.h
SpiceZfc.h
SpiceZmc.h
SpiceEll.h
rawio.h
signal1.h
fio.h
SpiceZpr.h
lio.h
SpiceOccult.h
fmt.h
f2c.h
SpiceFrm.h
zzalloc.h
SpiceOsc.h
zzerror.h
SpiceZrnm.h
SpicePln.h
SpiceDtl.h
SpiceDSK.h
SpiceUsr.h
SpiceCK.h
SpiceGF.h
SpiceErr.h
SpiceZpl.h
SpiceZst.h
)
list(TRANSFORM headers PREPEND ${CMAKE_CURRENT_LIST_DIR}/)

set_target_properties(cspice PROPERTIES PUBLIC_HEADER "${headers}")
