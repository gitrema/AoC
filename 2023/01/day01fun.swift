#!/usr/bin/env swift

// https://adventofcode.com/2023/day/1

func readInput() -> String {
    var lines = ""
    while let line = readLine(strippingNewline: false) {
        lines += line
    }
    return lines
}

let parsed = readInput().split(separator: "\n")
    .map {
        String($0)
    }

let digits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
func part1() -> Int {
    return parsed.map {
        let digitsFound = $0.filter {
            digits.contains(String($0))
        }.map {
            Int(String($0))!
        }
        return (10 * digitsFound.first! + digitsFound.last!)
    }.reduce(0, +)
}
print("part1: \(part1())") // 54331

func part2() -> Int {
    let letters = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    return parsed.map {
        var firstDigit = -1
        var lastDigit = -1
        var line = $0

        while !line.isEmpty {
            let car = String(line.first!)
            if digits.contains(car) {
                firstDigit = firstDigit == -1 ? Int(car)! : firstDigit
                lastDigit = Int(String(car))!
            } else {
            var digitFound = 0
            for number in letters {
                if line.hasPrefix(number) {
                    firstDigit = firstDigit == -1 ? digitFound : firstDigit
                    lastDigit = digitFound
                    break
                }
                digitFound += 1
            }
           }
           line = String(line.dropFirst())
        }

        return (firstDigit * 10 + lastDigit)
    }.reduce(0, +)
}
print("part2: \(part2())") // 54518
