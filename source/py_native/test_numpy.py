""" Try to import numpy! """

import unittest
import numpy as np

class TestNumpy(unittest.TestCase):

  def test_ok(self):
    x = np.array([1, 2, 3])
    self.assertEqual(3, x.size)


if __name__ == '__main__':
  unittest.main()
