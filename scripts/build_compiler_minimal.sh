#!/bin/bash

# Minimal build script for Torq Compiler only (no runtime, no heavy dependencies)
# This script builds only the compiler components with ccache enabled
# Skips TensorFlow and other heavy dependencies not needed for compiler build
#
# Usage:
#   ./build_compiler_minimal.sh [build-dir] [venv-dir]
#
# Examples:
#   ./build_compiler_minimal.sh                    # Use defaults: build/ and ../venv-compiler
#   ./build_compiler_minimal.sh ../my-build        # Custom build directory

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

# Default directories
BUILD_DIR="${1:-${PROJECT_DIR}/build}"
VENV_DIR="${2:-${PROJECT_DIR}/../venv-compiler}"

echo "=========================================="
echo "Torq Compiler Build Script (Minimal)"
echo "=========================================="
echo "Project directory: ${PROJECT_DIR}"
echo "Build directory:   ${BUILD_DIR}"
echo "Venv directory:    ${VENV_DIR}"
echo ""

# Check prerequisites
echo "Checking prerequisites..."
for cmd in cmake ninja clang clang++ python3 ccache git; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Error: $cmd is not installed"
        exit 1
    fi
done
echo "✓ All prerequisites found"
echo ""

# Setup ccache
echo "Setting up ccache..."
export CCACHE_DIR="${BUILD_DIR}/ccache"
mkdir -p "${CCACHE_DIR}"
ccache --max-size=20G
echo "✓ ccache configured with 20G cache at ${CCACHE_DIR}"
echo ""

# Create Python virtual environment if it doesn't exist
if [[ ! -d "${VENV_DIR}" ]]; then
    echo "Creating Python virtual environment..."
    python3 -m venv "${VENV_DIR}"
    echo "✓ Virtual environment created"
fi

# Activate virtual environment
echo "Activating virtual environment..."
source "${VENV_DIR}/bin/activate"
PYTHON_EXECUTABLE="$(which python)"
echo "✓ Virtual environment activated: ${PYTHON_EXECUTABLE}"
echo ""

# Install minimal Python requirements for compiler build only
echo "Installing minimal Python requirements for compiler..."
pip install --quiet --upgrade pip setuptools wheel
pip install --quiet \
    nanobind==2.0 \
    "numpy>=2.0.0b1" \
    "ml_dtypes>=0.4.0" \
    "requests>=2.28.0" \
    sympy==1.13.3 \
    "pybind11>=2.10.1" \
    "PyYAML>=5.4.1" \
    "packaging>=24.2"
echo "✓ Minimal Python requirements installed"
echo ""

# Configure build with explicit Python paths
echo "Configuring build with CMake..."
cd "${PROJECT_DIR}"

# Detect ccache/sccache
if command -v sccache &> /dev/null; then
    echo "Found sccache, enabling it in the build"
    LAUNCHER_OPTS="-DCMAKE_C_COMPILER_LAUNCHER=sccache -DCMAKE_CXX_COMPILER_LAUNCHER=sccache"
elif command -v ccache &> /dev/null; then
    echo "Found ccache, enabling it in the build"
    LAUNCHER_OPTS="-DCMAKE_C_COMPILER_LAUNCHER=ccache -DCMAKE_CXX_COMPILER_LAUNCHER=ccache"
else
    LAUNCHER_OPTS=""
fi

cmake -B "${BUILD_DIR}" \
    -G Ninja \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DIREE_ENABLE_SPLIT_DWARF=ON \
    -DIREE_ENABLE_THIN_ARCHIVES=ON \
    -DIREE_ENABLE_LLD=ON \
    -DIREE_HAL_DRIVER_LOCAL_SYNC=ON \
    -DIREE_HAL_DRIVER_LOCAL_TASK=ON \
    ${LAUNCHER_OPTS} \
    -DIREE_BUILD_PYTHON_BINDINGS=ON \
    -DTORQ_ENABLE_SIMULATOR=ON \
    -DPython3_EXECUTABLE="${PYTHON_EXECUTABLE}" \
    -DPYTHON_EXECUTABLE="${PYTHON_EXECUTABLE}"

echo "✓ Build configured"
echo ""

# Build compiler targets only
echo "Building compiler targets..."
echo "This will build:"
echo "  - torq-compile (main compiler binary)"
echo "  - iree-compile (IREE compiler)"
echo "  - iree-opt (IREE optimizer)"
echo "  - torq-mlir-lsp-server (MLIR language server)"
echo "  - Python bindings"
echo ""
echo "Note: First build may take 1-2 hours. Subsequent builds will be faster with ccache."
echo ""

# Build compiler-specific targets
COMPILER_TARGETS=(
    "torq-compile"
    "iree-compile"
    "iree-opt"
    "torq-mlir-lsp-server"
    "torq_compiler_python_bindings"
)

for target in "${COMPILER_TARGETS[@]}"; do
    echo ""
    echo "=========================================="
    echo "Building target: ${target}"
    echo "=========================================="
    if cmake --build "${BUILD_DIR}" --target "${target}"; then
        echo "✓ Target ${target} built successfully"
    else
        echo "⚠ Warning: Target ${target} failed"
        echo "Continuing with next target..."
    fi
done

echo ""
echo "=========================================="
echo "Build complete!"
echo "=========================================="
echo ""
echo "Compiler binaries location:"
echo "  - torq-compile: ${BUILD_DIR}/third_party/iree/tools/torq-compile"
echo "  - iree-compile: ${BUILD_DIR}/third_party/iree/tools/iree-compile"
echo "  - iree-opt: ${BUILD_DIR}/third_party/iree/tools/iree-opt"
echo ""
echo "To use the compiler, activate the virtual environment:"
echo "  source ${VENV_DIR}/bin/activate"
echo ""
echo "Then run:"
echo "  torq-compile <input.mlir> -o <output.vmfb>"
echo ""
echo "ccache statistics:"
ccache --show-stats
echo ""
echo "Quick rebuild command:"
echo "  cmake --build ${BUILD_DIR} --target torq-compile"
echo ""
