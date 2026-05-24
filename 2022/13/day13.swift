#!/usr/bin/env swift

import Foundation

func readInput() -> String {
    var lines = ""
    while let line = readLine(strippingNewline: false) {
        lines += line
    }
    return lines
}

public indirect enum PacketData: Equatable {
    case number(Int)
    case list([PacketData])
}
public typealias Packet = [PacketData]

func parsePacket(_ packet: String) -> [Any] {
     let json = Data(packet.utf8)
     return (try! JSONSerialization.jsonObject(with: json)) as! [Any]
}

func anyToPacketData(_ packetAny: [Any]) -> Packet {
    guard packetAny.count > 0 else { return [] }
    return packetAny
        .map {
            switch $0 {
            case let num as Int:
                return PacketData.number(num)
            case let list as [Any]:
                return PacketData.list(anyToPacketData(list))
            default:
                fatalError("AAAAAA")
            }
        }
}

let input = readInput()
let parsed = input
    .split(separator: "\n\n")
    .map {
        let packets = $0.split(separator: "\n")
        return (anyToPacketData(parsePacket(String(packets[0]))),
                anyToPacketData(parsePacket(String(packets[1]))))
    }

var parsed2 = input
    .split(separator: "\n")
    .map {
        anyToPacketData(parsePacket(String($0)))
    }
var keys = [Packet]()
// keys.append([PacketData.list([.number(2)])]) DOES NOT WORK AND I DON'T KNOW WHY
// keys.append([PacketData.list([.number(6)])])
keys.append([PacketData.list([.number(2)])])
keys.append([PacketData.list([.number(6)])])
parsed2.insert(keys[0], at: 0)
parsed2.insert(keys[1], at: 1)

func checkPackets(_ lhs: Packet, _ rhs: Packet) -> Bool {
    if rhs.count == 0 { return false }
    if lhs.count == 0 { return true }
    switch (lhs[0], rhs[0]) {
    case (.number(let a), .number(let b)):
        if a > b { return false }
        if a < b { return true }
        if a == b {
            return checkPackets(Array(lhs.dropFirst()), Array(rhs.dropFirst()))
        }
    case (.number(let a), .list(let l)):
        return checkPackets([.number(a)], l)
    case (.list(let l), .number(let b)):
        return checkPackets(l, [.number(b)])
    case (.list(let la), .list(let lb)):
        return checkPackets(la, lb)
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

extension Packet: Comparable {
    public static func < (lhs: Packet, rhs: Packet) -> Bool {
        return checkPackets(lhs, rhs)
    }
}

func part2() -> Int {
    return parsed2
        .sorted()
        .enumerated()
        .reduce(1) {
            if $1.1 == keys[0] {
                return $0 * ($1.0 + 1)
            }
            if $1.1 == keys[1] {
                return $0 * ($1.0 + 1)
            }
            return $0
        }
}
print("part2: \(part2())") // part2: 20570
