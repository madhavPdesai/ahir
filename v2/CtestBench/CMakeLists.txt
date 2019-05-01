cmake_minimum_required(VERSION 2.8)

# TODO: See the file SConscript which has modelsim related configuration as
# well. 

include_directories( ${CMAKE_CURRENT_SOURCE_DIR}/include )
include_directories( ${CMAKE_CURRENT_SOURCE_DIR}/../pthreadUtils/include)

add_library(Vhpi SHARED 
    src/Vhpi.c 
    src/SocketLib.c
    )
set_target_properties(Vhpi PROPERTIES PUBLIC_HEADER include/Vhpi.h)


add_library(SocketLibPipeHandler SHARED 
    src/SocketLib.c 
    src/Pipes.c 
    src/SockPipes.c 
    src/pipeHandler.c
    )
set_target_properties(SocketLibPipeHandler 
    PROPERTIES PUBLIC_HEADER include/SocketLib.h
    )

add_library(SockPipes SHARED
    src/SocketLib.c 
    src/SockPipes.c
    )

set_target_properties(SockPipes 
    PROPERTIES PUBLIC_HEADER include/SockPipes.h
    )

# install
install(TARGETS Vhpi SocketLibPipeHandler SockPipes
    LIBRARY DESTINATION lib
    PUBLIC_HEADER DESTINATION include
    )
install(FILES docs/CtestBench.pdf 
    DESTINATION share/doc/ahir/pdf
    )
