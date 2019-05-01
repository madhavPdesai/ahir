cmake_minimum_required(VERSION 2.8)
find_package(Boost COMPONENTS system filesystem REQUIRED)

# Grammar.
include(${CMAKE_CURRENT_SOURCE_DIR}/../antlr2.cmake)
ADD_ANTLR_GRAMMAR(${CMAKE_CURRENT_SOURCE_DIR}/grammar/hierSys.g GRAMMER_OUTPUT_FILES GRAMMAR_HTML_FILES)
include_directories(${ANTLR_INCLUDE_DIR})

# Build lexer and parser.
add_library(parser ${GRAMMER_OUTPUT_FILES})
set_source_files_properties(${GRAMMER_OUTPUT_FILES} PROPERTIES GENERATED TRUE)

include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}  # grammar is generated here
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${CMAKE_CURRENT_SOURCE_DIR}/../Value/include
    ${Boost_INCLUDE_DIRS}
)

file(GLOB SRCS src/*.cpp)
add_library(HierSys SHARED ${SRCS})
target_link_libraries(HierSys ${ANTLR_LIBRARY})
add_dependencies(HierSys parser)

# These executable require libValue which is outside this project. To build
# these targets, call top-level cmake file.
add_executable(hierSys2Vhdl util/hierSys2Vhdl.cpp)
target_link_libraries(hierSys2Vhdl HierSys parser Value ${Boost_LIBRARIES})

add_executable(hierSys2C util/hierSys2C.cpp)
target_link_libraries(hierSys2C HierSys parser Value)

add_executable(hierSysCheck util/hierSysCheck.cpp)
target_include_directories(hierSysCheck PRIVATE grammar)
target_link_libraries(hierSysCheck HierSys parser Value)

add_executable(hierSysUniquify util/hierSysUniquify.cpp)
target_include_directories(hierSysUniquify PRIVATE src)
target_link_libraries(hierSysUniquify HierSys Value parser ${ANTLR_LIBRARY})

# install
install(
    TARGETS HierSys hierSys2Vhdl hierSys2C hierSysCheck hierSysUniquify
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    )

install(FILES ${GRAMMAR_HTML_FILES} DESTINATION share/doc/ahir/)


