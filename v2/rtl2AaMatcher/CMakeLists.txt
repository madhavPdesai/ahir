cmake_minimum_required(VERSION 2.8)

file(GLOB SRCS src/*.c)
file(GLOB INCLUDE_SRCS src/*.h)

include_directories( 
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${CMAKE_CURRENT_SOURCE_DIR}/../BitVectors/include
    ${CMAKE_CURRENT_SOURCE_DIR}/../pthreadUtils/include
    )
add_library(Rtl2AaMatcher SHARED ${SRCS})
set_target_properties(Rtl2AaMatcher PROPERTIES PUBLIC_HEADER "${INCLUDE_SRCS}")

# Tests
set(CMAKE_THREAD_PREFER_PTHREAD ON)
find_package(Threads REQUIRED)
add_executable(Rtl2AaMatcherTest util/testRtl2AaMatcher.c)
target_include_directories(Rtl2AaMatcherTest PRIVATE ../CtestBench/include)
target_link_libraries(Rtl2AaMatcherTest ${CMAKE_THREAD_LIBS_INIT})
target_link_libraries(Rtl2AaMatcherTest Rtl2AaMatcher 
    BitVectors SockPipes PipeHandler
    )

enable_testing()
add_test(NAME Rtl2AaMatcherTest COMMAND $<TARGET_FILE:Rtl2AaMatcherTest>)

# install
include(GNUInstallDirs)
install(TARGETS Rtl2AaMatcher
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    )

