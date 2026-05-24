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
        $0.map { Int(String($0))! }
    }

func transpose(_ lhs: [[Int]]) -> [[Int]] {
    var trans = [[Int]](repeating: [Int](repeating: 0, count: lhs[0].count), count: lhs.count)
    for row in 0..<lhs.count {
        for col in 0..<lhs[0].count {
            trans[col][row] = lhs[row][col]
        }
    }
    return trans
}

func scenicScore(_ row: Int, _ col: Int) -> Int {
    let nrows = parsed.count
    let ncols = parsed[0].count
    let tree = parsed[row][col]
    var right = 0
    var left = 0
    var up = 0
    var down = 0
    // going right
    for i in col+1..<ncols {
        if parsed[row][i] < tree {
            right += 1
        } else {
            right += 1
            break
        }
    }
    // going left
    if col > 0 {
    for i in (0...col-1).reversed() {
        if parsed[row][i] < tree {
            left += 1
        } else {
            left += 1
            break
        }
    }
    }
    // going down
    for i in row+1..<nrows {
        if parsed[i][col] < tree {
            down += 1
        } else {
            down += 1
            break
        }
    }

    // going up
    if row > 0 {
    for i in (0...row-1).reversed() {
        if parsed[i][col] < tree {
            up += 1
        } else {
            up += 1
            break
        }
    }
    }

    return up * down * left * right
}

func part2() -> Int {
    let nrows = parsed.count
    let ncols = parsed[0].count
    var result = [Int]()
    for row in 0..<nrows {
        for col in 0..<ncols {
            result.append(scenicScore(row, col))
        }
    }
    return result.max()!
}
print("part2: \(part2())")


func findVisible(_ line: [Int]) -> [Int] {
    var result = [Int]()
    var visibileValue = line[0]
    result.append(0)
    for i in 1..<line.count where line[i] > visibileValue {
        visibileValue = line[i]
        result.append(i)
    }
    return result
}

func part1() -> Int {
    // (row, col) = (row * ncols) + col
    let nrows = parsed.count
    let ncols = parsed[0].count
    var visibleTrees = [Bool](repeating: false, count: nrows*ncols)
    assert(nrows==ncols)
    let index = { (_ row: Int, _ col: Int) -> Int in row*ncols + col }

    var visibles = [Int]()
    for row in 0..<nrows {
        visibles = findVisible(parsed[row])
        visibles.forEach {
            visibleTrees[index(row, $0)] = true
        }
        visibles = findVisible(parsed[row].reversed())
        visibles.forEach {
            visibleTrees[index(row, ncols - $0 - 1)] = true
        }
    }
    let parsedTranspose = transpose(parsed)
    for row in 0..<nrows {
        // print("\(parsed[row])")
        visibles = findVisible(parsedTranspose[row])
        visibles.forEach {
            visibleTrees[index($0, row)] = true
        }
        visibles = findVisible(parsedTranspose[row].reversed())
        visibles.forEach {
            visibleTrees[index(nrows - $0 - 1, row)] = true
        }
    }
    return visibleTrees.reduce(0) { $0 + ($1 ? 1 : 0) }
}


print("part1: \(part1())")
