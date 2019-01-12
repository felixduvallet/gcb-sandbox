#include "source/cpp_native/power/power.h"
#include "gtest/gtest.h"

class PowerTests : public ::testing::Test {};

TEST_F(PowerTests, SquareTwo) { EXPECT_EQ(9.0, square(3.0)); }

TEST_F(PowerTests, CubeTwo) { EXPECT_EQ(8.0, cube(2.0)); }
