cmake_minimum_required(VERSION 2.8)
file(GLOB PTHREAD_HEADERS include/*.h)

install(FILES ${PTHREAD_HEADERS} DESTINATION include)

