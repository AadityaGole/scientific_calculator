import unittest
import math
from calculator.calc import sqrt, factorial, ln, power

class TestCalc(unittest.TestCase):
    def test_sqrt(self):
        self.assertAlmostEqual(sqrt(9), 3.0)
        self.assertAlmostEqual(sqrt(2), math.sqrt(2))
        with self.assertRaises(ValueError):
            sqrt(-1)

    def test_factorial(self):
        self.assertEqual(factorial(0), 1)
        self.assertEqual(factorial(5), 120)
        with self.assertRaises(ValueError):
            factorial(-1)
        with self.assertRaises(ValueError):
            factorial(3.5)

    def test_ln(self):
        self.assertAlmostEqual(ln(math.e), 1.0)
        with self.assertRaises(ValueError):
            ln(0)

    def test_power(self):
        self.assertAlmostEqual(power(2, 8), 256)
        self.assertAlmostEqual(power(9, 0.5), 3.0)

if __name__ == "__main__":
    unittest.main()
