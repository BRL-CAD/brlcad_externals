set(UTILS_SRCS
  Str.cc
  dirobj.cc
  gennode.cc
  gennodelist.cc
  gennodearray.cc
  sc_hash.cc
  errordesc.cc
  )

include_directories(
  ${SC_BINARY_DIR}/include
  ${CMAKE_CURRENT_SOURCE_DIR}
  )

if(BUILD_SHARED_LIBS)
  SC_ADDLIB(steputils SHARED SOURCES ${UTILS_SRCS})
  if(WIN32)
    target_compile_definitions(steputils PRIVATE SC_UTILS_DLL_EXPORTS)
    target_link_libraries(steputils shlwapi)
  endif()
endif()

if(BUILD_STATIC_LIBS)
  SC_ADDLIB(steputils-static STATIC SOURCES ${UTILS_SRCS})
  if(WIN32)
    target_link_libraries(steputils-static shlwapi)
  endif()
endif()

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

