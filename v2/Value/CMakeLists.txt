file(GLOB VALUE_SRC src/*.cpp)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
add_library(Value SHARED ${VALUE_SRC})

add_executable(testValue util/TestValue.cpp)
target_link_libraries(testValue Value)

# NO INSTALL TARGETS HERE.
