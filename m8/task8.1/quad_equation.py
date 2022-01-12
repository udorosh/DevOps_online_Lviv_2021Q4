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