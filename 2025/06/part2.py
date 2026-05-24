#!/usr/bin/env python3

import sys
from functools import reduce

def extract_numbers(cols):
    """Convert array of strings into a matrix of characters, then transpose.
    Each string is split into individual chars (digits or whitespaces).
    The matrix is then transposed (rotated left visually).
    Finally, each row is converted to a number by joining chars and stripping whitespace.
    """
    matrix = [list(s) for s in cols]
    # Transpose: columns become rows
    transposed = [list(row) for row in zip(*matrix)]
    # Convert each row to a number: join chars, strip whitespace, convert to int
    numbers = [int(''.join(row).strip()) for row in transposed]
    return numbers

def main():
    if len(sys.argv) != 2:
        print("Usage: python process_file.py <filename>")
        sys.exit(1)

    filename = sys.argv[1]

    try:
        with open(filename, 'r') as file:
            content = file.read().strip()

        # Load the grid into memory
        rows = content.split('\n')

        # Get the last row and count spaces between consecutive '*' and '+' symbols
        last_row = rows[-1]
        space_counts = []
        space_count = 0
        prev_symbol = False  # Track if we've seen a symbol before

        for char in last_row:
            if char in ('*', '+'):
                if prev_symbol:
                    space_counts.append(space_count)
                space_count = 0
                prev_symbol = True
            elif char == ' ' and prev_symbol:
                space_count += 1

        # Split each row using space_counts as column widths
        grid = []
        for row in rows: #[:-1]:  # Exclude the last row (the one with symbols)
            cols = []
            index = 0

            for count in space_counts:
                # Extract 'count' characters
                cols.append(row[index:index+count])
                index += count
                # Skip one character (the separator)
                index += 1

            # Extract the last segment after the final separator
            if index < len(row):
                cols.append(row[index:])

            grid.append(cols)

        transposed = [list(col) for col in zip(*grid)]

        count = 0
        for col in transposed:
            operation = col[-1].strip()  # Get the operation from last item
            numbers = extract_numbers(col[:-1])

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
