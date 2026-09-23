#!/usr/bin/bash
rm -rf install

rm -rf build
mkdir build
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS="-DBUILDING_JAI_BINDINGS=1"
cmake --build build
cmake --install build --prefix ./install/release
rm -rf ./install/release/lib64/cmake

rm -rf build
mkdir build
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_FLAGS="-DBUILDING_JAI_BINDINGS=1"
cmake --build build
cmake --install build --prefix ./install/debug
rm -rf ./install/debug/lib64/cmake
