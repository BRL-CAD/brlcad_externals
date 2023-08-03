# Unfortunately, there does not appear to be a reliable way to test for the
# presence of the Itk package on a system Tcl/Tk.  We key off of the presence
# of the TK_BLD and ITCL_BLD targets, but that may produce a false negative if
# those builds are both off but we still need Itk.  As far as I can tell the
# "package require Itk" test (which is what is required to properly test for an
# available Itk package) can ONLY be performed successfully on a system that
# supports creation of a graphics window. Window creation isn't typically
# available on continuous integration runners, which means the test will always
# fail there even when it shouldn't.

# We try to find the itk library, since that's the only test we can do without
# needing the graphical invocation.  Unfortunately, even a find_library search
# looking for libitk isn't completely reliable, since the presence of a shared
# library is not a guarantee it is correctly hooked into the "package require"
# mechanism of the system Tcl/Tk we want to use.  (It is possible to have more
# than one Tcl/Tk on a system - this situation is known to have occurred on the
# Mac when 3rd party package managers are used, for example.)

# Hopefully situations where a user has a complex Itcl/Itk setup are rare
# enough that it won't be a significant issue, since there appears to be
# only so much we can do to sort it out...

if (BRLCAD_ENABLE_TK)

  # Do what we can to make a sane decision on whether to build Itk
  set(DO_ITK_BUILD 0)
  if (TARGET TK_BLD OR TARGET ITCL_BLD OR "${BRLCAD_ITK}" STREQUAL "BUNDLED")
    set(DO_ITK_BUILD 1)
  else (TARGET TK_BLD OR TARGET ITCL_BLD OR "${BRLCAD_ITK}" STREQUAL "BUNDLED")
    find_library(ITK_SYS_LIBRARY NAMES itk3)
    if (NOT ITK_SYS_LIBRARY)
      set(DO_ITK_BUILD 1)
    endif (NOT ITK_SYS_LIBRARY)
  endif (TARGET TK_BLD OR TARGET ITCL_BLD OR "${BRLCAD_ITK}" STREQUAL "BUNDLED")

  if (DO_ITK_BUILD)

    # If we're building ITK, it's path setup must take into account the
    # subdirectory in which we are storing the library.
    relative_rpath(RELPATH SUFFIX itk3.4)
    set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/${LIB_DIR}${RELPATH}")
    ext_build_rpath(SUFFIX itk3.4)

    set(BRLCAD_ITK_BUILD "ON" CACHE STRING "Enable Itk build" FORCE)

    set(ITK_SRC_DIR "${CMAKE_CURRENT_BINARY_DIR}/ITK_BLD-prefix/src/ITK_BLD")

    VERSIONS("${CMAKE_CURRENT_SOURCE_DIR}/itk3/generic/itk.h" ITK_MAJOR_VERSION ITK_MINOR_VERSION ITK_PATCH_VERSION)
    set(ITK_VERSION ${ITK_MAJOR_VERSION}.${ITK_MINOR_VERSION} CACHE STRING "Itk version")

    set(ITK_DEPS)
    if (TARGET TCL_BLD)
      set(TCL_TARGET ON)
      list(APPEND ITK_DEPS TCL_BLD)
    endif (TARGET TCL_BLD)

    if (TARGET ITCL_BLD)
      set(ITCL_TARGET ON)
      list(APPEND ITK_DEPS ITCL_BLD)
      list(APPEND ITK_DEPS ITCL_BLD)
    endif (TARGET ITCL_BLD)

    if (TARGET TK_BLD)
      list(APPEND ITK_DEPS TK_BLD)
    endif (TARGET TK_BLD)

    #set(ITK_INSTDIR ${CMAKE_BINARY_INSTALL_ROOT}/itk3)
    set(ITK_INSTDIR ${CMAKE_BINARY_INSTALL_ROOT})

    ExternalProject_Add(ITK_BLD
      SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/itk3"
      BUILD_ALWAYS ${EXT_BUILD_ALWAYS} ${LOG_OPTS}
      CMAKE_ARGS
      $<$<NOT:$<BOOL:${CMAKE_CONFIGURATION_TYPES}>>:-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}>
      -DBIN_DIR=${BIN_DIR}
      -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
      -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
      -DCMAKE_INSTALL_PREFIX=${ITK_INSTDIR}
      -DCMAKE_INSTALL_RPATH=${CMAKE_BUILD_RPATH}
      -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=${CMAKE_INSTALL_RPATH_USE_LINK_PATH}
      -DCMAKE_SKIP_BUILD_RPATH=${CMAKE_SKIP_BUILD_RPATH}
      -DINCLUDE_DIR=${INCLUDE_DIR}
      -DITCL_ROOT=$<$<BOOL:${ITCL_TARGET}>:${CMAKE_BINARY_INSTALL_ROOT}>
      -DLIB_DIR=${LIB_DIR}
      -DSHARED_DIR=${SHARED_DIR}
      -DTCL_ENABLE_TK=${TCL_ENABLE_TK}
      -DTCL_ROOT=$<$<BOOL:${TCL_TARGET}>:${CMAKE_BINARY_INSTALL_ROOT}>
      -DTCL_VERSION=${TCL_VERSION}
      DEPENDS ${ITK_DEPS}
      LOG_CONFIGURE ${EXT_BUILD_QUIET}
      LOG_BUILD ${EXT_BUILD_QUIET}
      LOG_INSTALL ${EXT_BUILD_QUIET}
      LOG_OUTPUT_ON_FAILURE ${EXT_BUILD_QUIET}
      )

    SetTargetFolder(ITK_BLD "Third Party Libraries")

  else (DO_ITK_BUILD)

    set(BRLCAD_ITK_BUILD "OFF" CACHE STRING "Disable Itk build" FORCE)

  endif (DO_ITK_BUILD)

endif (BRLCAD_ENABLE_TK)

mark_as_advanced(ITK_LIBRARY)
mark_as_advanced(ITK_LIBRARIES)
mark_as_advanced(ITK_VERSION)

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

