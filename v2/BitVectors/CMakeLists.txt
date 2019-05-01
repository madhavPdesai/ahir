cmake_minimum_required(VERSION 2.8)

include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${CMAKE_CURRENT_SOURCE_DIR}/../pipeHandler/include
    ${CMAKE_CURRENT_SOURCE_DIR}/../CtestBench/include
)

find_package(Threads REQUIRED)

file(GLOB BITVECTORS_SRC src/*.c)
file(GLOB BITVECTORS_INCLUDE include/*.h)

add_library(BitVectors SHARED ${BITVECTORS_SRC}) 
set_target_properties(BitVectors PROPERTIES PUBLIC_HEADER
    "${BITVECTORS_INCLUDE}")

# Tests
add_executable(test_bit_vectors util/test_bit_vectors.c)
target_link_libraries(test_bit_vectors BitVectors
    BitVectors
    SockPipes
    PipeHandler
    ${CMAKE_THREAD_LIBS_INIT}
    )

enable_testing()
add_test(NAME test_bit_vectors COMMAND $<TARGET_FILE:test_bit_vectors>)

# install
include(GNUInstallDirs)
install(TARGETS BitVectors 
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    )
