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

if (ENABLE_ITCL AND NOT DEFINED ENABLE_ITK)
  set(ENABLE_ITK ON)
endif (ENABLE_ITCL AND NOT DEFINED ENABLE_ITK)

if (NOT ENABLE_ITK)
  find_library(ITK_SYS_LIBRARY NAMES itk3)

  if (NOT ITK_SYS_LIBRARY AND NOT DEFINED ENABLE_ITK)
    set(ENABLE_ITK "ON" CACHE BOOL "Enable itk build")
  endif (NOT ITK_SYS_LIBRARY AND NOT DEFINED ENABLE_ITK)

endif (NOT ENABLE_ITK)
set(ENABLE_ITK "${ENABLE_ITK}" CACHE BOOL "Enable itk build")

if (ENABLE_ITK)

  # If we're building ITK, it's path setup must take into account the
  # subdirectory in which we are storing the library.
  set(RPATH_SUFFIX itk3.4)

  ExternalProject_Add(ITK_BLD
    SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/itk3"
    BUILD_ALWAYS ${EXT_BUILD_ALWAYS} ${LOG_OPTS}
    CMAKE_ARGS
    $<$<NOT:$<BOOL:${CMAKE_CONFIGURATION_TYPES}>>:-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}>
    -DBIN_DIR=${BIN_DIR}
    -DLIB_DIR=${LIB_DIR}
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
    -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
    -DCMAKE_INSTALL_RPATH=${CMAKE_INSTALL_PREFIX}/${LIB_DIR}/${RPATH_SUFFIX}
    -DINCLUDE_DIR=${INCLUDE_DIR}
    -DITCL_ROOT=$<$<BOOL:${ITCL_TARGET}>:${CMAKE_INSTALL_PREFIX}>
    -DSHARED_DIR=${LIB_DIR}
    -DTCL_ENABLE_TK=ON
    -DTCL_ROOT=$<$<BOOL:${TCL_TARGET}>:${CMAKE_INSTALL_PREFIX}>
    LOG_CONFIGURE ${EXT_BUILD_QUIET}
    LOG_BUILD ${EXT_BUILD_QUIET}
    LOG_INSTALL ${EXT_BUILD_QUIET}
    LOG_OUTPUT_ON_FAILURE ${EXT_BUILD_QUIET}
    )
  
  ExternalProject_Add_StepTargets(ITK_BLD install)

  if (TARGET TCL_BLD)
    ExternalProject_Add_StepDependencies(ITK_BLD configure TCL_BLD-install)
  endif (TARGET TCL_BLD)
  if (TARGET TK_BLD)
    ExternalProject_Add_StepDependencies(ITK_BLD configure TK_BLD-install)
  endif (TARGET TK_BLD)
  if (TARGET ITCL_BLD)
    ExternalProject_Add_StepDependencies(ITK_BLD configure ITCL_BLD-install)
  endif (TARGET ITCL_BLD)

  SetTargetFolder(ITK_BLD "Third Party Libraries")

endif (ENABLE_ITK)

mark_as_advanced(ITK_LIBRARY)
mark_as_advanced(ITK_LIBRARIES)
mark_as_advanced(ITK_VERSION)

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

