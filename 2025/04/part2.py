#!/usr/bin/env python3

import sys

def count_adjacent_symbols(grid, row, col, symbol='@'):
    """Count how many adjacent cells contain the specified symbol."""
    rows = len(grid)
    cols = len(grid[0]) if grid else 0
    adjacent_count = 0

    # Check all 8 directions (including diagonals)
    for dr in [-1, 0, 1]:
        for dc in [-1, 0, 1]:
            # Skip the cell itself
            if dr == 0 and dc == 0:
                continue

            # Calculate neighbor position
            nr, nc = row + dr, col + dc

            # Check bounds and if neighbor contains the symbol
            if 0 <= nr < rows and 0 <= nc < cols:
                if grid[nr][nc] == symbol:
                    adjacent_count += 1

    return adjacent_count

def remove_paper_rols(grid, rows, cols):
    removed = 0
    # Convert grid to list of lists for mutability
    grid = [list(row) for row in grid]

    for row in range(rows):
        for col in range(cols):
            if grid[row][col] == '@':
                # Count adjacent '@' symbols using the function
                adjacent_count = count_adjacent_symbols(grid, row, col, '@')
                if adjacent_count < 4:
                    removed += 1
                    grid[row][col] = "."

    # Convert back to list of strings
    grid = [''.join(row) for row in grid]
    return (grid, removed)

def main():
    if len(sys.argv) != 2:
        print("Usage: python process_file.py <filename>")
        sys.exit(1)

    filename = sys.argv[1]
    sum = 0
    grid = []

    try:
        with open(filename, 'r') as file:
            for line in file:
                grid.append(line.strip())

        # print(f"Grid loaded: {len(grid)} rows x {len(grid[0]) if grid else 0} columns")

        # Visit every cell
        rows = len(grid)
        cols = len(grid[0]) if grid else 0
        removed = 0

        # Keep removing paper rolls until no more can be removed
        rolls_removed = 1  # Initialize to enter the loop
        while rolls_removed > 0:
            (grid, rolls_removed) = remove_paper_rols(grid, rows, cols)
            removed += rolls_removed
            # print(f"Removed {rolls_removed} paper rolls in this iteration")

        print(f"Total removed paper rolls count: {removed}")

    except FileNotFoundError:
        print(f"Error: File '{filename}' not found")
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
