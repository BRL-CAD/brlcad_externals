set (sqlite3_DESCRIPTION "
Option for enabling and disabling compilation of the sqlite3 database command
and library provided with BRL-CAD's source distribution.  Default is AUTO,
responsive to the toplevel BRLCAD_BUNDLED_LIBS option and testing first for a
system version if BRLCAD_BUNDLED_LIBS is also AUTO.
")

THIRD_PARTY(sqlite3 SQLITE3 sqlite3
  sqlite3_DESCRIPTION
  FIND_NAME SQLite3
  ALIASES ENABLE_SQLITE3 ENABLE_SQLITE3
  RESET_VARS SQLite3_INCLUDE_DIRS SQLite3_LIBRARIES SQLite3_INCLUDE_DIR SQLite3_LIBRARY SQLite3_EXECNAME
  )

if (BRLCAD_SQLITE3_BUILD)

  set(SQLITE3_VMAJ "3")
  set(SQLITE3_VMIN "41")
  set(SQLITE3_VPATCH "2")
  set(SQLITE3_VERSION ${SQLITE3_VMAJ}.${SQLITE3_VMIN}.${SQLITE3_VPATCH})

  set_lib_vars(SQLITE3 sqlite3 ${SQLITE3_VMAJ} ${SQLITE3_VMIN} ${SQLITE3_VPATCH})

  #set(SQLITE3_INSTDIR ${CMAKE_BINARY_INSTALL_ROOT}/sqlite3)
  set(SQLITE3_INSTDIR ${CMAKE_BINARY_INSTALL_ROOT})

  ExternalProject_Add(SQLITE3_BLD
    SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/sqlite3"
    BUILD_ALWAYS ${EXT_BUILD_ALWAYS} ${LOG_OPTS}
    CMAKE_ARGS
    $<$<NOT:$<BOOL:${CMAKE_CONFIGURATION_TYPES}>>:-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}>
    -DBIN_DIR=${BIN_DIR}
    -DBUILD_STATIC_LIBS=${BUILD_STATIC_LIBS}
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
    -DCMAKE_INSTALL_PREFIX=${SQLITE3_INSTDIR}
    -DCMAKE_INSTALL_RPATH=${CMAKE_BUILD_RPATH}
    -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=${CMAKE_INSTALL_RPATH_USE_LINK_PATH}
    -DCMAKE_SKIP_BUILD_RPATH=${CMAKE_SKIP_BUILD_RPATH}
    -DLIB_DIR=${LIB_DIR}
    LOG_CONFIGURE ${EXT_BUILD_QUIET}
    LOG_BUILD ${EXT_BUILD_QUIET}
    LOG_INSTALL ${EXT_BUILD_QUIET}
    LOG_OUTPUT_ON_FAILURE ${EXT_BUILD_QUIET}
    )

  ExternalProject_Add_StepTargets(SQLITE3_BLD install)

  SetTargetFolder(SQLITE3_BLD "Third Party Libraries")
  SetTargetFolder(sqlite3 "Third Party Libraries")

  DISTCLEAN("${CMAKE_CURRENT_BINARY_DIR}/SQLITE3_BLD-prefix")

endif (BRLCAD_SQLITE3_BUILD)

mark_as_advanced(SQLite3_EXECNAME)
mark_as_advanced(SQLite3_INCLUDE_DIR)
mark_as_advanced(SQLite3_INCLUDE_DIRS)
mark_as_advanced(SQLite3_LIBRARY)
mark_as_advanced(SQLite3_LIBRARIES)

include("${CMAKE_CURRENT_SOURCE_DIR}/sqlite3.dist")

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

