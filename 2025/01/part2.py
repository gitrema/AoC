#!/usr/bin/env python3

import sys

def main():
    if len(sys.argv) != 2:
        print("Usage: python process_file.py <filename>")
        sys.exit(1)

    filename = sys.argv[1]

    counter = 50
    zeros = 0

    try:
        with open(filename, 'r') as file:
            for line in file:
                line = line.strip()
                if not line:
                    continue

                operation = line[0]
                number = int(line[1:])

                zeros += number//100
                rot = number % 100
                if operation == 'L':
                    if counter != 0 and counter < rot:
                        zeros += 1
                    counter = (counter - rot) % 100
                elif operation == 'R':
                    if counter + rot > 100:
                        zeros += 1
                    counter = (counter + rot) % 100

                if counter == 0:
                    zeros += 1

        print(f"Number of times counter reached zero: {zeros}")
    except FileNotFoundError:
        print(f"Error: File '{filename}' not found")
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
