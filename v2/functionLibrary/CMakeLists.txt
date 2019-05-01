cmake_minimum_required(VERSION 2.8)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)

add_library(fpu SHARED src/fpu.c)
add_library(timer SHARED src/timer.c)
add_library(llvm_intrinsics SHARED src/llvm_intrinsics.c)

# install
install(TARGETS fpu timer llvm_intrinsics
    LIBRARY DESTINATION lib
    )
