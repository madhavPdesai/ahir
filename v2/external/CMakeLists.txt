cmake_minimum_required(VERSION 2.8)

# Install llvm-2.8
include(ExternalProject)

set(LLVM_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/llvm-2.8)

# Make sure this variable is also the same in ../llvmbc2Aa/CMakeLists.txt files.
set(LLVM_INSTALL_DIR ${CMAKE_CURRENT_SOURCE_DIR}/_llvm28_install)

ExternalProject_Add(llvm28
    PREFIX _llvm
    SOURCE_DIR ${LLVM_SOURCE_DIR}
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${LLVM_INSTALL_DIR} -Wno-dev
    -DCMAKE_CXX_FLAGS="-std=c++98"
    -DLLVM_TARGETS_TO_BUILD=X86;ARM
    BUILD_COMMAND $(MAKE) -j4
    )

set(ANTLR_INSTALL_DIR ${CMAKE_CURRENT_SOURCE_DIR}/_antlr_install)
ExternalProject_Add(antlr27
    PREFIX _antlr
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/antlr-2.7.7
    CONFIGURE_COMMAND 
        <SOURCE_DIR>/configure --prefix=${ANTLR_INSTALL_DIR} 
            --enable-cpp --disable-python
    BUILD_COMMAND $(MAKE) VERBOSE=1 CXXFLAGS=-DANTLR_REALLY_NO_STRCASECMP
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    )
