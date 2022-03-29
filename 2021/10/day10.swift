#!/usr/bin/env swift

func readInput() -> [String] {
    var input = [String]()
    while let line = readLine() {
        input.append(line)
    }
    return input
}
let input = readInput()

let illegalPoint = [")": 3, "]": 57, "}": 1197, ">": 25137]
let illegalIncompletePoint = ["(": 1, "[": 2, "{": 3, "<": 4]

func checkSyntax(_ line: String) -> Character? {
    var stack = [Character]()
    for chunk in line {
        if chunk == "(" || chunk == "[" || chunk == "{" || chunk == "<" {
            stack.append(chunk)
        } else {
            guard let param = stack.popLast() else { return chunk }
            if param == "(" && chunk != ")" {
                return chunk
            } else if param == "[" && chunk != "]" {
                return chunk
            } else if param == "{" && chunk != "}" {
                return chunk
            } else if param == "<" && chunk != ">" {
                return chunk
            }
        }
    }
    // so far incomplete line are ok.
    return nil
}

func incompleteLines(_ line: String) -> [Character] {
    var stack = [Character]()
    for chunk in line {
        if chunk == "(" || chunk == "[" || chunk == "{" || chunk == "<" {
            stack.append(chunk)
        } else {
            guard let param = stack.popLast() else { return [Character]() }
            if param == "(" && chunk != ")" {
                return [Character]()
            } else if param == "[" && chunk != "]" {
                return [Character]()
            } else if param == "{" && chunk != "}" {
                return [Character]()
            } else if param == "<" && chunk != ">" {
                return [Character]()
            }
        }
    }
    return stack

}

func part1() -> String {
    var points = 0
    input.forEach {
        if let illegal = checkSyntax($0) {
            points += illegalPoint[String(illegal)]!
        }
    }
    return points.description
}
func part2() -> String {
    let points = input.map {
        incompleteLines($0)
    }.filter {
        $0.count != 0
    }.map {
        $0.reversed().reduce(0) { $0*5 + illegalIncompletePoint[String($1)]! }
    }
    .sorted()
    //
    // It is guaranteed to be always a odd number of elements
    //
    return points[points.count/2].description
}

print(part1())
print(part2())
