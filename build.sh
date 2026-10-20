# Simple build script that wraps cmake commands, produces an install/ dir
#!/usr/bin/env bash
set -euo pipefail

mkdir build || true

BUILD_TYPE=Release

if [[ "$OSTYPE" == darwin* ]]; then
    echo "macOS"

    cmake --fresh -S . -B build \
        -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
        -DCMAKE_OSX_SYSROOT=macosx \
        -DNOGRAPHICSAPI_BUILD_EXAMPLES=ON \
        -DNOGRAPHICSAPI_BUILD_TESTS=OFF

    #ctest --test-dir build --output-on-failure
    #build/examples/triangle/example_triangle
elif [[ "$OSTYPE" == linux* ]]; then
    echo "Linux"

    cmake --fresh -S . -B build -DCMAKE_BUILD_TYPE=$BUILD_TYPE

elif [[ "$OSTYPE" == msys* || "$OSTYPE" == cygwin* ]]; then
    echo "Windows"
    echo "TODO"
    exit 1
else
    echo "Unknown: $OSTYPE"
    exit 1
fi

cmake --build build

rm -rf install
mkdir install
cmake --install build --prefix ./install
rm -rf install/**/cmake

echo "\nDone. See install/ for a $BUILD_TYPE build"
