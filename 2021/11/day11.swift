#!/usr/bin/env swift

func readInput() -> [[Int]] {
    var input = [[Int]]()
    while let line = readLine() {
        input.append(line.map { Int(String($0))! })
    }
    return input
}
let input = readInput()

func flash(_ grid: inout [[Int]], _ x: Int, _ y: Int) -> Int {
    let xbound = grid.count
    let ybound = grid[0].count
    var valid = [(Int, Int)]()
    var flashes = 0

    if x+1 < xbound { valid.append((x+1, y)) }
    if x-1 >= 0 { valid.append((x-1, y)) }
    if y+1 < ybound { valid.append((x, y+1)) }
    if y-1 >= 0 { valid.append((x, y-1)) }
    if x-1 >= 0 && y+1 < ybound { valid.append((x-1, y+1)) }
    if x+1 < xbound && y+1 < ybound { valid.append((x+1, y+1)) }
    if x-1 >= 0 && y-1 >= 0 { valid.append((x-1, y-1)) }
    if y-1 >= 0 && x+1 < xbound { valid.append((x+1, y-1)) }

    valid.forEach {
        grid[$0.0][$0.1] += 1
        if grid[$0.0][$0.1] == 10 {
            flashes += flash(&grid, $0.0, $0.1) + 1
        }
    }
    return flashes
}

func part1() -> String {
    var flashes = 0
    var octopuses = input
    for _ in 1...100 {
        for i in 0..<octopuses.count {
            for j in 0..<octopuses[i].count {
                octopuses[i][j] += 1
                if octopuses[i][j] == 10 {
                    flashes += flash(&octopuses, i, j) + 1
                }
            }

        }
        for i in 0..<octopuses.count {
            for j in 0..<octopuses[i].count where octopuses[i][j] > 9 {
                octopuses[i][j] = 0
            }
        }
    }
    return "\(flashes)"
}

func part2() -> String {
    var octopuses = input
    var step = 0
    var flashes = 0
    repeat {
        flashes = 0
        step += 1
        for i in 0..<octopuses.count {
            for j in 0..<octopuses[i].count {
                octopuses[i][j] += 1
                if octopuses[i][j] == 10 {
                    flashes += flash(&octopuses, i, j) + 1
                }
            }

        }
        for i in 0..<octopuses.count {
            for j in 0..<octopuses[i].count where octopuses[i][j] > 9 {
                octopuses[i][j] = 0
            }
        }
    } while(flashes != octopuses.count*octopuses[0].count)
    return "\(step.description)" // 327 risposta corretta
}

print(part1())
print(part2())
