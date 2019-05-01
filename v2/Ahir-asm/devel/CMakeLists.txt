cmake_minimum_required(VERSION 2.8)

include(${CMAKE_CURRENT_SOURCE_DIR}/../../antlr2.cmake)
ADD_ANTLR_GRAMMAR(${CMAKE_CURRENT_SOURCE_DIR}/grammar/Aa.g AA_GRAMMER_OUTPUT_FILES AA_HTML_FILE)

# Add aa library.
file(GLOB AA_SRC src/*.cpp)
include_directories( 
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${CMAKE_CURRENT_SOURCE_DIR}/../../Value/include
    ${CMAKE_CURRENT_SOURCE_DIR}/../../CtestBench/include
    )

# parser is generated here
include_directories( ${CMAKE_CURRENT_BINARY_DIR} )
include_directories( ${ANTLR_INCLUDE_DIR})

# Build lexer and parser.
# add_library(aa_parser ${AA_GRAMMER_OUTPUT_FILES})
# set_target_properties(aa_parser PROPERTIES COMPILE_FLAGS -fPIC)
set_source_files_properties(${AA_GRAMMER_OUTPUT_FILES} PROPERTIES GENERATED TRUE)

add_library(Aa SHARED ${AA_SRC} ${AA_GRAMMER_OUTPUT_FILES})

add_executable(AaOpt util/AaOpt.cpp)
target_link_libraries(AaOpt Aa Value ${ANTLR_LIBRARY})

add_executable(Aa2VC util/Aa2VC.cpp)
target_link_libraries(Aa2VC Aa Value ${ANTLR_LIBRARY})

add_executable(Aa2C util/Aa2C.cpp)
target_link_libraries(Aa2C Aa Value ${ANTLR_LIBRARY})

add_executable(AaLinkExtMem util/AaLinkExtMem.cpp)
target_link_libraries(AaLinkExtMem Aa Value ${ANTLR_LIBRARY})

# INSTALL 
install( 
    TARGETS Aa AaOpt Aa2VC Aa2C AaLinkExtMem 
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin
    )
