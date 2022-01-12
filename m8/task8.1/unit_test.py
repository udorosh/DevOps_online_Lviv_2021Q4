#!/usr/bin/env python3

import quad_equation
import unittest


class QuadEquationTest(unittest.TestCase):
    def test_discriminant(self):
        self.assertEqual(quad_equation.discriminant(1, 2, 3), -8)
        self.assertEqual(quad_equation.discriminant(-7, 0, 15), 420)
        self.assertEqual(quad_equation.discriminant(-17, 12, -45), -2916)
        self.assertEqual(quad_equation.discriminant(-1, 0, 0), 0)
    def test_roots(self):
        self.assertEqual(quad_equation.roots(-8, 1, 2, 3), (None, None))
        self.assertEqual(quad_equation.roots(420, -7, 0, 15), (1.46, -1.46))
        self.assertEqual(quad_equation.roots(-2916, -17, 12, -45), (None, None))
        self.assertEqual(quad_equation.roots(-3, 1, 1, 1), (None, None))
        self.assertEqual(quad_equation.roots(0, -1, 0, 0), (0.00, None))
    def test_solv_square(self):
        self.assertEqual(quad_equation.solv_square(1, 2, 3), (None, None))
        self.assertEqual(quad_equation.solv_square(-7, 0, 15), (1.46, -1.46))
        self.assertEqual(quad_equation.solv_square(-17, 12, -45), (None, None))
        self.assertEqual(quad_equation.solv_square(1, 1, 1), (None, None))
        self.assertEqual(quad_equation.solv_square(-1, 0, 0), (0.00, None))


if __name__ == "__main__":
    unittest.main()