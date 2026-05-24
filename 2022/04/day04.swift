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

let parsed = readInput().split(separator: "\n")
    .map {
        let pairs = String($0).split(separator: ",")
        let sectorA = pairs[0].split(separator: "-")
        let sectorB = pairs[1].split(separator: "-")
        return (Int(sectorA[0])!...Int(sectorA[1])!, Int(sectorB[0])!...Int(sectorB[1])!)
    }

func part2() -> Int {
    return parsed
        .map { (sectorA: ClosedRange<Int>, sectorB: ClosedRange<Int>) in
            return sectorA.overlaps(sectorB) ? 1 : 0
        }
        .reduce(0, +)
}
print("part2: \(part2())") // 854

func part1() -> Int {
    return parsed
        .map { (sectorA: ClosedRange<Int>, sectorB: ClosedRange<Int>) in
            let sizeA = (sectorA.upperBound - sectorA.lowerBound)
            let sizeB = (sectorB.upperBound - sectorB.lowerBound)
            if sizeA < sizeB {
                return sectorA.clamped(to: sectorB) == sectorA ? 1 : 0
            } else {
                return sectorB.clamped(to: sectorA) == sectorB ? 1 : 0
            }
        }
        .reduce(0, +)
}
print("part1: \(part1())") // 532
