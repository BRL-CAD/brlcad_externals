# Unless we have ENABLE_ALL set, based the building of png on
# the system detection results
if (ENABLE_ALL AND NOT DEFINED ENABLE_OPENMESH)
  set(ENABLE_OPENMESH ON)
endif (ENABLE_ALL AND NOT DEFINED ENABLE_OPENMESH)

if (NOT ENABLE_OPENMESH)

  # We generally don't want the Mac framework libpng...
  set(CMAKE_FIND_FRAMEWORK LAST)

  find_package(OpenMesh)

  if (NOT OpenMesh_FOUND AND NOT DEFINED ENABLE_OPENMESH)
    set(ENABLE_OPENMESH "ON" CACHE BOOL "Enable openmesh build")
  endif (NOT OpenMesh_FOUND AND NOT DEFINED ENABLE_OPENMESH)

endif (NOT ENABLE_OPENMESH)
set(ENABLE_OPENMESH "${ENABLE_OPENMESH}" CACHE BOOL "Enable openmesh build")

if (ENABLE_OPENMESH)

  ExternalProject_Add(OPENMESH_BLD
    URL "${CMAKE_CURRENT_SOURCE_DIR}/openmesh"
    BUILD_ALWAYS ${EXT_BUILD_ALWAYS} ${LOG_OPTS}
    PATCH_COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/openmesh.patch
    CMAKE_ARGS
    ${BUILD_TYPE_SPECIFIER}
    -DBIN_DIR=${BIN_DIR}
    -DLIB_DIR=${LIB_DIR}
    -DBUILD_STATIC_LIBS=${BUILD_STATIC_LIBS}
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
    -DCMAKE_INSTALL_PREFIX=${CMAKE_BUNDLE_INSTALL_PREFIX}
    -DCMAKE_INSTALL_RPATH=${CMAKE_BUNDLE_INSTALL_PREFIX}/${LIB_DIR}
    -DBUILD_APPS=OFF
    -DOPENMESH_BUILD_SHARED=ON
    LOG_CONFIGURE ${EXT_BUILD_QUIET}
    LOG_BUILD ${EXT_BUILD_QUIET}
    LOG_INSTALL ${EXT_BUILD_QUIET}
    LOG_OUTPUT_ON_FAILURE ${EXT_BUILD_QUIET}
    STEP_TARGETS install
    )

  if (TARGET PATCH_BLD)
    ExternalProject_Add_StepDependencies(OPENMESH_BLD configure PATCH_BLD-install)
  endif (TARGET PATCH_BLD)

endif (ENABLE_OPENMESH)

mark_as_advanced(OPENMESH_INCLUDE_DIRS)
mark_as_advanced(OPENMESH_LIBRARIES)
mark_as_advanced(OPENMESH_CORE_GEOMETRY_DIR)
mark_as_advanced(OPENMESH_CORE_IO_DIR)
mark_as_advanced(OPENMESH_CORE_MESH_DIR)
mark_as_advanced(OPENMESH_CORE_SYSTEM_DIR)
mark_as_advanced(OPENMESH_CORE_UTILS_DIR)
mark_as_advanced(OPENMESH_TOOLS_DECIMATER_DIR)
mark_as_advanced(OPENMESH_TOOLS_DUALIZER_DIR)
mark_as_advanced(OPENMESH_TOOLS_KERNERL_OSG_DIR)
mark_as_advanced(OPENMESH_TOOLS_SMOOTHER_DIR)
mark_as_advanced(OPENMESH_TOOLS_SUBDIVIDER_DIR)
mark_as_advanced(OPENMESH_TOOLS_UTILS_DIR)
mark_as_advanced(OPENMESH_TOOLS_VDPM_DIR)

# Copy the license into position in CMAKE_BUNDLE_INSTALL_PREFIX
file(MAKE_DIRECTORY ${CMAKE_BUNDLE_INSTALL_PREFIX}/doc/legal/other)
configure_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/openmesh/LICENSE
  ${CMAKE_BUNDLE_INSTALL_PREFIX}/doc/legal/other/openmesh.txt
  COPYONLY
  )



# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

