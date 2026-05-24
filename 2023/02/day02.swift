#!/usr/bin/env swift

// https://adventofcode.com/2023/day/2

func readInput() -> String {
    var lines = ""
    while let line = readLine(strippingNewline: false) {
        lines += line
    }
    return lines
}

let parsed = readInput().split(separator: "\n")
    .map {
        let game = $0.split(separator: ":")
        let gameNumber = Int(String(game[0].dropFirst(5)))!
        let cubes = game[1].split(separator: ";").map {
            $0.split(separator: ",").map {
                let cubeSplit = $0.split(separator: " ")
                return (number: Int(String(cubeSplit[0]))!, color: String(cubeSplit[1]))
            }
        }.reduce(into: [String : Int]()) {
            for cube in $1 where $0[cube.color, default: 0] < cube.number {
                $0[cube.color] = cube.number
            }
        }
        return (gameNumber: gameNumber, cubes: cubes)
    }

func part1() -> Int {
    parsed.filter {
            // 12 red cubes, 13 green cubes, and 14 blue cube
            !($0.cubes["red"]! > 12 || $0.cubes["green"]! > 13 || $0.cubes["blue"]! > 14)
       }.reduce(0) {
            $0 + $1.gameNumber
       }
}
print("part1: \(part1())") // 2101

func part2() -> Int {
    parsed.map {
        $0.cubes["red"]! * $0.cubes["green"]! * $0.cubes["blue"]!
    }.reduce(0, +)
}
print("part2: \(part2())") // 58269
