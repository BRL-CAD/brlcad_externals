# Unless we have ENABLE_ALL set, based the building of opennurbs on
# the system detection results
if (ENABLE_ALL AND NOT DEFINED ENABLE_OPENNURBS)
  set(ENABLE_OPENNURBS ON)
endif (ENABLE_ALL AND NOT DEFINED ENABLE_OPENNURBS)

if (NOT ENABLE_OPENNURBS)

  find_package(OPENNURBS)

  # TODO - functionality testing is in order for some of our patches - if
  # we do find a system version, but it fails to work the way we need it to,
  # it's still a no-go

  if (NOT OPENNURBS_FOUND AND NOT DEFINED ENABLE_OPENNURBS)
    set(ENABLE_OPENNURBS "ON" CACHE BOOL "Enable opennurbs build")
  endif (NOT OPENNURBS_FOUND AND NOT DEFINED ENABLE_OPENNURBS)

endif (NOT ENABLE_OPENNURBS)
set(ENABLE_OPENNURBS "${ENABLE_OPENNURBS}" CACHE BOOL "Enable opennurbs build")

if (ENABLE_OPENNURBS)

  if (TARGET ZLIB_BLD)
    set(Z_PREFIX_STR "brl_")
    set(ZLIB_TARGET ZLIB_BLD)
  endif (TARGET ZLIB_BLD)

  ExternalProject_Add(OPENNURBS_BLD
    URL "${CMAKE_CURRENT_SOURCE_DIR}/opennurbs"
    BUILD_ALWAYS ${EXT_BUILD_ALWAYS} ${LOG_OPTS}
    PATCH_COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_android_uuid.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_3dm_properties.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_archive.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_bounding_box.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_brep.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_brep_tools.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_cmake.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_defines.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_example_brep.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_example_gl.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_file_utilities.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_font.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_gl.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_light.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_locale.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_lock.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_lookup.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_material.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_object_history.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_optimize.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_polyline.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_precompiledheader.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_statics.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_string.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_subd.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_system.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_version_number.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_x.patch
    COMMAND ${PATCH_EXECUTABLE};-E;-p1;${PATCH_OPTIONS};-i;${CMAKE_CURRENT_SOURCE_DIR}/opennurbs_zlib.patch
    CMAKE_ARGS
    ${BUILD_TYPE_SPECIFIER}
    $<$<BOOL:${ZLIB_TARGET}>:-DZ_PREFIX=ON>
    $<$<BOOL:${ZLIB_TARGET}>:-DZ_PREFIX_STR=${Z_PREFIX_STR}>
    -DZLIB_ROOT=$<$<BOOL:${ZLIB_TARGET}>:${CMAKE_BUNDLE_INSTALL_PREFIX}>
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
    -DCMAKE_INSTALL_LIBDIR=${LIB_DIR}
    -DCMAKE_INSTALL_PREFIX=${CMAKE_BUNDLE_INSTALL_PREFIX}
    -DCMAKE_INSTALL_RPATH=${CMAKE_BUNDLE_INSTALL_PREFIX}/${LIB_DIR}
    LOG_CONFIGURE ${EXT_BUILD_QUIET}
    LOG_BUILD ${EXT_BUILD_QUIET}
    LOG_INSTALL ${EXT_BUILD_QUIET}
    LOG_OUTPUT_ON_FAILURE ${EXT_BUILD_QUIET}
    STEP_TARGETS install
    )

  if (TARGET PATCH_BLD)
    ExternalProject_Add_StepDependencies(OPENNURBS_BLD configure PATCH_BLD-install)
  endif (TARGET PATCH_BLD)

  if (TARGET ZLIB_BLD)
    ExternalProject_Add_StepDependencies(OPENNURBS_BLD configure ZLIB_BLD-install)
  endif (TARGET ZLIB_BLD)

endif (ENABLE_OPENNURBS)

# Copy the license into position in CMAKE_BUNDLE_INSTALL_PREFIX
file(MAKE_DIRECTORY ${CMAKE_BUNDLE_INSTALL_PREFIX}/doc/legal/other)
configure_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/opennurbs/LICENSE
  ${CMAKE_BUNDLE_INSTALL_PREFIX}/doc/legal/other/openNURBS.txt
  COPYONLY
  )

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

