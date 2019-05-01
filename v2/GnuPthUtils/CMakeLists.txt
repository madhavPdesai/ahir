cmake_minimum_required(VERSION 2.8)
file(GLOB HEADERS include/*.h)

install(FILES ${HEADERS} DESTINATION include)
