cmake_minimum_required(VERSION 3.0)
project(guava-lang)

# LLVM -----------------------------------------------------------
find_package(LLVM REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

llvm_map_components_to_libnames(LLVM_LIBS support core irreader)

# ANTLR4 -----------------------------------------------------------
add_subdirectory(antlr4-cpp-runtime)


# GUAVA -----------------------------------------------------------
add_executable(guava src/main.cpp
    gen/GuavaBaseListener.cpp
    gen/GuavaBaseListener.h
    gen/GuavaLexer.cpp
    gen/GuavaLexer.h
    gen/GuavaListener.cpp
    gen/GuavaListener.h
    gen/GuavaParser.cpp
    gen/GuavaParser.h
)

target_link_libraries(guava ${LLVM_LIBS})

target_link_libraries(guava antlr4_cpp_runtime)

