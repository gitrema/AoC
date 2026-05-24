#!/usr/bin/env swift

func readInput() -> [UInt64] {
    var input = [String]()
    while let line = readLine() {
        input.append(line)
    }
    return input[0].split(separator: ",").map { UInt64(String($0))! }
}
let input = readInput()

func part1() -> String {
    var lanterns = input
    for day in 0..<80 {
        print("\(day)")
        var lanternsToAdd = 0
        for index in 0...lanterns.count - 1 {
            if lanterns[index] == 0 {
                lanterns[index] = 6
                lanternsToAdd += 1
            } else {
                lanterns[index] -= 1
            }
        }
        if lanternsToAdd > 0 {
            lanterns.append(contentsOf: Array(repeating: 8, count: lanternsToAdd))
        }
    }
    return lanterns.count.description
}

func part2() -> String {
    let lanterns = input
    return ""
}

print(part1())
print(part2())

// corretto: 26984457539
// test:      4437053125
