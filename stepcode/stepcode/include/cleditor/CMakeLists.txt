set(EDITOR_HDRS
  STEPfile.h
  cmdmgr.h
  editordefines.h
  SdaiHeaderSchema.h
  SdaiHeaderSchemaClasses.h
  SdaiSchemaInit.h
  seeinfodefault.h
  )

install(FILES ${EDITOR_HDRS}
  DESTINATION ${INCLUDE_DIR}/stepcode/cleditor)

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

