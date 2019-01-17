#include "source/cpp_native/add/add.h"
#include "gtest/gtest.h"

class AddTests : public ::testing::Test {};

TEST_F(AddTests, AddOne) { EXPECT_EQ(4.0, add_one(3.0)); }

TEST_F(AddTests, AddTwo) { EXPECT_EQ(4.0, add_two(2.0)); }

TEST_F(AddTests, AddTwoAgain) { EXPECT_EQ(5.0, add_two(3.0)); }

TEST_F(AddTests, AddThree) { EXPECT_EQ(3.0, add_three(0.0)); }

TEST_F(AddTests, AddFourAndFive) { EXPECT_EQ(9.0, add_four(add_five(0.0))); }
