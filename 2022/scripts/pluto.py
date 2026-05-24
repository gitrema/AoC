#!/usr/bin/env python3

swift_file = """#!/usr/bin/env swift

func readInput() -> [String] {
    var lines: [String] = []
    while let line = readLine() {
        lines.append(line)
    }
    return lines
}

func part1() -> String {
    return "hello"
}

func part2() -> String {
    return "world"
}

print("part1: \(part1())")
print("part2: \(part2())")
"""

textfile = open("dayX.swift", "w")
textfile.write(swift_file)
textfile.close()
