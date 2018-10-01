filegroup(
    name = "srcs",
    srcs = glob(["*.py"]) + [
        "BUILD",

"//source/py_native/fibonacci:srcs",
    ],
    visibility = ["//visibility:public"],
)

py_binary(
    srcs = ["bin.py"],
    name = "bin",
    deps = [
        ":lib",
        "//source/py_native/fibonacci",
    ],
)

py_library(
    name = "lib",
    srcs = ["lib.py"],
)

py_test(
    name = "test",
    srcs = ["test.py"],
    deps = [
        ":lib",
        "//source/py_native/fibonacci",
    ],
)

py_test(
    name = "test_numpy",
    srcs = ["test_numpy.py"],
    deps = [
    ],
)

# py_test(
#     name = "fail",
#     srcs = ["fail.py"],
#     deps = [":lib"],
# )
