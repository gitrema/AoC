#!/usr/bin/env python3

import sys

def main():
    if len(sys.argv) != 2:
        print("Usage: python process_file.py <filename>")
        sys.exit(1)

    filename = sys.argv[1]

    accumulator = 0

    try:
        with open(filename, 'r') as file:
            for line in file:
                line = line.strip()
                if not line:
                    continue

                # Parse comma-separated ranges
                ranges = line.split(',')

                for range_str in ranges:
                    # Parse each range (e.g., "23-34")
                    parts = range_str.split('-')
                    if len(parts) == 2:
                        start = int(parts[0])
                        end = int(parts[1])

                        # Check every number in the range (inclusive)
                        for num in range(start, end + 1):
                            num_str = str(num)
                            mid = len(num_str) // 2
                            first_half = num_str[:mid]
                            second_half = num_str[mid:]

                            # print(f"Checking {num}: first: {first_half}, second: {second_half}")

                            # If the halves are the same, the number is invalid
                            if first_half == second_half:
                                accumulator += num

            print(accumulator)

    except FileNotFoundError:
        print(f"Error: File '{filename}' not found")
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
