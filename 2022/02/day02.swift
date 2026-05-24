#!/usr/bin/env swift

func readInput() -> String {
    var lines = ""
    while let line = readLine(strippingNewline: false) {
        lines += line
    }
    return lines
}

func parseInput() -> [(String, String)] {
    return readInput()
        .split(separator: "\n")
        .map {
            let game = $0.split(separator: " ")
            return (String(game[0]), String(game[1]))
        }
}

func choose(_ what: String) -> Int {
    switch what {
    case "X": return 1
    case "Y": return 2
    case "Z": return 3
    default: fatalError("AAAAA")
    }
}

let moves = parseInput()

func part1B() -> Int {
    return moves
    .map {
        var mymove = ""
        switch $0.1 {
        case "X": mymove = "A"
        case "Y": mymove = "B"
        case "Z": mymove = "C"
        default: fatalError("AAAAAAA")
        }
        return ($0.0, mymove)
    }.map {
// A - ROCK, B PAPER, C SCISSOR, X - ROCK, Y PAPER, Z SCISSOR
        switch $0 {
        case ("A", "A"): return 3 + 1
        case ("A", "B"): return 6 + 2
        case ("A", "C"): return 0 + 3
        case ("B", "A"): return 0 + 1
        case ("B", "B"): return 3 + 2
        case ("B", "C"): return 6 + 3
        case ("C", "A"): return 6 + 1
        case ("C", "B"): return 0 + 2
        case ("C", "C"): return 3 + 3
        default: fatalError("AAAAAA")
        }
    }.reduce(0, +)
}
print("part1B: \(part1B())")

func part2() -> Int {
    var sum = 0
    for move in moves {
        var mymove = ""
        switch move.1 {
        case "X": // lose
            switch move.0 {
            case "A": mymove = "Z"
            case "B": mymove = "X"
            case "C": mymove = "Y"
            default:
                fatalError("AAAAAA")
            }
        case "Y": // draw
            switch move.0 {
            case "A": mymove = "X"
            case "B": mymove = "Y"
            case "C": mymove = "Z"
            default:
                fatalError("AAAAAA")
            }
            sum += 3
        case "Z": // win
            switch move.0 {
            case "A": mymove = "Y"
            case "B": mymove = "Z"
            case "C": mymove = "X"
            default:
                fatalError("AAAAAA")
            }
            sum += 6
        default:
            print("\(move.1)")
            fatalError("AAAAAA")
        }
        sum += choose(mymove)
    }
    return sum
}
print("part2: \(part2())") // part2: 12316

func part1() -> Int {
    var sum = 0
    for move in moves {
        let game = move.0 + move.1
        switch game {
        case "AY", "BZ", "CX":
            sum += 6
        case "AX", "BY", "CZ":
            sum += 3
        case "AZ", "BX", "CY":
            sum += 0
        default:
            print("\(game)")
            fatalError("AAAAAAAAA")
        }
        sum += choose(move.1)
    }
    return sum
}
print("part1: \(part1())") // part1: 13809
