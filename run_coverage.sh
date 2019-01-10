#!/usr/bin/env zsh

set -x
set -e

rm -f coverage.html
rm -f coverage.txt
bazel build //source/...
bazel coverage //source/cpp_native/...

# Compatible with codecov
# llvm-profdata merge -sparse /tmp/llvm_profile/profile-*.profraw -o coverage.profdata
# llvm-cov show ./hello -instr-profile=coverage.profdata > coverage.txt

coverage_files=$(ls bazel-out/k8-fastbuild/testlogs/source/cpp_native/**/coverage.dat)
test_files=$(ls bazel-out/k8-fastbuild/bin/source/cpp_native/**/tests/*_tests)

## Merge then parse
llvm-profdata merge \
              bazel-out/k8-fastbuild/testlogs/source/cpp_native/**/coverage.dat \
               -o aggregate.dat

llvm-cov show -instr-profile=aggregate.dat \
         -object=bazel-out/k8-fastbuild/bin/source/cpp_native/add/tests/add_tests \
         bazel-out/k8-fastbuild/bin/source/cpp_native/**/*_tests \
         -use-color > coverage.txt

llvm-cov show --format html -instr-profile=aggregate.dat \
         -object=bazel-out/k8-fastbuild/bin/source/cpp_native/add/tests/add_tests \
         bazel-out/k8-fastbuild/bin/source/cpp_native/multiply/tests/multiply_tests \
         > coverage.html

llvm-cov report -instr-profile=aggregate.dat \
         -object=bazel-out/k8-fastbuild/bin/source/cpp_native/add/tests/add_tests \
         bazel-out/k8-fastbuild/bin/source/cpp_native/multiply/tests/multiply_tests

echo 'Finished'

# cat coverage.txt
