cmake_minimum_required(VERSION 2.6)

execute_process(COMMAND git clone https://github.com/pothitos/naxos.git
                ../naxos)

enable_testing()
add_test(verification verification.sh)
