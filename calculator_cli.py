#!/usr/bin/env python3
"""Menu-driven CLI plus command-line flags."""
import argparse
from calculator import sqrt, factorial, ln, power




def interactive_menu():
    while True:
        print('\nScientific Calculator')
        print('1) sqrt (√x)')
        print('2) factorial (!x)')
        print('3) ln (natural logarithm)')
        print('4) power (x^b)')
        print('5) exit')
        choice = input('Choose: ').strip()
        try:
            if choice == '1':
                x = float(input('Enter x: '))
                print('Result:', sqrt(x))
            elif choice == '2':
                n = int(input('Enter non-negative integer n: '))
                print('Result:', factorial(n))
            elif choice == '3':
                x = float(input('Enter x (>0): '))
                print('Result:', ln(x))
            elif choice == '4':
                x = float(input('Enter x: '))
                b = float(input('Enter b: '))
                print('Result:', power(x, b))
            elif choice == '5':
                break
            else:
                print('Invalid choice.')
        except Exception as e:
            print('Error:', e)




def main():
    parser = argparse.ArgumentParser(description='Scientific Calculator (menu + CLI flags)')
    parser.add_argument('--sqrt', type=float, help='compute sqrt(x)')
    parser.add_argument('--fact', type=int, help='compute factorial(n)')
    parser.add_argument('--ln', type=float, help='compute ln(x)')
    parser.add_argument('--pow', nargs=2, type=float, metavar=('X', 'B'), help='compute x^b')


    args = parser.parse_args()


    # If no flags provided, show interactive menu
    if args.sqrt is None and args.fact is None and args.ln is None and args.pow is None:
        interactive_menu()
        return


    # Otherwise compute requested values and print them
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
        print('Error:', e)




if __name__ == '__main__':
    main()