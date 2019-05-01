cmake_minimum_required(VERSION 2.8)

# Otherwise linking errors with libantrl.a etc.
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++98")

add_subdirectory(Value)
add_subdirectory(iolib)
add_subdirectory(libAhirV2)
add_subdirectory(Ahir-asm/devel)

add_subdirectory(CtestBench)
add_subdirectory(pipeHandler)
add_subdirectory(functionLibrary)
add_subdirectory(BitVectors)
add_subdirectory(HierSysBuild)
add_subdirectory(rtl2AaMatcher)

# Following two only have headers.
add_subdirectory(pthreadUtils)
add_subdirectory(GnuPthUtils)

# This is tricky. We need to build llvm2.8 first before we can build llvmbc2Aa
add_subdirectory(external)

# add_subdirectory(llvmbc2Aa)
set(LLVMBC2AA_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/llvmbc2Aa)
set(LLVMBC2AA_BIN ${CMAKE_CURRENT_BINARY_DIR}/llvm2aa)
add_custom_command(OUTPUT ${LLVMBC2AA_BIN}
    COMMAND ${CMAKE_COMMAND} ${LLVMBC2AA_SOURCE_DIR}
    COMMAND $(MAKE)
    WORKING_DIRECTORY ${LLVMBC2AA_SOURCE_DIR} 
    )
add_custom_target(llvm2a_tgt ALL DEPENDS ${LLVMBC2AA_BIN})
add_dependencies(llvm2a_tgt llvm28) # in external

install(PROGRAMS 
    ${CMAKE_CURRENT_SOURCE_DIR}/Scripts/ghdlSanitize.sh 
    ${CMAKE_CURRENT_SOURCE_DIR}/Scripts/formatVhdlFiles.py 
    ${CMAKE_CURRENT_SOURCE_DIR}/Scripts/gdb_commands.txt  # FIXME: ??
    DESTINATION bin
    )

enable_testing()



