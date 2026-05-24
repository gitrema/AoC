#!/usr/bin/env swift

func readInput() -> String {
    var lines = ""
    while let line = readLine(strippingNewline: false) {
        lines += line
    }
    return lines
}

let parsed = readInput().split(separator: "\n")
    .map {
        Array(String($0))
    }

func checkAllAdjacent(_ row: Int, _ col: Int) {
   checkSymbolAdjacent(row-1, col-1)
   checkSymbolAdjacent(row-1, col)
   checkSymbolAdjacent(row-1, col+1)
   checkSymbolAdjacent(row+1, col-1)
   checkSymbolAdjacent(row+1, col)
   checkSymbolAdjacent(row+1, col+1)
   checkSymbolAdjacent(row, col-1)
   checkSymbolAdjacent(row, col+1)
}

func checkSymbolAdjacent(_ row: Int, _ col: Int) {
    guard row > 0 && col > 0 &&
          row < parsed.count && col < parsed[0].count
          else { return }
    if !parsed[row][col].isNumber && parsed[row][col] != "." {
        symbolsFound[String(parsed[row][col])] = row*rows+col
    }
}
var gears = [Int:[Int]]()
var symbolsFound = [String: Int]()
let rows = parsed.count
let cols = parsed[0].count
func part1() -> Int {
    var numeri = [Int]()
    var num = ""
    for row in 0..<rows {
        for col in 0..<cols {
            let cell = parsed[row][col]
            if cell.isNumber {
                num += String(cell)
                checkAllAdjacent(row, col)
            } else {
                if symbolsFound.count > 0 {
                    numeri.append(Int(num)!)
                    if symbolsFound["*"] != nil {
                        gears[symbolsFound["*"]!, default: []].append(Int(num)!)
                    }
                }
                num = ""
                symbolsFound = [:]
            }
        }
    }

    return numeri.reduce(0, +)
}
print("part1: \(part1())") // 509115

func part2() -> Int {
    return gears.filter { _, values in
        values.count > 1
    }.map { _, values in
        values.reduce(1, *)
    }.reduce(0, +)
}
print("part2: \(part2())")
