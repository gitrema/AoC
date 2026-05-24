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

                first_part = line[:-1]  # All digits except the last one
                max_digit_1 = max(first_part)
                max_index_1 = first_part.index(max_digit_1)

                second_part = line[max_index_1+1:]
                max_digit_2 = max(second_part)

                sum += int(max_digit_1 + max_digit_2)

            print(sum)

    except FileNotFoundError:
        print(f"Error: File '{filename}' not found")
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
