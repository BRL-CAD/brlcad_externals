set(express_HDRS
  express/alg.h
  express/basic.h
  express/caseitem.h
  express/dict.h
  express/entity.h
  express/error.h
  express/expbasic.h
  express/expr.h
  express/express.h
  express/hash.h
  express/lexact.h
  express/linklist.h
  express/memory.h
  express/object.h
  express/resolve.h
  express/schema.h
  express/scope.h
  express/stmt.h
  express/symbol.h
  express/type.h
  express/variable.h
  )
install(FILES ${express_HDRS}
  DESTINATION ${INCLUDE_DIR}/stepcode/express)

set(exppp_HDRS
  exppp/exppp.h
  )
install(FILES ${exppp_HDRS}
  DESTINATION ${INCLUDE_DIR}/stepcode/exppp)

install(FILES ordered_attrs.h
  sc_export.h
  DESTINATION ${INCLUDE_DIR}/stepcode)

install(FILES ${SC_BINARY_DIR}/${INCLUDE_DIR}/config.h
  DESTINATION ${INCLUDE_DIR}/stepcode)

add_subdirectory(cldai)
add_subdirectory(cleditor)
add_subdirectory(cllazyfile)
add_subdirectory(clstepcore)
add_subdirectory(clutils)

# Local Variables:
# tab-width: 8
# mode: cmake
# indent-tabs-mode: t
# End:
# ex: shiftwidth=2 tabstop=8

