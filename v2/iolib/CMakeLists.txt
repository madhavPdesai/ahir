cmake_minimum_required(VERSION 2.8)
file(GLOB SRC *.c)
file(GLOB IO_HEADER *.h)

# create both static and shared lib.
add_library(io SHARED ${SRC})
add_library(iostatic STATIC ${SRC})

set_target_properties(io PROPERTIES PUBLIC_HEADER ${IO_HEADER})
set_target_properties(iostatic PROPERTIES PUBLIC_HEADER ${IO_HEADER})
set_target_properties(iostatic PROPERTIES OUTPUT_NAME io)

# install
install(TARGETS io
    LIBRARY DESTINATION lib
    PUBLIC_HEADER DESTINATION include
    )
