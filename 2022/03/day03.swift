#!/usr/bin/env swift

extension Array {
    func chunks(of size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

func readInput() -> String {
    var lines = ""
    while let line = readLine(strippingNewline: false) {
        lines += line
    }
    return lines
}

let parsed = readInput()
    .split(separator: "\n")
    .map {
        String($0)
    }

func decodeChar(_ char: Character) -> Int {
    let asciiChar = char.asciiValue!
    let asciia = Character("a").asciiValue!
    let asciiz = Character("z").asciiValue!
    let asciiA = Character("A").asciiValue!
    if asciiChar >= asciia && asciiChar <= asciiz {
        return Int((asciiChar - asciia) + 1)
    }
    return Int((asciiChar - asciiA) + 27)
}

func part2() -> Int {
    return parsed
         .chunks(of: 3)
         .map {
            let badge = Set($0[0])
                .intersection(Set($0[1]))
                .intersection(Set($0[2]))
            assert(badge.count == 1)
            return decodeChar(badge.first!)
         }
         .reduce(0, +)
}
print("part2: \(part2())") // 2415

func part1() -> Int {
    return parsed
        .map {
            (Set($0.prefix($0.count/2)), Set($0.suffix($0.count/2)))
        }
        .map {
           let val = $0.intersection($1)
           assert(val.count == 1)
           return decodeChar(val.first!)
        }
        .reduce(0, +)
}
print("part1: \(part1())") // 7766
