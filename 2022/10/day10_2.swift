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
        if $0 == "noop" {
            return ("noop", 0)
        }
        let cmd = $0.split(separator: " ")
        return (String(cmd[0]), Int(cmd[1])!)
    }

var registerX = 1
var result = [Int]()
parsed.forEach {
    result.append(registerX)
    if $0.0 == "addx" {
        result.append(registerX)
        registerX += $0.1
    }
}

func part1() -> Int {
    var sum = 0
    for i in stride(from: 20, through: 220, by: 40) {
        sum += i*result[i - 1]
    }
    return sum
}
print("part1: \(part1())") // 14540

func part2() -> String {
    for (index, sprite) in result.enumerated() {
        let row = index % 40
        if row == 0 {
            print("")
        }
        if row >= sprite - 1 && row <= sprite + 1 {
            print("#", terminator: "")
        } else {
            print(" ", terminator: "")
        }
    }
    print("")
    return "EHZFZHCZ"
}
print("part2: \(part2())")
