cmake_minimum_required(VERSION 2.8)

# Build llvm2.0 before anything else.
set(LLVM_INSTALL_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../external/_llvm28_install)

set(LLVM_CONFIG_BIN ${LLVM_INSTALL_DIR}/bin/llvm-config)

if(NOT EXISTS ${LLVM_CONFIG_BIN})
    message(FATAL_ERROR "Install llvm2.8 first"
        "Run cmake in ./external/ directory"
        )
endif()

include_directories(${LLVM_INSTALL_DIR}/include)

execute_process(COMMAND
    ${LLVM_CONFIG_BIN} --cxxflags
    OUTPUT_VARIABLE LLVM_CXX_FLAGS
    OUTPUT_STRIP_TRAILING_WHITESPACE
    )

execute_process(COMMAND
    ${LLVM_CONFIG_BIN} --libfiles core bitreader bitwriter instrumentation scalaropts ipo
    OUTPUT_VARIABLE LLVM_STATIC_LIBS
    OUTPUT_STRIP_TRAILING_WHITESPACE
    )
separate_arguments(LLVM_STATIC_LIBS)
message(STATUS "llvm compiler flags: ${LLVM_CXX_FLAGS}")
message(STATUS "llvm libraries to link:")
foreach(_llvm_lib ${LLVM_STATIC_LIBS})
    message(STATUS "   ${_llvm_lib}")
endforeach()

# Build docs.
find_program(PDFLATEX NAMES pdflatex lualatex xelatex)
if(PDFLATEX)
    set(TEX_SOURCE_FILE ${CMAKE_CURRENT_SOURCE_DIR}/docs/llvm2aa.tex)
    set(PDF_FILE ${CMAKE_CURRENT_SOURCE_DIR}/llvm2aa.pdf)
    add_custom_command(OUTPUT ${PDF_FILE}
        COMMAND ${PDFLATEX} ${TEX_SOURCE_FILE}
        COMMENT "Generating PDF from TeX file"
        )
    add_custom_target(pdfdoc ALL DEPENDS ${PDF_FILE})
else(PDFLATEX)
    message(STATUS "pdflatex not found. No pdf will be generated.")
endif(PDFLATEX)

# BUILD llvm2aa
find_package(Threads REQUIRED)
include_directories( 
    ${CMAKE_CURRENT_SOURCE_DIR}/include 
    ${CMAKE_CURRENT_SOURCE_DIR}/../BGLWrap/include 
    )

file(GLOB SRCS src/*.cpp)
add_executable(llvm2aa ${SRCS})
set_target_properties(llvm2aa PROPERTIES COMPILE_FLAGS ${LLVM_CXX_FLAGS})
target_link_libraries(llvm2aa ${LLVM_STATIC_LIBS})
target_link_libraries(llvm2aa ${CMAKE_THREAD_LIBS_INIT})

# install 
install(TARGETS llvm2aa
    RUNTIME DESTINATION bin
    )

if(EXISTS ${PDF_FILE})
    install(FILES ${PDF_FILE} DESTINATION share/doc/ahir/pdf/)
endif()
