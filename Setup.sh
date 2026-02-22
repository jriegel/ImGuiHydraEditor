#!/bin/bash
# SetupScript Juergen Riegel 
echo -e "\033[32mSetup the build environment.\033[0m"


echo -e "\033[94mSearch for VCPKG:\033[0m"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ ! -f "$SCRIPT_DIR/vcpkg/vcpkg" ]; then
    echo -e "\033[91mERROR: vcpkg was not found in the vcpkg subfolder!\033[0m"
    echo "Please run bootstrap-vcpkg.sh in the vcpkg subfolder first."
    echo "Command: ./vcpkg/bootstrap-vcpkg.sh"
    exit 1
fi

VCPKG_DIR="$SCRIPT_DIR/vcpkg"
echo "Using VCPKG in $VCPKG_DIR"

echo -e "\033[94mSearch for cmake:\033[0m"
if ! command -v cmake &> /dev/null; then
    echo -e "\033[91mERROR: cmake was not found in path! Download and install CMAKE first!\033[0m"
    echo "See: https://cmake.org/ for details for your system."
    exit 1
fi
echo "Found cmake: $(which cmake)"

echo -e "\033[94mCheck for compiler:\033[0m"
if command -v g++ &> /dev/null; then
    echo "Found g++: $(which g++)"
    GENERATOR_STRING="Unix Makefiles"
elif command -v clang++ &> /dev/null; then
    echo "Found clang++: $(which clang++)"
    GENERATOR_STRING="Unix Makefiles"
elif command -v ninja &> /dev/null; then
    echo "Found ninja: $(which ninja)"
    GENERATOR_STRING="Ninja"
else
    echo -e "\033[91mERROR: No suitable compiler was found!\033[0m"
    echo "Please install g++ or clang++."
    exit 1
fi
echo "Using cmake generator: $GENERATOR_STRING"

cmake -G "$GENERATOR_STRING" -B LinuxBuild -S . -DCMAKE_TOOLCHAIN_FILE="$VCPKG_DIR/scripts/buildsystems/vcpkg.cmake" -DVCPKG_TARGET_TRIPLET=x64-linux
