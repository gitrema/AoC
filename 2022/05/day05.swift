#!/usr/bin/env swift

func readInput() -> String {
    var lines = ""
    while let line = readLine(strippingNewline: false) {
        lines += line
    }
    return lines
}

let parsed = readInput()
    .split(separator: "\n\n")

func parseStacks() -> [[String]] {
    let stacks = parsed[0]
    .split(separator: "\n")

    var dict = Array(repeating: [String](), count: 10)
    stacks.forEach {
        let item = $0.map { Character(extendedGraphemeClusterLiteral: $0) }
        for i in (stride(from: 1, to: item.count, by: 4)) where item[i] != " " {
            let listNumber = (i / 4) + 1
            dict[listNumber].insert(String(item[i]), at: 0)
        }
    }
    return dict
}

let parsedStacks = parseStacks()
let parsedMoves = parsed[1]
    .split(separator: "\n")
    .map {
        let values = $0.split(separator: " ")
        return (qty: Int(values[1])!, from: Int(values[3])!, to: Int(values[5])!)
    }

func printCode(_ stacks: [[String]]) -> String {
    // var result = ""
    // for i in 1..<stacks.count {
    //     result += stacks[i].last!
    // }
    // return result

    return stacks.reduce("") {
        $0.last! + $1.last!
    }
}

func part2() -> String {
    var stacks = parsedStacks
    parsedMoves.forEach {
        let items = Array(stacks[$0.from].suffix($0.qty))
        stacks[$0.to].append(contentsOf: items)
        stacks[$0.from] = stacks[$0.from].dropLast($0.qty)
    }
    return printCode(stacks)
}
print("part2: \(part2())") // LCTQFBVZV

func part1() -> String {
    var stacks = parsedStacks
    parsedMoves.forEach {
        let items = stacks[$0.from].suffix($0.qty)
        stacks[$0.to].append(contentsOf: items.reversed())
        stacks[$0.from] = stacks[$0.from].dropLast($0.qty)
    }
    return printCode(stacks)
}
print("part1: \(part1())") // VJSFHWGFT
