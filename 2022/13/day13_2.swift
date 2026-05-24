#!/usr/bin/env swift

import Foundation

func readInput() -> String {
    var lines = ""
    while let line = readLine(strippingNewline: false) {
        lines += line
    }
    return lines
}

public typealias Packet = [Any]

func parsePacket(_ packet: String) -> [Any] {
     let json = Data(packet.utf8)
     return (try! JSONSerialization.jsonObject(with: json)) as! [Any]
}

let input = readInput()
let parsed = input
    .split(separator: "\n\n")
    .map {
        let packets = $0.split(separator: "\n")
        return (parsePacket(String(packets[0])),
                parsePacket(String(packets[1])))
    }

var parsed2 = input
    .split(separator: "\n")
    .map {
        parsePacket(String($0))
    }
var keys = [Packet]()

func checkPackets(_ lhs: Packet, _ rhs: Packet) -> Bool {
    if rhs.count == 0 { return false }
    if lhs.count == 0 { return true }
    switch (lhs[0], rhs[0]) {
    case (let a, let b) as (Int, Int):
        if a > b { return false }
        if a < b { return true }
        if a == b {
            return checkPackets(Array(lhs.dropFirst()), Array(rhs.dropFirst()))
        }
    case (let a, let l) as (Int, [Any]):
        return checkPackets([a], l)
    case (let l, let b) as ([Any], Int):
        return checkPackets(l, [b])
    case (let la, let lb) as ([Any], [Any]):
        return checkPackets(la, lb)
    case(_,_):
        fatalError("Wrong types")
    }
    fatalError("MAKE THE COMPILER HAPPY")
}

func part1() -> Int {
    return parsed
        .map {
            checkPackets($0.0, $0.1)
        }
        .enumerated()
        .reduce(0) { $0 + ($1.1 ? ($1.0 + 1) : 0) }
}
print("part1: \(part1())") // part1: 5623

func part2() -> Int {
    var indexOf2 = 1
    var indexOf6 = 2
    parsed2.forEach {
        if (checkPackets($0, [[2]])) {
            indexOf2 += 1
            indexOf6 += 1
        } else if (checkPackets($0, [[6]])) {
            indexOf6 += 1
        }
    }
    return indexOf2*indexOf6
}
print("part2: \(part2())") // part2: 20570
