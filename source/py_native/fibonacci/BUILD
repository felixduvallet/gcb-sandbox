filegroup(
    name = "srcs",
    srcs = glob(["*.py"]) + [
        "BUILD",
    ],
    visibility = ["//source/py_native:__pkg__"],
)

py_library(
    name = "fibonacci",
    srcs = ["fib.py"],
    imports = ["."],
    visibility = ["//source/py_native:__pkg__"],
)
