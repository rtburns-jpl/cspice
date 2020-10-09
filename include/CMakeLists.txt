set(headers
SpiceSPK.h
SpiceEK.h
SpiceDLA.h
SpiceCel.h
SpiceSrf.h
SpiceZad.h
SpiceZim.h
SpiceZdf.h
SpiceZfc.h
SpiceZmc.h
SpiceEll.h
SpiceZpr.h
SpiceOccult.h
SpiceFrm.h
SpiceOsc.h
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
