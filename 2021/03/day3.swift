#!/usr/bin/env swift

func readInput() -> [String] {
    var lines: [String] = []
    while let line = readLine() {
        lines.append(line)
    }
    return lines
}
let input = readInput()

func part1() -> String {
   let power2 = [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096]
    var bit = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    input.forEach { line in
    for i in 0...11 {
        switch line[line.index(line.startIndex, offsetBy: i)] {
        case "1": bit[i]+=1
        case "0": bit[i]-=1
        default:
            print("PANIC! wrong digit")
            fatalError()
        }
    }
    }

   var gamma = 0
   var epsilon = 0
   for i in 0...11 {
       if (bit[11 - i] > 0) {
           gamma += power2[i]
       } else {
           epsilon += power2[i]
       }
   }
   return String(gamma*epsilon)
}

func convertBinaryString(_ binary: String) -> Int {
    var value = 0
    binary.forEach { char in
        value *= 2
        if char == "1" { value += 1 }
    }
    return value
}

func mostCommonBit(_ seq: [String], _ pos: Int) -> Int {
    var bit = 0
    seq.forEach { line in
        switch line[line.index(line.startIndex, offsetBy: pos)] {
        case "1": bit+=1
        case "0": bit-=1
        default:
            print("PANIC! wrong digit")
            fatalError()
        }
    }
    return bit
}

func computeValue(_ values: [String], _ pos: Int, bitCriteria: (String, Int) -> Bool ) -> String {
    if values.count == 1 {
        return values[0]
    }
    let bit = mostCommonBit(values, pos)
    let keep = values.filter {
        bitCriteria(String($0[$0.index($0.startIndex, offsetBy: pos)]), bit)
    }
    return computeValue(keep, pos + 1, bitCriteria: bitCriteria)
}

func part2() -> String {
    let o2 = computeValue(input, 0) { char, bit in
        (bit >= 0 && char == "1") || (bit < 0 && char == "0")
    }
    let co2 = computeValue(input, 0) { char, bit in
        (bit >= 0 && char == "0") || (bit < 0 && char == "1")
    }
    return String(convertBinaryString(o2) * convertBinaryString(co2))
}

print(part1())
print(part2())
