#include "source/cpp_native/add/add.h"
#include "gtest/gtest.h"

class AddTests : public ::testing::Test {};

TEST_F(AddTests, TwoTimesTwo) { EXPECT_EQ(4.0, add_two(2.0)); }

TEST_F(AddTests, ThreeTimesTwo) { EXPECT_EQ(5.0, add_two(3.0)); }
