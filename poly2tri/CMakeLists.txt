# System poly2tri versions won't do what we need,
# but we're not set up to functionally test for that
# right now, so just build it.

ExternalProject_Add(POLY2TRI_BLD
  URL "${CMAKE_CURRENT_SOURCE_DIR}/poly2tri"
  BUILD_ALWAYS ${EXT_BUILD_ALWAYS} ${LOG_OPTS}
  CMAKE_ARGS
  ${BUILD_TYPE_SPECIFIER}
  -DBIN_DIR=${BIN_DIR}
  -DLIB_DIR=${LIB_DIR}
  -DBUILD_STATIC_LIBS=${BUILD_STATIC_LIBS}
  -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
  -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
  -DCMAKE_INSTALL_PREFIX=${CMAKE_BUNDLE_INSTALL_PREFIX}
  -DZ_PREFIX_STR=${Z_PREFIX_STR}
  LOG_CONFIGURE ${EXT_BUILD_QUIET}
  LOG_BUILD ${EXT_BUILD_QUIET}
  LOG_INSTALL ${EXT_BUILD_QUIET}
  LOG_OUTPUT_ON_FAILURE ${EXT_BUILD_QUIET}
  STEP_TARGETS install
  )

# Copy the license into position in CMAKE_BUNDLE_INSTALL_PREFIX
file(MAKE_DIRECTORY ${CMAKE_BUNDLE_INSTALL_PREFIX}/doc/legal/other)
configure_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/poly2tri/LICENSE
  ${CMAKE_BUNDLE_INSTALL_PREFIX}/doc/legal/other/poly2tri.txt
  COPYONLY
  )

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

