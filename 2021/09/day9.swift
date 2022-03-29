#!/usr/bin/env swift

func readInput() -> [[Int]] {
    var input = [[Int]]()
    while let line = readLine() {
        input.append(line.map { Int(String($0))! })
    }
    return input
}
let input = readInput()

func checkLowerPoint(_ grid: [[Int]], _ x: Int, _ y: Int) -> Bool {
    let value = grid[x][y]
    let xbound = grid.count
    let ybound = grid[0].count

    if x+1 < xbound && grid[x+1][y] <= value { return false }
    if x-1 >= 0 && grid[x-1][y] <= value { return false }
    if y+1 < ybound && grid[x][y+1] <= value { return false }
    if y-1 >= 0 && grid[x][y-1] <= value { return false }

    return true
}

func part1() -> String {
    var lowerpoints = [Int]()
    for i in 0..<input.count {
        for j in 0..<input[i].count where checkLowerPoint(input, i, j) {
            lowerpoints.append(input[i][j])
        }
    }
    var result = 0
    for lower in lowerpoints {
    result += lower+1
    }
    return result.description
}

func part2() -> String {
    var lowerpoints = [(Int, Int)]()
    for i in 0..<input.count {
        for j in 0..<input[i].count where checkLowerPoint(input, i, j) {
            lowerpoints.append((i, j))
        }
    }

    let lowerpoint = lowerpoints[0]
    //right
    var basin = [Int]()

    var basinSize = 1
    let x = lowerpoint.0
    for y in lowerpoint.1..<lowerpoints[0].count-1 {
        if input[x, y + 1] == 9 {
            break
        } else if input[x][y] - input[x][y + 1] == 1 && pointsInBasin.contains((x, y + 1)) {
            pointsInBasin.append((x, y + 1))
        } else {
            break
        }
    }
    basin.append(lowerpoint)

    return ""
}

print(part1())
print(part2())
