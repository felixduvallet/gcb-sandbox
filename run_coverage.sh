#!/usr/bin/env zsh

set -x
set -e

rm -f coverage.html
rm -f coverage.txt
rm -rf report-html/
rm -rf report/

bazel test //source/...
bazel coverage  //source/cpp_native/...

# find bazel-bin/ -executable -type f | grep tests$ | uniq

## Merge then parse
llvm-profdata merge -sparse=false \
              bazel-out/k8-fastbuild/testlogs/source/cpp_native/**/coverage.dat \
               -o aggregate.dat

OBJ_FILES=(-object=bazel-bin/source/cpp_native/add/libadd.so \
                  -object=bazel-bin/source/cpp_native/multiply/libmultiply.so \
                  -object=bazel-bin/source/cpp_native/power/libpower.so)

llvm-cov show -instr-profile=aggregate.dat  ${OBJ_FILES[*]} > coverage.txt

llvm-cov show --format html -output-dir=report-html/  -instr-profile=aggregate.dat  ${OBJ_FILES[*]} > coverage.html

llvm-cov report -instr-profile=aggregate.dat ${OBJ_FILES[*]}

echo '----'

ADD_OBJ_FILES=$(cat bazel-out/k8-fastbuild/bin/source/cpp_native/add/tests/add_tests.runfiles_manifest\
                    | cut -d ' ' -f 2 | grep -v gtest | egrep ".so$" | xargs -n 1 -I xxx echo -n "-object xxx ")

echo ${ADD_OBJ_FILES[*]}
return

llvm-cov report -instr-profile=aggregate.dat \
         -verify-region-info -show-instantiation-summary \
         ${ADD_OBJ_FILES[*]}

llvm-cov show -format=html -output-dir=report/ \
         -instr-profile aggregate.dat \
         $(cat bazel-out/k8-fastbuild/bin/source/cpp_native/add/tests/add_tests.runfiles_manifest\
               | cut -d ' ' -f 2 | grep -v gtest | egrep ".so$" | xargs -n 1 -I xxx echo -n "-object xxx ")


# (LLVM_COV_CMD="llvm-cov-3.9 show -format=html -output-dir=$(pwd)/report/ -instr-profile bazel-out/k8-fastbuild/testlogs/src/test/cpp/option_processor_test/coverage.dat bazel-out/k8-fastbuild/bin/src/test/cpp/option_processor_test $(cat bazel-out/k8-fastbuild/bin/src/test/cpp/option_processor_test.runfiles_manifest | cut -d' ' -f 2 | egrep ".so$" | xargs -n 1 -I xxx echo -n "-object xxx ")" && cd bazel-os-bazel && $LLVM_COV_CMD)

echo 'Finished'
