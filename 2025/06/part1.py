#!/usr/bin/env python3

import sys
from functools import reduce

def main():
    if len(sys.argv) != 2:
        print("Usage: python process_file.py <filename>")
        sys.exit(1)

    filename = sys.argv[1]

    try:
        with open(filename, 'r') as file:
            content = file.read().strip()

        # Load the grid into memory
        grid = [line.split() for line in content.split('\n')]

        transposed = [list(col) for col in zip(*grid)]

        count = 0
        for col in transposed:
            operation = col[-1]  # Get the operation from last item
            numbers = [int(x) for x in col[:-1]]
            result = 0
            if operation == '+':
                result = sum(numbers)
            elif operation == '*':
                result = reduce(lambda x, y: x * y, numbers)
            count += result

        # Print grid dimensions for verification
        print(f"Grid loaded: {len(grid)} rows x {len(grid[0])} cols")
        print(f"result: {count}")

    except FileNotFoundError:
        print(f"Error: File '{filename}' not found")
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
