#!/bin/bash
set -euo pipefail
which clang
CC=clang CXX=clang cmake -B build_test -DTEST_BUILD=1 -GNinja -DCMAKE_BUILD_TYPE=Debug
ninja -C build_test
file build_test/api-test
ctest --test-dir build_test --output-on-failure
