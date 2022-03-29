#!/usr/bin/env swift

func readInput() -> [String: [String]] {
    var input: [String: [String]] = [:]
    while let line = readLine() {
        let edge = line.split(separator: "-").map { String($0) }
        input[edge[0], default: [String]()].append(edge[1])
        input[edge[1], default: [String]()].append(edge[0])
    }
    return input
}
let input = readInput()

func isBigCave(_ cave: String) -> Bool {
    return cave == cave.uppercased()
}

func traverse(_ node: String, _ visited: inout Set<String>) -> [[String]]? {
    guard node != "end" else { return [["end"]] }
    guard isBigCave(node) || !visited.contains(node) else { return nil }

    visited.insert(node)
    var paths = [[String]]()
    input[node]?.forEach {
         var xxx = visited
         if let path = traverse($0, &xxx) {
            paths.append(contentsOf: path)
         }
    }
    return paths.map {
        var pippo = $0
        pippo.append(node)
        return pippo
    }
}

func traverse2(_ node: String, _ visited: inout Set<String>, _ small: inout Bool) -> [[String]]? {
    guard node != "end" else { return [["end"]] }

    if !isBigCave(node) && visited.contains(node) {
        if node == "start" || small {
            return nil
        }
        small = true
    }

    visited.insert(node)
    var paths = [[String]]()
    input[node]?.forEach {
         var xxx = visited
         var yyy = small
         if let path = traverse2($0, &xxx, &yyy) {
            paths.append(contentsOf: path)
         }
    }
    return paths.map {
        var pippo = $0
        pippo.append(node)
        return pippo
    }
}
func part1() -> String {
    var visited: Set<String> = []
    let paths = traverse("start", &visited)!

    return "\(paths.count)"
}

func part2() -> String {
    var visited: Set<String> = []
    var small = false
    let paths = traverse2("start", &visited, &small)!

    return "\(paths.count)"
}

print(part1())
print(part2())
