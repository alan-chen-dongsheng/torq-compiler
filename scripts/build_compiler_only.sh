#!/bin/bash

# Build script for Torq Compiler only (no runtime)
# This script builds only the compiler components with ccache enabled
#
# Usage:
#   ./build_compiler_only.sh [build-dir] [venv-dir]
#
# Examples:
#   ./build_compiler_only.sh                    # Use defaults: build/ and ../venv
#   ./build_compiler_only.sh ../my-build        # Custom build directory
#   ./build_compiler_only.sh ../my-build ../my-venv  # Custom build and venv

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

# Default directories
BUILD_DIR="${1:-${PROJECT_DIR}/build}"
VENV_DIR="${2:-${PROJECT_DIR}/../venv}"

echo "=========================================="
echo "Torq Compiler Build Script (Compiler Only)"
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
echo "✓ Virtual environment activated: $(which python)"
echo ""

# Install Python requirements
echo "Installing Python requirements..."
cd "${PROJECT_DIR}"
pip install --quiet --upgrade pip
pip install --quiet -r requirements.txt
echo "✓ Python requirements installed"
echo ""

# Configure build
echo "Configuring build with CMake..."
"${PROJECT_DIR}/scripts/configure_build.sh" "${BUILD_DIR}"
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

# Build compiler-specific targets
COMPILER_TARGETS=(
    "torq-compile"
    "iree-compile"
    "iree-opt"
    "torq-mlir-lsp-server"
    "torq_compiler_python_bindings"
)

for target in "${COMPILER_TARGETS[@]}"; do
    echo "Building target: ${target}"
    cmake --build "${BUILD_DIR}" --target "${target}" || {
        echo "Warning: Target ${target} failed, continuing..."
    }
done

echo ""
echo "=========================================="
echo "Build complete!"
echo "=========================================="
echo ""
echo "Compiler binaries:"
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
