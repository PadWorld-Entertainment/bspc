BUILD_TYPE ?= Debug

all:
	mkdir -p build && cd build && cmake .. -DCMAKE_BUILD_TYPE=$(BUILD_TYPE) && cmake --build .
