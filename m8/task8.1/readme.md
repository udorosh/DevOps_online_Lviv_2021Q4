## Task 8.1

**Quadratic equation solving with python3**

[quad_equation.py](https://github.com/udorosh/DevOps_online_Lviv_2021Q4/blob/master/m8/task8.1/quad_equation.py)
```python
#!/usr/bin/env python3

import sys, os
import math


def main():
    a = validate_param("Type in a: ", 3)
    b = validate_param("Type in b: ", 3)
    c = validate_param("Type in c: ", 3)

    #print(f"a={a} b={b} c={c}")
    square_print(a, b, c, roots(discriminant(a, b, c), a, b, c))
    sys.exit(os.EX_OK)

def validate_param(msg, turn):
    turn = 3
    while turn > 0:
        try:
            number = int(input(msg))
        except ValueError:
            turn -= 1
            print("Sorry, expected an integer number.")
            continue
        else:
            return number
    sys.exit(os.EX_DATAERR)


def discriminant(a, b, c):
    return b * b - 4 * a * c


def roots(d, a, b, c):
    if d > 0:
        x1 = (-b - math.sqrt(abs(d))) / (2 * a)
        x2 = (-b + math.sqrt(abs(d))) / (2 * a)
        return (round(x1, 2), round(x2, 2))
    elif d == 0:
        x1 = -b / (2 * a)
        return (round(x1, 2), None)
    else:
        return (None, None)


def solv_square(a, b, c) -> roots:
    d = discriminant(a, b, c)
    return roots(d, a, b, c)


def square_print(a, b, c, roots):
    x1, x2 = roots
    print(f"Equation: {a}x^2 + {b}x + {c} = 0")
    print(f"Square equation roots: {x1} and {x2}")

if __name__ == "__main__":
    main()
```

**Unit testing**

[unit_test.py](https://github.com/udorosh/DevOps_online_Lviv_2021Q4/blob/master/m8/task8.1/unit_test.py)
```python
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
```