#!/bin/bash

# Save the current working directory
original_dir=$(pwd)

# Default values
COMPUTE_TYPE="CUDA"

# Read parameters
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -compute_type) COMPUTE_TYPE="$2"; shift ;;
        -cuda_arch) CUDA_ARCH="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done


# Create and navigate to the build directory
mkdir -p /content/1211/RUN/build_12folder
cd /content/1211/RUN/build_12folder || exit

# Check if CUDA_ARCH is set, if not, perform a different action
if [ -z "$CUDA_ARCH" ]; then
    # Run CMake and pass the arguments
    cmake /content/1211/RUN/

    make
else
    cmake -DCUDA_ARCH=$CUDA_ARCH ..
    # Compile the project
    make
fi

# Return to the original working directory
cd "$original_dir" || exit

if [ -e miner_12.sh ]; then
    chmod +x miner_12.sh
else
    echo "1miner_kouda11.sh does not exist."
fi
