#!/usr/bin/env python3

import math
import sys

def parse_input(file_obj):
    """Parse comma separated triples into a list of tuples."""
    triples = []

    for line_number, raw_line in enumerate(file_obj, start=1):
        stripped = raw_line.strip()
        if not stripped:
            continue

        parts = [part.strip() for part in stripped.split(',')]
        if len(parts) != 3:
            raise ValueError(
                f"Line {line_number} should contain exactly three comma-separated numbers"
            )

        try:
            triple = tuple(int(value) for value in parts)
        except ValueError as exc:
            raise ValueError(
                f"Line {line_number} contains non-numeric data: '{raw_line.rstrip()}'"
            ) from exc

        triples.append(triple)

    return triples


def euclidean_distance(point_a, point_b):
    """
    Compute the Euclidean distance between two points in 3D space.

    Each point must be an iterable of exactly three integers representing (x, y, z).
    """
    if len(point_a) != 3 or len(point_b) != 3:
        raise ValueError("Each point must contain exactly three coordinates")

    if not all(isinstance(coord, int) for coord in (*point_a, *point_b)):
        raise TypeError("All coordinates must be integers")

    squared_diffs = [(coord_a - coord_b) ** 2 for coord_a, coord_b in zip(point_a, point_b)]
    return int(math.sqrt(sum(squared_diffs)))


def main():
    if len(sys.argv) != 2:
        print("Usage: python process_file.py <filename>")
        sys.exit(1)

    filename = sys.argv[1]

    try:
        with open(filename, 'r') as file:
            triples = parse_input(file)
        
        n = len(triples)
        distances = []
        for i in range(n):
            for j in range(i + 1, n):
                distances.append((euclidean_distance(triples[i], triples[j]), i, j))
        distances.sort(key=lambda boh: boh[0])

        circuits = []
        for distance in distances[:1000]:
            _, i, j = distance
            # print(triples[i], triples[j])

            i_circuit = None
            j_circuit = None
            for index in range(len(circuits)):
                if i in circuits[index]:
                    i_circuit = index
                if j in circuits[index]:
                    j_circuit = index
            if i_circuit is None and j_circuit is None:
                circuits.append([i, j])
            elif i_circuit is None and j_circuit is not None:
                circuits[j_circuit].append(i)
            elif j_circuit is None and i_circuit is not None:
                circuits[i_circuit].append(j)
            elif i_circuit != j_circuit:
                # merge two circuits
                circuits[i_circuit] = list(dict.fromkeys(circuits[i_circuit] + circuits[j_circuit]))
                circuits[j_circuit] = []
                
        circuits.sort(key=len, reverse=True)
        # print(circuits)

        if len(circuits) < 3:
            print("Not enough circuits to compute product of first three lengths")
        else:
            product = math.prod(len(circuit) for circuit in circuits[:3])
            print(product)

    except FileNotFoundError:
        print(f"Error: File '{filename}' not found")
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
