cmake_minimum_required(VERSION 2.8.12)
set(CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} -pedantic -Wall -W -Wshadow -Werror -std=c++0x -O2 $ENV{COVERAGE}")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -s $ENV{COVERAGE}")

execute_process(COMMAND git clone https://github.com/pothitos/naxos.git
                ../naxos-bounds-consistency)

add_subdirectory(../naxos-bounds-consistency/core
                 ../naxos-bounds-consistency/core)

enable_testing()
add_test(verification verification.sh)
