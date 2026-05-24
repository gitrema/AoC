#!/usr/bin/env swift

struct Valve {
    let rate: Int
    let others: [String]
}

func readInput() -> String {
    var lines = ""
    while let line = readLine(strippingNewline: false) {
        lines += line
    }
    return lines
}

func parseValve(_ str: String) -> (String, Int) {
    let token = str.split(separator: " ")
    let rate = Int(token[4].split(separator: "=")[1])!
    return (String(token[1]), rate)
}

func parseOthers(_ str: String) -> [String] {
    let index = str.index(str.startIndex, offsetBy: 24)
    return str[index...].split(separator: ".").map { String($0) }
}

var valves = [String : Valve]()
readInput()
    .split(separator: "\n")
    .forEach {
        let str = $0.split(separator: ";")
        let (valve, rate) = parseValve(String(str[0]))
        valves[valve] = Valve(rate: rate, others: parseOthers(String(str[1])))
    }

func part1() -> Int {
    var minute = 1
    info = valves["AA"] 
    if infor.rate == 0 {
        
    }
    
   if rate == 0
   return 0
}
print("part1: \(part1())")

func part2() -> Int {
    return 0
}
print("part2: \(part2())")

