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
                    ranges.append((start, end))

            # Parse numbers from second block
            numbers = []
            for line in blocks[1].split('\n'):
                if line.strip():
                    numbers.append(line.strip())

            # Check each number against all ranges
            def is_in_range(number, start, end):
                """Check if number is in range [start, end] using lexicographical comparison
                only when all strings have the same length."""
                # Only compare if all have the same length
                if len(number) == len(start) == len(end):
                    return start <= number <= end
                return False

            # Process each number
            matches = []
            for number in numbers:
                found = False
                for start, end in ranges:
                    if is_in_range(number, start, end):
                        matches.append((number, start, end))
                        found = True
                        break  # Found a match, no need to check other ranges

                # if not found:
                #     print(f"Number {number} is NOT in any range")

            print(f"\n\nFound {len(matches)} numbers in ranges")

    except FileNotFoundError:
        print(f"Error: File '{filename}' not found")
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
