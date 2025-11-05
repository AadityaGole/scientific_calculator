# calculator/calc.py
# test comment for webhook build
#yes
"""Core scientific functions."""
import math


def sqrt(x: float) -> float:
    if x < 0:
        raise ValueError('sqrt: x must be >= 0')
    return math.sqrt(x)


def factorial(n: int) -> int:
    if not isinstance(n, int):
        raise ValueError('factorial: n must be an integer')
    if n < 0:
        raise ValueError('factorial: n must be >= 0')
    return math.factorial(n)


def ln(x: float) -> float:
    if x <= 0:
        raise ValueError('ln: x must be > 0')
    return math.log(x)


def power(x: float, b: float) -> float:
    return x ** b
