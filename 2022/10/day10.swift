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

func part2() -> String {
    var sprite = 0
    var fetchCycle = 0
    var temp = 0
    var ipointer = 0
    var writeCycle = 0
    for vert in 0..<6 {
        for horiz in 0..<40 {
            let cycle = 40*vert + horiz
            if cycle == writeCycle {
                sprite += temp
            }
            if cycle == fetchCycle {
                if parsed[ipointer].0 == "noop" {
                    temp = 0
                    fetchCycle += 1
                } else if parsed[ipointer].0 == "addx" {
                    temp = parsed[ipointer].1
                    fetchCycle += 2
                    writeCycle = cycle + 2
                }
                ipointer += 1
            }
            if horiz >= sprite && horiz < sprite + 3 {
                print("#", terminator: "")
            } else {
                print(" ", terminator: "")
            }
        }
        print("")
    }
    return "EHZFZHCZ"
}
print("part2: \(part2())")

func part1() -> Int {
    var registerX = 1
    var cycle = 0
    var cycleStep = 20
    var sum = 0

    parsed.forEach {
        if $0.0 == "noop" {
            cycle += 1
            if cycle + 1 >= cycleStep {
                sum += registerX * cycleStep
                cycleStep += 40
            }
        }
        if $0.0 == "addx" {
            cycle += 1
            if cycle + 1 >= cycleStep {
                sum += registerX * cycleStep
                cycleStep += 40
            }
            registerX += $0.1
            cycle += 1
            if cycle + 1 >= cycleStep {
                sum += registerX * cycleStep
                cycleStep += 40
            }
        }
    }
    return sum
}
print("part1: \(part1())") // 14540
