cmake_minimum_required(VERSION 2.8)
file(GLOB PTHREAD_HEADERS include/*.h)

# install
include(GNUInstallDirs)
install(FILES ${PTHREAD_HEADERS} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

