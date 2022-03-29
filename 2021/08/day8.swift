#!/usr/bin/env swift

func readInput() -> [String] {
    var input = [String]()
    while let line = readLine() {
        input.append(line)
    }
    return input
}
let input = readInput()

func part1() -> String {
    let right = input.map { $0.split(separator: "|").map { String($0) } }
    let digits = right.map { $0[1].split(separator: " ").map { String($0) } }
    var count = 0
    digits.forEach { segment in
        segment.forEach {
            switch $0.count {
            case 2: // one
                count += 1
            case 3: // seven
                count += 1
            case 4: // two
                count += 1
            case 7: // eight
                count += 1
            default:
                count += 0
            }
        }
    }
    return count.description
}

func xxx(_ seq: inout [String], _ len: Int) -> String {
    for i in 0..<seq.count where (seq[i].count == len) {
        let removed =  seq.remove(at: i)
        return removed
    }
    fatalError()
}

func segmentContained(_ lhs: String, _ rhs: String) -> Bool {
    for rhsChar in rhs where !lhs.contains(rhsChar) {
        return false
    }
    return true
}
func segmentContainedExact(_ lhs: String, _ rhs: String) -> Bool {
    if lhs.count != rhs.count { return false }
    for rhsChar in rhs where !lhs.contains(rhsChar) {
        return false
    }
    return true
}

func power10(_ exp: Int) -> Int {
    let powers = [1, 10, 100, 1000]
    return powers[exp]
}

func sumSegment(_ lhs: String, _ rhs: String) -> String {
    var result = lhs
    for char in rhs {
        if !lhs.contains(char) {
            result.append(char)
        }
    }
    return result
}

func decodeSignal(_ sig: [String]) -> [String] {
        var signal = sig
        var decoded = Array.init(repeating: "", count: 10)
        decoded[1] = xxx(&signal, 2)
        decoded[4] = xxx(&signal, 4)
        decoded[7] = xxx(&signal, 3)
        decoded[8] = xxx(&signal, 7)

        for _ in 1...3 {
            let guess: String = xxx(&signal, 6)
            if segmentContained(guess, decoded[4]) {
               decoded[9] = guess
            } else if segmentContained(guess, decoded[1]) {
               decoded[0] = guess
            } else {
               decoded[6] = guess
            }
        }

        for _ in 1...3 {
           let guess: String = xxx(&signal, 5)
           if segmentContained(guess, decoded[1]) {
               decoded[3] = guess
           } else if sumSegment(guess, decoded[4]).count == 7 {// combinato al 4 da 8 allora e' il 2
               decoded[2] = guess
           } else {
               decoded[5] = guess
           }
        }

        return decoded
}

func decodeNumber(_ decodedSignal: [String], _ digits: [String]) -> Int {
        var value = 0
    for i in 0..<digits.count {
         for j in 0...9 {
            if segmentContainedExact(digits[i], decodedSignal[j]) {
                value += j * power10(3-i)
            }
        }
    }
    return value
}

func part2() -> String {
    let right = input.map { $0.split(separator: "|").map { String($0) } }
    let signals = right.map { $0[0].split(separator: " ").map { String($0) } }
    let digits = right.map { $0[1].split(separator: " ").map { String($0) } }

    let total = zip(signals, digits).map {
        let decoded = decodeSignal($0)
        let number = decodeNumber(decoded, $1)
        // print("\($0) -> \($1): \(number)")
        print("\(decoded) -> \($1): \(number)")
        return number
    }.reduce(0, { x, y in
        x + y
    })

    return total.description
}

print(part1())
print(part2())
