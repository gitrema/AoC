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
        grid = [list(line) for line in content.split('\n')]

        # Find the index of 'S' in the first line
        s_index = grid[0].index('S')
        # print(f"Index of 'S' in first line: {s_index}")
        # # print(f"result: {grid}")
        beams = [s_index]
        split_count = 0

        for line_index in range(1, len(grid)):
            new_beams = []

            for beam in beams:
                # Check if beam is outside the grid horizontally
                if beam < 0 or beam >= len(grid[line_index]):
                    continue  # Beam disappears

                cell = grid[line_index][beam]

                if cell == '^':
                    # Split into two beams
                    split_count += 1
                    new_beams.append(beam - 1)
                    new_beams.append(beam + 1)
                elif cell == '.':
                    # Continue straight down
                    new_beams.append(beam)
                else:
                    # For any other character, continue moving
                    new_beams.append(beam)

            beams = list(set(new_beams))

            # If no beams left, stop processing
            if not beams:
                break

        print(f"Split count: {split_count}")

    except FileNotFoundError:
        print(f"Error: File '{filename}' not found")
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
