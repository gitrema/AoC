#!/usr/bin/env swift

import Foundation

func readInput() -> String {
    var lines = ""
    while let line = readLine(strippingNewline: false) {
        lines += line
    }
    return lines
}

struct Monkey {
    var items = [Int]()
    let operation: ((Int) -> Int)
    let test: Int
    var lancia = [Int]()
}

// let parsed = readInput()

var parsed = [Monkey]()
parsed.append(
    Monkey(items: [84, 66, 62, 69, 88, 91, 91], operation: { $0*11 }, test: 2, lancia: [4, 7])
)
parsed.append(
    Monkey(items: [98, 50, 76, 99], operation: { $0*$0 }, test: 7, lancia: [3, 6])
)

parsed.append(
    Monkey(items: [72, 56, 94], operation: { $0 + 1 }, test: 13, lancia: [4, 0])
)

parsed.append(
    Monkey(items: [55, 88, 90, 77, 60, 67], operation: { $0 + 2 }, test: 3, lancia: [6, 5])
)

parsed.append(
    Monkey(items: [69, 72, 63, 60, 72, 52, 63, 78], operation: { $0*13 }, test: 19, lancia: [1, 7])
)

parsed.append(
    Monkey(items: [89, 73], operation: { $0 + 5 }, test: 17, lancia: [2, 0])
)

parsed.append(
    Monkey(items: [78, 68, 98, 88, 66], operation: { $0 + 6 }, test: 11, lancia: [2, 5])
)

parsed.append(
    Monkey(items: [70], operation: { $0 + 7 }, test: 5, lancia: [1, 3])
)

var mod = 1
for monkey in parsed {
    mod *= monkey.test
}

func numberOfInspects(afterRound round: Int, worryLevelDivider divider: Int) -> Int {
    var inspects = Array(repeating: 0, count: parsed.count)
    for _ in 0..<round {
        for index in 0..<parsed.count {
            inspects[index] += parsed[index].items.count
            while parsed[index].items.count != 0 {
                var item = parsed[index].items.removeFirst()
                item = parsed[index].operation(item)/divider
                item %= mod
                if item % parsed[index].test == 0 {
                    parsed[parsed[index].lancia[0]].items.append(item)
                } else {
                    parsed[parsed[index].lancia[1]].items.append(item)
                }
            }
        }
    }
    return inspects.sorted().suffix(2).reduce(1, *)
}

func part1() -> Int {
    return numberOfInspects(afterRound: 20, worryLevelDivider: 3)
}
print("part1: \(part1())") // part 1: 99840

func part2() -> Int {
    return numberOfInspects(afterRound: 10000, worryLevelDivider: 1)
}
print("part2: \(part2())") // part 2: 20666393573
