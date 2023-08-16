# Unless we have ENABLE_ALL set, based the building of netpbm on
# the system detection results
if (ENABLE_ALL)
  set(ENABLE_NETPBM ON)
endif (ENABLE_ALL)

if (NOT ENABLE_NETPBM)

  find_package(NETPBM)

  if (NOT NETPBM_FOUND AND NOT DEFINED ENABLE_NETPBM)
    set(ENABLE_NETPBM "ON" CACHE BOOL "Enable netpbm build")
  endif (NOT NETPBM_FOUND AND NOT DEFINED ENABLE_NETPBM)

endif (NOT ENABLE_NETPBM)
set(ENABLE_NETPBM "${ENABLE_NETPBM}" CACHE BOOL "Enable netpbm build")

if (ENABLE_NETPBM)

  ExternalProject_Add(NETPBM_BLD
    SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/netpbm"
    BUILD_ALWAYS ${EXT_BUILD_ALWAYS} ${LOG_OPTS}
    CMAKE_ARGS
    $<$<NOT:$<BOOL:${CMAKE_CONFIGURATION_TYPES}>>:-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}>
    -DBIN_DIR=${BIN_DIR}
    -DLIB_DIR=${LIB_DIR}
    -DBUILD_STATIC_LIBS=${BUILD_STATIC_LIBS}
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
    -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
    LOG_CONFIGURE ${EXT_BUILD_QUIET}
    LOG_BUILD ${EXT_BUILD_QUIET}
    LOG_INSTALL ${EXT_BUILD_QUIET}
    LOG_OUTPUT_ON_FAILURE ${EXT_BUILD_QUIET}
    )

  SetTargetFolder(NETPBM_BLD "Third Party Libraries")
  SetTargetFolder(netpbm "Third Party Libraries")

endif (ENABLE_NETPBM)

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

