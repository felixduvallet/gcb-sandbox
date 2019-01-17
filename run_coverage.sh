#!/usr/bin/env zsh
#
# NOTE: zsh is required for file globbing.
#
# Runs 'bazel coverage' on tests, then generates a code coverage report.

set -e

run_coverage=1
output='coverage-report'
output_format='html'
usage() {
    echo \
    "Usage: $0
      [-r] <0, 1>       (run coverage, default=${run_coverage})
      [-o] <name>       (output, default=${output})
      [-f] <html, text> (output format, default=${output_format})
      " 1>&2;
      exit 1;
}

while getopts 'hr:o:f:' flag; do
    case "${flag}" in
        r) run_coverage=$OPTARG
           ;;
        o) output=$OPTARG
           ;;
        f) output_format=$OPTARG
           ;;
        h | *)
            usage
            exit 0
            ;;
    esac
done
shift $((OPTIND -1))

# Find the paths to our toolchain's llvm-cov and llvm-profdata.
if [[ -z "${LLVM_DIR:=$(bazel info output_base)/external/llvm_toolchain/bin}" ]]; then
    echo "Unable to find our llvm toolchain." 1>&2
    exit 1
fi

LLVM_COV="${LLVM_DIR}/llvm-cov"
LLVM_PROFDATA="${LLVM_DIR}/llvm-profdata"

# Generate code coverage data.
if [[ ${run_coverage} -eq 1 ]];
then
    # Run all small & medium tests.
    #
    # NOTE: Exclude lanenet targets because otherwise we must build all of
    # tensorflow. (bazel test/coverage commands build all targets, not just
    # tests.)
    bazel coverage \
          --test_size_filters=small,medium \
          -- \
          //source/cpp_native/...
else
    echo 'Skipping coverage run, using previous data.'
fi

# Merge all generated coverage data files into one aggregate one.
${LLVM_PROFDATA} merge \
                 $(bazel info bazel-testlogs)/**/coverage.dat \
                 -o aggregate.dat

# Show the report on screen.
${LLVM_COV} report -instr-profile=aggregate.dat \
            -show-instantiation-summary \
            -ignore-filename-regex=external -ignore-filename-regex=bazel-out \
            $(cat $(bazel info bazel-bin)/**/tests/*.runfiles_manifest \
                  | cut -d ' ' -f 2 | grep -v gtest | grep libsource | egrep ".so$" | xargs -n 1 -I xxx echo -n "-object=xxx ")

# Create coverage report in the desired format.
if [[ ${output_format} == "html" ]];
then
    rm -rf ${output}
    ${LLVM_COV} show -format=html -output-dir=${output} \
                -instr-profile aggregate.dat \
                -ignore-filename-regex=external -ignore-filename-regex=bazel-out \
                $(cat $(bazel info bazel-bin)/**/tests/*.runfiles_manifest \
                      | cut -d ' ' -f 2 | grep -v gtest | grep libsource | egrep ".so$" | xargs -n 1 -I xxx echo -n "-object=xxx ")
    echo "Wrote HTML report to ${output}/"
elif [[ ${output_format} == "text" ]];
then
    rm -f ${output}.txt
    ${LLVM_COV} show -format=text \
                -instr-profile aggregate.dat \
                -ignore-filename-regex=external -ignore-filename-regex=bazel-out \
                $(cat $(bazel info bazel-bin)/**/tests/*.runfiles_manifest \
                      | cut -d ' ' -f 2 | grep -v gtest | grep libsource | egrep ".so$" | xargs -n 1 -I xxx echo -n "-object=xxx ") \
                > ${output}.txt
       echo "Wrote coverage to ${output}.txt"
else
    echo "Invalid report format: ${output_format}"
fi

rm aggregate.dat
