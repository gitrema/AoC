#!/usr/bin/env python3

import sys

def main():
    if len(sys.argv) != 2:
        print("Usage: python process_file.py <filename>")
        sys.exit(1)

    filename = sys.argv[1]
    sum = 0
    try:
        with open(filename, 'r') as file:
            for line in file:
                line = line.strip()
                if not line:
                    continue

                # Greedy algorithm to extract 12 digits forming the highest number
                result = ""
                current_pos = 0
                length = len(line)

                for i in range(12):
                    # Calculate search range end to ensure enough digits remain
                    end_pos = length - 12 + i + 1
                    # Find max digit in current search range
                    max_digit = max(line[current_pos:end_pos])
                    # Find index of that max digit (starting from current position)
                    max_index = line.index(max_digit, current_pos)
                    # Append to result
                    result += max_digit
                    # Move to next position after the selected digit
                    current_pos = max_index + 1

                sum += int(result)


            print(sum)

    except FileNotFoundError:
        print(f"Error: File '{filename}' not found")
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
