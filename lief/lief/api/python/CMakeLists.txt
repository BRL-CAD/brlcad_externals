cmake_minimum_required(VERSION 3.1)
find_package(Python COMPONENTS Interpreter Development.Module REQUIRED)

# Avoid warning about DOWNLOAD_EXTRACT_TIMESTAMP in CMake 3.24:
if (CMAKE_VERSION VERSION_GREATER_EQUAL "3.24.0")
  cmake_policy(SET CMP0135 NEW)
endif()

include(ExternalProject)
include(CheckCXXCompilerFlag)
include(CheckCCompilerFlag)


macro(ADD_FLAG_IF_SUPPORTED flag name)
  CHECK_C_COMPILER_FLAG("${flag}"   "C_SUPPORTS_${name}")
  CHECK_CXX_COMPILER_FLAG("${flag}" "CXX_SUPPORTS_${name}")

  if (C_SUPPORTS_${name})
    target_compile_options(pyLIEF PRIVATE ${flag})
  endif()

  if (CXX_SUPPORTS_${name})
    target_compile_options(pyLIEF PRIVATE ${flag})
  endif()
endmacro()

add_library(lief_pybind11 INTERFACE)

if (LIEF_EXTERNAL_PYBIND11)
  find_package(pybind11 REQUIRED)
  find_package(PythonLibsNew MODULE REQUIRED)
  target_link_libraries(lief_pybind11 INTERFACE pybind11::module)
  get_target_property(PYBIND_INC_DIR pybind11::module INTERFACE_INCLUDE_DIRECTORIES)
  target_include_directories(lief_pybind11 SYSTEM INTERFACE ${PYBIND_INC_DIR} ${Python_INCLUDE_DIRS})
else()
  find_package(PythonLibsNew MODULE REQUIRED)
  set(PYBIND11_VERSION 2.10.1)
  set(PYBIND11_SHA256 SHA256=fcf94065efcfd0a7a828bacf118fa11c43f6390d0c805e3e6342ac119f2e9976)
  set(PYBIND11_URL "${THIRD_PARTY_DIRECTORY}/pybind11-${PYBIND11_VERSION}.zip" CACHE STRING "URL to the Pybind11 repo")
  ExternalProject_Add(lief_pybind11_project
    URL               ${PYBIND11_URL}
    URL_HASH          ${PYBIND11_SHA256}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND     ""
    INSTALL_COMMAND   "")
  add_dependencies(lief_pybind11 lief_pybind11_project)
  ExternalProject_get_property(lief_pybind11_project SOURCE_DIR)
  target_include_directories(lief_pybind11 SYSTEM INTERFACE "${SOURCE_DIR}/include")
endif()

message(STATUS "Python version:     ${PYTHON_VERSION}")
message(STATUS "Python lib:         ${PYTHON_LIBRARY}")
message(STATUS "Python include:     ${PYTHON_INCLUDE_DIR}")
message(STATUS "Python interpreter: ${PYTHON_EXECUTABLE}")


# Define source files
set(LIEF_PYTHON_BASIC_SRC
  "${CMAKE_CURRENT_SOURCE_DIR}/src/pyLIEF.cpp"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/pyUtils.cpp"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/pyLogger.cpp"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/pyHash.cpp"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/pyObject.cpp"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/pyErr.cpp"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/encoding.cpp"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/PyIOStream.cpp"
)

list(APPEND LIEF_PYTHON_BASIC_SRC
     "${CMAKE_CURRENT_SOURCE_DIR}/src/pyJson.cpp")

set(LIEF_PYTHON_SRC
  ${LIEF_PYTHON_BASIC_SRC}
)

set(LIEF_PYTHON_BASIC_HDR
  "${CMAKE_CURRENT_SOURCE_DIR}/src/pyErr.hpp"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/pyIterators.hpp"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/pyLIEF.hpp"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/enums_wrapper.hpp"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/encoding.hpp"
  "${CMAKE_CURRENT_SOURCE_DIR}/src/PyIOStream.hpp"
)

set(LIEF_PYTHON_HDR
  ${LIEF_PYTHON_BASIC_HDR}
)

source_group("Header Files" FILES ${LIEF_PYTHON_BASIC_HDR})

add_library(pyLIEF SHARED ${LIEF_PYTHON_SRC} ${LIEF_PYTHON_HDR})

target_include_directories(pyLIEF PUBLIC
  "${CMAKE_CURRENT_SOURCE_DIR}/src"
)

target_include_directories(pyLIEF SYSTEM PRIVATE
  "${PYTHON_INCLUDE_DIR}"
  "${PYBIND11_SOURCE_DIR}/include")

include("${CMAKE_CURRENT_SOURCE_DIR}/src/Abstract/CMakeLists.txt")

if(LIEF_ELF)
  include("${CMAKE_CURRENT_SOURCE_DIR}/src/ELF/CMakeLists.txt")
endif()

if(LIEF_PE)
  include("${CMAKE_CURRENT_SOURCE_DIR}/src/PE/CMakeLists.txt")
endif()

if(LIEF_MACHO)
  include("${CMAKE_CURRENT_SOURCE_DIR}/src/MachO/CMakeLists.txt")
endif()

if(LIEF_OAT)
  include("${CMAKE_CURRENT_SOURCE_DIR}/src/OAT/CMakeLists.txt")
endif()

if(LIEF_DEX)
  include("${CMAKE_CURRENT_SOURCE_DIR}/src/DEX/CMakeLists.txt")
endif()

if(LIEF_VDEX)
  include("${CMAKE_CURRENT_SOURCE_DIR}/src/VDEX/CMakeLists.txt")
endif()

if(LIEF_ART)
  include("${CMAKE_CURRENT_SOURCE_DIR}/src/ART/CMakeLists.txt")
endif()

include("${CMAKE_CURRENT_SOURCE_DIR}/src/platforms/CMakeLists.txt")


target_compile_features(pyLIEF PRIVATE cxx_attribute_deprecated)

set_target_properties(pyLIEF PROPERTIES
  POSITION_INDEPENDENT_CODE    ON
  CXX_STANDARD                 14
  CXX_STANDARD_REQUIRED        ON
  CXX_VISIBILITY_PRESET        hidden
  C_VISIBILITY_PRESET          hidden
)

set_target_properties(pyLIEF PROPERTIES PYTHON_VERSION ${PYTHON_VERSION})
set(PYLIEF_DEPS_LIBRARIES LIB_LIEF)

if(LIEF_COVERAGE)
  target_compile_options(pyLIEF PRIVATE -g -O0 --coverage -fprofile-arcs -ftest-coverage)
  set(PYLIEF_DEPS_LIBRARIES ${PYLIEF_DEPS_LIBRARIES} gcov)
endif()


ADD_FLAG_IF_SUPPORTED("-Wno-macro-redefined"         NO_MACRO_REDEFINED)
ADD_FLAG_IF_SUPPORTED("-Wno-deprecated-declarations" NO_DEPRECATED_DECLARATIONS)

set_target_properties(pyLIEF PROPERTIES PREFIX "" OUTPUT_NAME "lief")
target_link_libraries(pyLIEF PRIVATE lief_pybind11 lief_spdlog)

if(APPLE)
    set_target_properties(pyLIEF PROPERTIES
      MACOSX_RPATH     ON
      LINK_FLAGS       "-undefined dynamic_lookup "
    )
endif()

set_target_properties(pyLIEF PROPERTIES PREFIX "")
if (UNIX)
  # Even on osx (c.f. EXT_SUFFIX from sysconfig)
  set_target_properties(pyLIEF PROPERTIES SUFFIX ".so")
elseif(WIN32)
  set_target_properties(pyLIEF PROPERTIES SUFFIX ".pyd")
endif()

get_target_property(suffix pyLIEF SUFFIX)
set(LIEF_LIBRARY_NAME "lief${suffix}")

if (WIN32)
  set(PYLIEF_DEPS_LIBRARIES ${PYLIEF_DEPS_LIBRARIES} ${PYTHON_LIBRARIES})
endif()

target_link_libraries(pyLIEF PUBLIC ${PYLIEF_DEPS_LIBRARIES})


if (CMAKE_BUILD_TYPE MATCHES Release AND UNIX AND NOT APPLE)
    add_custom_command(
      TARGET pyLIEF
      COMMENT "Strip LIEF Python bindings"
      POST_BUILD
      COMMAND ${CMAKE_STRIP} --strip-all $<TARGET_FILE:pyLIEF>
    )
endif()

if (CMAKE_BUILD_TYPE MATCHES Release AND APPLE)
  add_custom_command(
    TARGET pyLIEF
    COMMENT "Strip LIEF Python bindings"
    POST_BUILD
    COMMAND ${CMAKE_STRIP} -x -S $<TARGET_FILE:pyLIEF>
  )
endif()

add_custom_command(TARGET pyLIEF POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:pyLIEF> ${PROJECT_BINARY_DIR}/api/python/lief
)

if (MSVC)
  add_custom_command(TARGET pyLIEF POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:pyLIEF> ${CMAKE_CURRENT_BINARY_DIR}
  )
endif()

