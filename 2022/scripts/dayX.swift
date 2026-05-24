#!/usr/bin/env swift

func readInput() -> String {
    var lines = ""
    while let line = readLine(strippingNewline: false) {
        lines += line
    }
    return lines
}

let parsed = readInput().split(separator: "\n")
    .map {
        String($0)
    }

func part1() -> Int {
    return "not implemented yet"
}
print("part1: \(part1())")

func part2() -> Int {
    return "not implemented yet"
}
print("part2: \(part2())")

