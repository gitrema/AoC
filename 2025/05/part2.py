#!/usr/bin/env python3

import sys

def main():
    if len(sys.argv) != 2:
        print("Usage: python process_file.py <filename>")
        sys.exit(1)

    filename = sys.argv[1]

    try:
        with open(filename, 'r') as file:
            content = file.read().strip()

            # Split by empty line to get two blocks
            blocks = content.split('\n\n')
            if len(blocks) != 2:
                print(f"Error: Expected 2 blocks separated by empty line, got {len(blocks)}")
                sys.exit(1)

            # Parse ranges from first block
            ranges = []
            for line in blocks[0].split('\n'):
                if '-' in line:
                    start, end = line.split('-')
                    ranges.append((int(start), int(end)))

            # Sort ranges by start value in ascending order
            ranges.sort(key=lambda r: r[0])

            # Merge overlapping ranges
            non_overlapping_ranges = []
            if ranges:
                current_range = list(ranges[0])  # Use list to make it mutable

                for i in range(1, len(ranges)):
                    next_range = ranges[i]

                    # Check if next_range overlaps with current_range
                    if next_range[0] <= current_range[1] + 1:
                        # Merge: extend current_range to include next_range
                        current_range[1] = max(current_range[1], next_range[1])
                    else:
                        # No overlap: add current_range to list and start new one
                        non_overlapping_ranges.append(tuple(current_range))
                        current_range = list(next_range)

                # Don't forget to add the last current_range
                non_overlapping_ranges.append(tuple(current_range))

            # Compute how many items each range contains
            count = 0
            for start, end in non_overlapping_ranges:
                count += end - start + 1
            print(f"{count} items")

    except FileNotFoundError:
        print(f"Error: File '{filename}' not found")
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
