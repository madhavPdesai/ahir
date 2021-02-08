cmake_minimum_required(VERSION 2.8)
file(GLOB HEADERS include/*.h)

# Install
include(GNUInstallDirs)
install(FILES ${HEADERS} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
