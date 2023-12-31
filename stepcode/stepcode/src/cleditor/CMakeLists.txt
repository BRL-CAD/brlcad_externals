set(EDITOR_SRCS
  STEPfile.cc
  STEPfile.inline.cc
  cmdmgr.cc
  SdaiHeaderSchema.cc
  SdaiHeaderSchemaAll.cc
  SdaiHeaderSchemaInit.cc
  SdaiSchemaInit.cc
  )

include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_SOURCE_DIR}/include/stepcode
  )

if(BUILD_SHARED_LIBS)
  SC_ADDLIB(stepeditor SHARED SOURCES ${EDITOR_SRCS} LINK_LIBRARIES stepcore stepdai steputils)
  if(WIN32)
    target_compile_definitions(stepeditor PRIVATE SC_EDITOR_DLL_EXPORTS)
  endif()
endif()

if(BUILD_STATIC_LIBS)
  SC_ADDLIB(stepeditor-static STATIC SOURCES ${EDITOR_SRCS} LINK_LIBRARIES stepcore-static stepdai-static steputils-static)
endif()

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

