#include "source/cpp_native/multiply.h"
#include "gtest/gtest.h"

class MultiplyTests : public ::testing::Test {};

TEST_F(MultiplyTests, TwoTimesTwo) { EXPECT_EQ(4.0, multiply_by_two(2.0)); }
