#!/usr/bin/env swift

func readInput() -> String {
    var lines = ""
    while let line = readLine(strippingNewline: false) {
        lines += line
    }
    return lines
}

let input = readInput()
    .split(separator: "\n")
    .map {
        $0.map { Character(String($0)) }
    }
let nrows = input.count
let ncols = input[0].count
let parsed = input.flatMap { $0 }
let index = { [ncols](_ row: Int, _ col: Int) -> Int in row*ncols + col }
var visited = [Int](repeating: 0, count: parsed.count)

func findE(from start:(Int, Int)) -> Int {
    if parsed[index(start.0, start.1)] == "E" {
        return 2
    }
}

func part1() -> Int {
    var start = (0,0)
    for row in 0..<nrows where parsed[index(row, 0)] == "S" {
        start = (row, 0)
        break
    }
    _ = findE(from: start)
    print("start from: \(start)")
    return visited.reduce(0) {
        $0 + (($1 == 2) ? 1 : 0)
    }
}
print("part1: \(part1())")

func part2() -> Int {
    return 0
}
print("part2: \(part2())")

