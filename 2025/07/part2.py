#!/usr/bin/env python3

import sys
from functools import reduce

def time_split(grid, row, col, memo=None):
    if memo is None:
        memo = {}

    # Check if we've already computed this cell
    if (row, col) in memo:
        return memo[(row, col)]

    if row >= len(grid):
        return 0
    if col < 0 or col >= len(grid[row]):
       return 0

    cell = grid[row][col]
    split = 0
    if cell == '^':
        # Split into two beams
        split = 1
        split += time_split(grid, row + 1, col + 1, memo)
        split += time_split(grid, row + 1, col - 1, memo)
    elif cell == '.':
        # Continue straight down
        split += time_split(grid, row + 1, col, memo)
    else:
        # For any other character, continue moving
        split += time_split(grid, row + 1, col, memo)

    # Store the result before returning
    memo[(row, col)] = split
    return split

def main():
    if len(sys.argv) != 2:
        print("Usage: python process_file.py <filename>")
        sys.exit(1)

    filename = sys.argv[1]

    try:
        with open(filename, 'r') as file:
            content = file.read().strip()

        # Load the grid into memory
        grid = [list(line) for line in content.split('\n')]

        # Find the index of 'S' in the first line
        s_index = grid[0].index('S')
        split_count = time_split(grid, 1, s_index) + 1

        print(f"Split count: {split_count}")

    except FileNotFoundError:
        print(f"Error: File '{filename}' not found")
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
