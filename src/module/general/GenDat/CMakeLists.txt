
SET(HEADERS
  
)

SET(SOURCES
  GenDat.cpp
)

SET(EXTRASOURCES
  GenDat.h
)

ADD_COVISE_MODULE(IO GenDat ${EXTRASOURCES} )
TARGET_LINK_LIBRARIES(GenDat  coApi coAppl coCore )

COVISE_INSTALL_TARGET(GenDat)
