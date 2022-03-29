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

func powerof2(_ exp: UInt64) -> UInt64 {
    var value: UInt64 = 1

    for _ in 1...exp {
        value *= 2
    }
    return value
}

func progenia(_ state: UInt64, days: UInt64) -> UInt64 {
    let nextsplit = days - state - 1

    if (nextsplit < 0) { return 0 }
    //
    let sons = nextsplit/6
    var value: UInt64 = 1
    for _ in 0..<sons {
        value += progenia(6, days: nextsplit-2)
    }
    return value
}

func part2() -> String {
    let lanterns = input

}

print(part1())
print(part2())

// corretto: 26984457539
// rest:      4437053125
