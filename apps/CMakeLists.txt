cmake_minimum_required(VERSION 2.6)

set(CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} -pedantic -Wall -W -Wshadow -Werror -std=c++0x -O2 $ENV{COVERAGE}")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -s $ENV{COVERAGE}")

include_directories(../naxos-arc-consistency)
add_subdirectory(../naxos-arc-consistency ../naxos-arc-consistency)

add_executable(nqueens.AC nqueens.cpp)
target_link_libraries(nqueens.AC naxos-AC)
