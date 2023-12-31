# The perplex tool chain provides three tools - perplex, re2c and lemon.
# If all of those are present on the system we can forego building this -
# otherwise, we need it.  Most of the time we'll need it, since perplex was
# developed for the BRL-CAD build and isn't a standard tool
if (NOT ENABLE_PERPLEX)

  find_program(PERPLEX_EXECUTABLE perplex)
  mark_as_advanced(PERPLEX_EXECUTABLE)

  find_program(LEMON_EXECUTABLE lemon)
  mark_as_advanced(LEMON_EXECUTABLE)

  find_program(RE2C_EXECUTABLE re2c)
  mark_as_advanced(RE2C_EXECUTABLE)

  if (NOT PERPLEX_EXECUTABLE OR NOT LEMON_EXECUTABLE OR NOT RE2C_EXECUTABLE)
    if (NOT DEFINED ENABLE_PERPLEX)
      set(ENABLE_PERPLEX "ON" CACHE BOOL "Enable perplex build")
    endif (NOT DEFINED ENABLE_PERPLEX)
  endif (NOT PERPLEX_EXECUTABLE OR NOT LEMON_EXECUTABLE OR NOT RE2C_EXECUTABLE)

endif (NOT ENABLE_PERPLEX)
set(ENABLE_PERPLEX "${ENABLE_PERPLEX}" CACHE BOOL "Enable perplex build")

if (ENABLE_PERPLEX)

  set(PERPLEX_INSTDIR ${CMAKE_BINARY_INSTALL_ROOT}/../extnoinstall)

  ExternalProject_Add(PERPLEX_BLD
    SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/perplex"
    BUILD_ALWAYS ${EXT_BUILD_ALWAYS} ${LOG_OPTS}
    CMAKE_ARGS
    ${BUILD_TYPE_SPECIFIER}
    -DBIN_DIR=${BIN_DIR}
    -DLIB_DIR=${LIB_DIR}
    -DBUILD_STATIC_LIBS=${BUILD_STATIC_LIBS}
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
    -DCMAKE_INSTALL_PREFIX=${CMAKE_NOBUNDLE_INSTALL_PREFIX}
    LOG_CONFIGURE ${EXT_BUILD_QUIET}
    LOG_BUILD ${EXT_BUILD_QUIET}
    LOG_INSTALL ${EXT_BUILD_QUIET}
    LOG_OUTPUT_ON_FAILURE ${EXT_BUILD_QUIET}
    STEP_TARGETS install
    )

  if (TARGET PATCH_BLD)
    ExternalProject_Add_StepDependencies(PERPLEX_BLD configure PATCH_BLD-install)
  endif (TARGET PATCH_BLD)

endif (ENABLE_PERPLEX)

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

