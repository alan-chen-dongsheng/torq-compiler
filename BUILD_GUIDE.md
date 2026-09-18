# Torq Compiler Build Guide

## Quick Start

### Build Compiler Only (Recommended)

```bash
# Build with minimal dependencies (no TensorFlow, etc.)
./scripts/build_compiler_minimal.sh

# Or with custom build directory
./scripts/build_compiler_minimal.sh ../my-build
```

### Use the Compiler

```bash
# Activate the virtual environment
source ../venv-compiler/bin/activate

# Compile a model
torq-compile model.mlir -o model.vmfb
```

## Build Scripts

### `build_compiler_minimal.sh` (Recommended)
- **Purpose**: Build only the compiler with minimal dependencies
- **Time**: ~1-2 hours for first build, ~5 minutes with ccache
- **Dependencies**: cmake, ninja, clang, python3, ccache
- **Excludes**: TensorFlow, PyTorch, and other heavy ML frameworks
- **Use case**: When you only need to compile models, not run them

### `build_compiler_only.sh`
- **Purpose**: Build compiler with full Python environment
- **Time**: ~1-2 hours for first build
- **Dependencies**: Same as minimal, but attempts to install full requirements.txt
- **Note**: May fail on Python 3.14+ due to TensorFlow compatibility

### `configure_build.sh` (Original)
- **Purpose**: Configure CMake for full build (compiler + runtime)
- **Use**: `./scripts/configure_build.sh ../iree-build`
- **Then**: `cmake --build ../iree-build --target torq`

## Compiler Targets

The compiler-only build creates these binaries:

1. **torq-compile** - Main Torq compiler binary
   - Location: `build/third_party/iree/tools/torq-compile`
   - Usage: `torq-compile input.mlir -o output.vmfb`

2. **iree-compile** - IREE compiler backend
   - Location: `build/third_party/iree/tools/iree-compile`

3. **iree-opt** - IREE optimizer
   - Location: `build/third_party/iree/tools/iree-opt`

4. **torq-mlir-lsp-server** - MLIR language server
   - Location: `build/third_party/iree/tools/torq-mlir-lsp-server`

5. **Python bindings** - torq_compiler Python package
   - Enables: `import iree.compiler.torq`

## ccache Configuration

The build scripts automatically configure ccache:
- **Cache location**: `build/ccache`
- **Cache size**: 20 GB
- **Benefit**: Subsequent builds are 5-10x faster

Check ccache stats:
```bash
ccache --show-stats
```

Clear ccache:
```bash
ccache --clear
```

## Troubleshooting

### Python Development Headers Not Found

If you see:
```
Could NOT find Python (missing: Development.Module NumPy)
```

Solution:
```bash
# Ensure you're in the virtual environment
source ../venv-compiler/bin/activate

# Reinstall numpy
pip install --force-reinstall numpy

# Reconfigure
cmake -B build -DPython3_EXECUTABLE=$(which python) ...
```

### TensorFlow Installation Fails

TensorFlow doesn't support Python 3.14+ yet. Use the minimal build script:
```bash
./scripts/build_compiler_minimal.sh
```

### Build Takes Too Long

1. **First build**: 1-2 hours is normal (building LLVM, MLIR, IREE)
2. **Subsequent builds**: Should be 5-10 minutes with ccache
3. **Check ccache**: `ccache --show-stats` should show high hit rates

### macOS-specific Issues

**Problem**: `ar` doesn't support thin archives
- **Impact**: Warning only, build continues
- **Solution**: Ignore the warning

**Problem**: Linker errors with lld
- **Solution**: Ensure lld is installed: `brew install llvm`

## Advanced Usage

### Build Specific Targets

```bash
# Build only torq-compile
cmake --build build --target torq-compile

# Build only Python bindings
cmake --build build --target torq_compiler_python_bindings

# Build all compiler targets
cmake --build build --target iree-compile
cmake --build build --target iree-opt
```

### Clean Build

```bash
# Remove build directory
rm -rf build

# Clear ccache
ccache --clear

# Rebuild
./scripts/build_compiler_minimal.sh
```

### Cross-compile for Target

See `configure_soc_build.sh` for cross-compiling the runtime for embedded targets.

## Documentation

- **User Manual**: `doc/user-manual/`
- **Developer Manual**: `doc/dev-manual/`
- **Online Docs**: https://synaptics-torq.github.io/torq-compiler/

## System Requirements

### Minimum
- **OS**: macOS 12+ or Ubuntu 22.04+
- **RAM**: 16 GB (32 GB recommended)
- **Disk**: 20 GB for build + 20 GB for ccache
- **CPU**: 4+ cores (more is better)

### Required Tools
- cmake >= 3.21
- ninja
- clang/clang++ (LLVM toolchain)
- python3 >= 3.9
- ccache
- git

### Optional
- sccache (alternative to ccache)
- lld (LLVM linker, faster than default)

## Performance Tips

1. **Use ccache**: Already configured in build scripts
2. **Use Ninja**: Already configured (faster than make)
3. **Use lld**: Already configured (faster linking)
4. **Parallel builds**: Ninja uses all cores by default
5. **Split DWARF**: Already enabled (faster linking)

## File Structure

```
torq-compiler/
├── build/                    # Build output (created by build script)
│   ├── ccache/              # ccache storage
│   └── third_party/iree/tools/  # Compiler binaries
├── scripts/
│   ├── build_compiler_minimal.sh  # Recommended build script
│   ├── configure_build.sh    # CMake configuration
│   └── ...
├── compiler/                 # Torq compiler source
├── runtime/                  # Runtime source (not built by minimal script)
├── third_party/
│   ├── iree/                # IREE compiler framework
│   └── torq-hw/             # Hardware abstraction
└── venv-compiler/           # Python virtual environment (created)
```

## Next Steps

After building the compiler:

1. **Test the compiler**:
   ```bash
   source ../venv-compiler/bin/activate
   torq-compile tests/testdata/tosa_ops/add.mlir -o test.vmfb
   ```

2. **Read the documentation**:
   - `doc/user-manual/getting_started.md`
   - `doc/dev-manual/getting_started.md`

3. **Explore examples**:
   - Check `tests/` directory for example models

## Support

- **Issues**: https://github.com/synaptics-torq/torq-compiler/issues
- **Documentation**: https://synaptics-torq.github.io/torq-compiler/
