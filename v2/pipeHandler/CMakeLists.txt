cmake_minimum_required(VERSION 2.8)

include_directories(../pthreadUtils/include)
include_directories(include)

file(GLOB PIPEHANDLER_HEADERS include/*.h)
message(STATUS "Header files: ${PIPEHANDLER_HEADERS}")

add_library(PipeHandler SHARED src/pipeHandler.c src/Pipes.c)

set_target_properties(PipeHandler PROPERTIES PUBLIC_HEADER "${PIPEHANDLER_HEADERS}")

# INSTALL
include(GNUInstallDirs)
install(TARGETS PipeHandler 
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    )
