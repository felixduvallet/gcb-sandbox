##### buildifier dependencies #####
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "com_grail_bazel_toolchain",
    sha256 = "6616b8d88426c3a6b816b517e87ce4c8f871accd55abe3dcef43117e0dc92f57",
    strip_prefix = "bazel-toolchain-0.2",
    urls = ["https://github.com/grailbio/bazel-toolchain/archive/0.2.tar.gz"],
)

load("@com_grail_bazel_toolchain//toolchain:configure.bzl", "llvm_toolchain")

llvm_toolchain(
    name = "llvm_toolchain",
    llvm_version = "7.0.0",

    # using the precompiled clang for 16.04 because one doesn't exist for 18.04 yet.
    strip_prefix = {"linux": "clang+llvm-7.0.0-x86_64-linux-gnu-ubuntu-16.04"},
    urls = {"linux": ["http://releases.llvm.org/7.0.0/clang+llvm-7.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz"]},
)

# buildifier is written in Go and hence needs rules_go to be built.
# See https://github.com/bazelbuild/rules_go for the up to date setup instructions.
http_archive(
    name = "io_bazel_rules_go",
    sha256 = "c1f52b8789218bb1542ed362c4f7de7052abcf254d865d96fb7ba6d44bc15ee3",
    url = "https://github.com/bazelbuild/rules_go/releases/download/0.12.0/rules_go-0.12.0.tar.gz",
)

http_archive(
    name = "com_github_bazelbuild_buildtools",
    strip_prefix = "buildtools-0.15.0",
    url = "https://github.com/bazelbuild/buildtools/archive/0.15.0.zip",
)

new_git_repository(
    name = "googletest",
    build_file = "third_party/gtest.BUILD",
    remote = "https://github.com/google/googletest",
    tag = "release-1.8.1",
)

load("@io_bazel_rules_go//go:def.bzl", "go_register_toolchains", "go_rules_dependencies")
load("@com_github_bazelbuild_buildtools//buildifier:deps.bzl", "buildifier_dependencies")

go_rules_dependencies()

go_register_toolchains()

buildifier_dependencies()
