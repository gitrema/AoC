#!/usr/bin/env swift

func readInput() -> [String] {
    var lines: [String] = []
    while let line = readLine() {
        lines.append(line)
    }
    return lines
}

let numbers = readInput().map { Int($0)! }

func part1() -> String {
    return zip(numbers, numbers.dropFirst())
                .filter { $0 < $1 }
                .count
                .description
}

func part2() -> String {
    var part2 = 0
    for i in 0...numbers.count - 4 {
        let sumA = numbers[i] + numbers[i+1] + numbers[i+2]
        let sumB = numbers[i+1] + numbers[i+2] + numbers[i+3]
        if sumA < sumB {
            part2+=1
        }
    }
    return String(part2)
}

func part2B() -> String {
    return zip(numbers, numbers.dropFirst(3))
                .filter { $0 < $1 }
                .count
                .description
}

print(part1())
print(part2())
print(part2B())
