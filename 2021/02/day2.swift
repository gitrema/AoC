#!/usr/bin/env swift

func readInput() -> [String] {
    var lines: [String] = []
    while let line = readLine() {
        lines.append(line)
    }
    return lines
}
let input = readInput()

func part1() -> String {
    var hor = 0
    var dep = 0
    input.forEach { line in
        let tuple = line.split(separator: " ")
        let (movement, value) = (tuple.first, Int(tuple.last!)!)
        switch movement {
        case "forward": hor += value
        case "up": dep -= value
        case "down": dep += value
        default:
            print("PANIC! unexpected command: \(movement ?? "<empty>")")
            fatalError()
        }
    }
    return String(hor*dep)
}

print(part1())

// hor = 0
// dep = 0
// aim = 0
// for i in 0...movements.count - 1 {
//     switch movements[i] {
//     case "forward":
//         hor += values[i]
//         dep += aim * values[i]
//     case "up": aim -= values[i]
//     case "down": aim += values[i]
//     default:
//         print("PANIC")
//         fatalError()
//     }
// }

// let part2 = hor*dep
// print("part2: \(part2)")
