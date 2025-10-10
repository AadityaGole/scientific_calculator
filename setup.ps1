<#
Setup script for Scientific Calculator project (Windows PowerShell)
Steps:
1. Create folder structure
2. Generate calculator + CLI + tests files
3. Create venv and install dependencies
4. Run unit tests
#>

Write-Host "=== Setting up Scientific Calculator project ===" -ForegroundColor Cyan

# 1. Create folder structure
New-Item -ItemType Directory -Force -Path "calculator" | Out-Null
New-Item -ItemType Directory -Force -Path "tests" | Out-Null

# 2. Create core files

# calculator/__init__.py
@'
from .calc import sqrt, factorial, ln, power

__all__ = ["sqrt", "factorial", "ln", "power"]
'@ | Set-Content "calculator\__init__.py"

# calculator/calc.py
@'
import math

def sqrt(x: float) -> float:
    if x < 0:
        raise ValueError("sqrt: x must be >= 0")
    return math.sqrt(x)

def factorial(n: int) -> int:
    if not isinstance(n, int):
        raise ValueError("factorial: n must be an integer")
    if n < 0:
        raise ValueError("factorial: n must be >= 0")
    return math.factorial(n)

def ln(x: float) -> float:
    if x <= 0:
        raise ValueError("ln: x must be > 0")
    return math.log(x)

def power(x: float, b: float) -> float:
    return x ** b
'@ | Set-Content "calculator\calc.py"

# calculator_cli.py
@'
#!/usr/bin/env python3
import argparse
from calculator import sqrt, factorial, ln, power

def interactive_menu():
    while True:
        print("\\nScientific Calculator")
        print("1) sqrt (√x)")
        print("2) factorial (!x)")
        print("3) ln (natural logarithm)")
        print("4) power (x^b)")
        print("5) exit")
        choice = input("Choose: ").strip()
        try:
            if choice == "1":
                x = float(input("Enter x: "))
                print("Result:", sqrt(x))
            elif choice == "2":
                n = int(input("Enter non-negative integer n: "))
                print("Result:", factorial(n))
            elif choice == "3":
                x = float(input("Enter x (>0): "))
                print("Result:", ln(x))
            elif choice == "4":
                x = float(input("Enter x: "))
                b = float(input("Enter b: "))
                print("Result:", power(x, b))
            elif choice == "5":
                break
            else:
                print("Invalid choice.")
        except Exception as e:
            print("Error:", e)

def main():
    parser = argparse.ArgumentParser(description="Scientific Calculator (menu + CLI flags)")
    parser.add_argument("--sqrt", type=float, help="compute sqrt(x)")
    parser.add_argument("--fact", type=int, help="compute factorial(n)")
    parser.add_argument("--ln", type=float, help="compute ln(x)")
    parser.add_argument("--pow", nargs=2, type=float, metavar=("X", "B"), help="compute x^b")
    args = parser.parse_args()

    if args.sqrt is None and args.fact is None and args.ln is None and args.pow is None:
        interactive_menu()
        return

    try:
        if args.sqrt is not None:
            print(sqrt(args.sqrt))
        if args.fact is not None:
            print(factorial(args.fact))
        if args.ln is not None:
            print(ln(args.ln))
        if args.pow is not None:
            x, b = args.pow
            print(power(x, b))
    except Exception as e:
        print("Error:", e)

if __name__ == "__main__":
    main()
'@ | Set-Content "calculator_cli.py"

# tests/__init__.py
New-Item -ItemType File -Force -Path "tests\__init__.py" | Out-Null

# tests/test_calc.py
@'
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
'@ | Set-Content "tests\test_calc.py"

# requirements.txt
@'
# No external dependencies for now
'@ | Set-Content "requirements.txt"

# 3. Virtual environment setup
if (-Not (Test-Path ".venv")) {
    Write-Host "Creating virtual environment..." -ForegroundColor Yellow
    python -m venv .venv
}
. .\.venv\Scripts\Activate.ps1
Write-Host "Installing dependencies..." -ForegroundColor Yellow
pip install -U pip
pip install -r requirements.txt

# 4. Run tests
Write-Host "Running unit tests..." -ForegroundColor Yellow
python -m unittest discover -s tests -p "test_*.py" -v

Write-Host "`n=== Setup complete! ===" -ForegroundColor Green
