cmake_minimum_required(VERSION 2.8)

include(${CMAKE_CURRENT_SOURCE_DIR}/../antlr2.cmake)
message(STATUS "Antlr library: ${ANTLR_LIBRARY}")
include_directories(${ANTLR_INCLUDE_DIR})

add_definitions(-std=c++98)

ADD_ANTLR_GRAMMAR(
    ${CMAKE_CURRENT_SOURCE_DIR}/grammar/vc.g
    VC_GRAMMAR_OUTPUT_FILES VC_GRAMMAR_HTML_FILES
    )

file(GLOB LIBVC_SRC src/*.cpp)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../BGLWrap/include)

# This is where grammar is generated.
include_directories(${CMAKE_CURRENT_BINARY_DIR})

# Set definitions for antlr
add_definitions(-UNO_STATIC_CONSTS)

add_library(VC SHARED ${LIBVC_SRC} ${VC_GRAMMAR_OUTPUT_FILES})
# set_target_properties(VC PROPERTIES COMPILE_FLAGS -fPIC)
target_link_libraries(VC)

add_executable(vcParse util/vcParseMain.cpp)
target_link_libraries(vcParse VC ${ANTLR_LIBRARY}) 

add_executable(vcAnalyze util/vcAnalyze.cpp)
target_link_libraries(vcAnalyze VC ${ANTLR_LIBRARY})

add_executable(vcFormat util/vcFormat.cpp)
target_link_libraries(vcFormat VC ${ANTLR_LIBRARY}) 

add_executable(vhdlFormat util/vhdlFormat.cpp)
target_link_libraries(vhdlFormat VC ${ANTLR_LIBRARY})

add_executable(vc2vhdl util/vc2vhdl.cpp)
target_link_libraries(vc2vhdl VC ${ANTLR_LIBRARY}) 

# INSTALL
include(GNUInstallDirs)
install(TARGETS VC vcParse vcAnalyze vcFormat vhdlFormat vc2vhdl
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    )

install(FILES ${VC_GRAMMAR_HTML_FILES} 
    DESTINATION ${CMAKE_INSTALL_DOCDIR}
    )
