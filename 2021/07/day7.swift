#!/usr/bin/env swift

func readInput() -> [Int] {
    var input = [String]()
    while let line = readLine() {
        input.append(line)
    }
    return input[0].split(separator: ",").map { Int(String($0))! }
}
let input = readInput()

func part1() -> String {
    var minfuel = -1
    let maxpos = input.max()!
    for pos in 0...maxpos {
        var fuel = 0
        for crab in 0..<input.count {
            fuel += abs(pos - input[crab])
        }
        if minfuel < 0 || minfuel > fuel {
            minfuel = fuel
        }
    }
    return "\(minfuel)"
}

func part2() -> String {
    var minfuel = -1
    let maxpos = input.max()!
    for pos in 0...maxpos {
        var fuel = 0
        for crab in 0..<input.count {
            let unarycost = abs(input[crab] - pos)
            fuel += (unarycost * (unarycost + 1)) / 2
        }
        if minfuel < 0 || minfuel > fuel {
            minfuel = fuel
        }
    }
    return "\(minfuel)"
}

print(part1())
print(part2())
