#!/usr/bin/env bash

rm -f coverage.html
bazel coverage //source/cpp_native/...
llvm-cov show -instr-profile=bazel-out/k8-fastbuild/testlogs/source/cpp_native/tests/multiply_tests/coverage.dat bazel-out/k8-fastbuild/bin/source/cpp_native/tests/multiply_tests -path-equivalence -use-color --format html > coverage.html

# Compatible with codecov

# llvm-profdata merge -sparse /tmp/llvm_profile/profile-*.profraw -o coverage.profdata

# llvm-cov show ./hello -instr-profile=coverage.profdata > coverage.txt
llvm-cov show -instr-profile=bazel-out/k8-fastbuild/testlogs/source/cpp_native/tests/multiply_tests/coverage.dat bazel-out/k8-fastbuild/bin/source/cpp_native/tests/multiply_tests -path-equivalence -use-color > coverage.txt
