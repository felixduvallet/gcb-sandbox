load("@com_github_bazelbuild_buildtools//buildifier:def.bzl", "buildifier")

# This target is intended to be used for fixing the format of all BUILD files in the repository.
# To use it, run:
# bazel run --direct_run //:build_beautifier
buildifier(
    name = "build_beautifier",
    mode = "fix",
    show_log = True,
    verbose = True,
)

buildifier(
    name = "build_beautifier_check_only",
    mode = "check",
    show_log = True,
    verbose = True,
)
