cmake_minimum_required(VERSION 2.8.12)
set(CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} -pedantic -Wall -W -Wshadow -Werror -std=c++0x -O2 $ENV{COVERAGE}")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -s $ENV{COVERAGE}")

add_subdirectory(../naxos-arc-consistency ../naxos-arc-consistency)

add_executable(nqueens.AC nqueens.cpp)
target_link_libraries(nqueens.AC naxos-AC)
target_include_directories(nqueens.AC PRIVATE ../naxos-arc-consistency)

add_executable(crew_scheduling.AC crew_scheduling/crew_scheduling.cpp)
target_link_libraries(crew_scheduling.AC naxos-AC)
target_include_directories(crew_scheduling.AC PRIVATE ../naxos-arc-consistency)

add_executable(tsp.AC TSP/tsp.cpp)
target_link_libraries(tsp.AC naxos-AC)
target_include_directories(tsp.AC PRIVATE ../naxos-arc-consistency)

add_executable(magic_square.AC magic_square.cpp)
target_link_libraries(magic_square.AC naxos-AC)
target_include_directories(magic_square.AC PRIVATE ../naxos-arc-consistency)

execute_process(COMMAND git clone https://github.com/pothitos/naxos.git
                ../naxos-bounds-consistency)

add_subdirectory(../naxos-bounds-consistency/core
                 ../naxos-bounds-consistency/core)

add_executable(nqueens.BC nqueens.cpp)
target_link_libraries(nqueens.BC naxos)
target_include_directories(nqueens.BC PRIVATE ../naxos-bounds-consistency/core)

add_executable(crew_scheduling.BC crew_scheduling/crew_scheduling.cpp)
target_link_libraries(crew_scheduling.BC naxos)
target_include_directories(crew_scheduling.BC
                           PRIVATE ../naxos-bounds-consistency/core)

add_executable(tsp.BC TSP/tsp.cpp)
target_link_libraries(tsp.BC naxos)
target_include_directories(tsp.BC PRIVATE ../naxos-bounds-consistency/core)

add_executable(magic_square.BC magic_square.cpp)
target_link_libraries(magic_square.BC naxos)
target_include_directories(magic_square.BC
                           PRIVATE ../naxos-bounds-consistency/core)

enable_testing()
add_test(verification verification.sh)
