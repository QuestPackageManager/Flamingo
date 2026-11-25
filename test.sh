#!/bin/bash
set -euo pipefail
emulator=
if [[ $(uname -m) != aarch64 ]]; then
    emulator=$(command -v qemu-aarch64 || command -v qemu-aarch64-static) || {
        echo "Install qemu-user to run the ARM64 tests." >&2
        exit 1
    }
fi
cmake -B build_test -DTEST_BUILD=1 -GNinja -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CROSSCOMPILING_EMULATOR="$emulator"
ninja -C build_test
ctest --test-dir build_test --output-on-failure
