#!/usr/bin/env swift

func readInput() -> String {
    var lines = ""
    while let line = readLine(strippingNewline: false) {
        lines += line
    }
    return lines
}

let parsed = readInput()
     .map {
        Character(String($0))
     }

func findMarker(_ len: Int) -> Int {
    for index in 0..<parsed.count where
        Set(parsed[index..<index+len]).count == len {
            return index+len
    }
    return -1
}

func part2() -> Int {
    return findMarker(14)
}
print("part2: \(part2())") // 2851

func part1() -> Int {
    return findMarker(4)
}
print("part1: \(part1())") // 1794
