#!/usr/bin/env swift

func readInput() -> String {
    var lines = ""
    while let line = readLine(strippingNewline: false) {
        lines += line
    }
    return lines
}

let elves = readInput()
    .split(separator: "\n\n")
    .map {
        $0.split(separator: "\n")
            .map { Int($0)! }
            .reduce(0, +)
    }

func part2() -> Int {
    let sum = elves.sorted()
        .suffix(3)
        .reduce(0, { $0 + $1 })
    return sum // 207410
}
print("part2: \(part2())")

func part1() -> Int {
     return elves.max()! // 72602
}
print("part1: \(part1())")
