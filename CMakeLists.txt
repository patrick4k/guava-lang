cmake_minimum_required(VERSION 3.0)
project(guava-lang)

find_package(LLVM REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

llvm_map_components_to_libnames(LLVM_LIBS support core irreader)

add_executable(guava src/main.cpp)

target_link_libraries(guava ${LLVM_LIBS})
