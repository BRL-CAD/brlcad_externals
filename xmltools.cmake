# xmltools provides the xsltproc and xmllint tools If both of those are
# present on the system we can forego building this - otherwise, we need
# it.
if (NOT ENABLE_XMLTOOLS)

  find_program(XSLTPROC_EXECUTABLE xsltproc)
  mark_as_advanced(XSLTPROC_EXECUTABLE)

  find_program(XMLLINT_EXECUTABLE xmllint)
  mark_as_advanced(XMLLINT_EXECUTABLE)

  if (NOT XSLTPROC_EXECUTABLE OR NOT XMLLINT_EXECUTABLE)
    if (NOT DEFINED ENABLE_XMLTOOLS)
      set(ENABLE_XMLTOOLS "ON" CACHE BOOL "Enable perplex build")
    endif (NOT DEFINED ENABLE_XMLTOOLS)
  endif (NOT XSLTPROC_EXECUTABLE OR NOT XMLLINT_EXECUTABLE)

endif (NOT ENABLE_XMLTOOLS)
set(ENABLE_XMLTOOLS "${ENABLE_XMLTOOLS}" CACHE BOOL "Enable perplex build")

if (ENABLE_XMLTOOLS)

  set(XMLTOOLS_INSTDIR ${CMAKE_BINARY_INSTALL_ROOT}/../extnoinstall)

  ExternalProject_Add(XMLTOOLS_BLD
    SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/xmltools"
    BUILD_ALWAYS ${EXT_BUILD_ALWAYS} ${LOG_OPTS}
    CMAKE_ARGS
    $<$<NOT:$<BOOL:${CMAKE_CONFIGURATION_TYPES}>>:-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}>
    -DBIN_DIR=${BIN_DIR}
    -DLIB_DIR=${LIB_DIR}
    -DBUILD_STATIC_LIBS=${BUILD_STATIC_LIBS}
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
    -DCMAKE_INSTALL_PREFIX=${CMAKE_NOINSTALL_PREFIX}
    LOG_CONFIGURE ${EXT_BUILD_QUIET}
    LOG_BUILD ${EXT_BUILD_QUIET}
    LOG_INSTALL ${EXT_BUILD_QUIET}
    LOG_OUTPUT_ON_FAILURE ${EXT_BUILD_QUIET}
    )

  ExternalProject_Add_StepTargets(XMLTOOLS_BLD install)

  SetTargetFolder(XMLTOOLS_BLD "Third Party Build Tools")

endif (ENABLE_XMLTOOLS)

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

