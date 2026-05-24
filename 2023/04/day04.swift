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
    return parsed.map {
        let line = $0.split(separator: ":")
        let cards = line[1].split(separator: "|")
        let winners = cards[0].split(separator: " ").map { Int(String($0))! }
        let numbers = cards[1].split(separator: " ").map { Int(String($0))! }

        return numbers.filter {
            winners.contains($0)
        } .reduce(into: 0) { counts, _ in
            counts = counts == 0 ? 1 : counts * 2
        }
    }.reduce(0, +)
}
print("part1: \(part1())") // 17803 - test value: 13 points

func part2() -> Int {
    return -1
}
print("part2: \(part2())")
