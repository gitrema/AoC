#!/usr/bin/env swift

func readInput() -> [[Bool]] {
    var maxX = -1
    var maxY = -1
    var coords = [(Int, Int)]()
    while let line = readLine() {
        if line.isEmpty {
            break
        }
        let coord = line.split(separator: ",").map { Int(String($0))! }
        if maxX < coord[0] { maxX = coord[0]}
        if maxY < coord[1] { maxY = coord[1]}
        coords.append((coord[0], coord[1]))
    }
    // parse folded instructions
    var input = [[Bool]](repeating: Array(repeating: false, count: maxY + 1), count: maxX + 1)
    coords.forEach {
        input[$0.0][$0.1] = true
    }

    return input
}
let input = readInput()

func foldAlongY(_ unfolded: [[Bool]], yfold: Int) -> [[Bool]] {
    var folded = [[Bool]](repeating: Array(repeating: false, count: yfold), count: unfolded.count)
    for y in yfold..<unfolded[0].count - 1 {
        for x in 0..<unfolded.count {
            let dist = (y - yfold)
            folded[x][yfold-dist-1] = unfolded[x][yfold-dist-1] || unfolded[x][yfold+dist+1]
        }
    }
    return folded
}

func foldAlongX(_ unfolded: [[Bool]], xfold: Int) -> [[Bool]] {
    var folded = [[Bool]](repeating: Array(repeating: false, count: unfolded[0].count), count: xfold)
    for x in xfold..<unfolded.count - 1 {
        for y in 0..<unfolded[0].count {
            let dist = (x - xfold)
            folded[xfold-dist-1][y] = unfolded[xfold-dist-1][y] || unfolded[xfold+dist+1][y]
        }
    }
    return folded
}

func part1() -> String {
    let folded = foldAlongX(input, xfold: 655)
    var count = 0
    for x in 0..<folded.count {
        for y in 0..<folded[0].count where folded[x][y] {
            count += 1
        }
    }
    return "\(count.description)"
}

func part2() -> String {

// TODO: Lame, questo va letto dal file
var folded = foldAlongX(input, xfold: 655)
folded = foldAlongY(folded, yfold: 447)
folded = foldAlongX(folded, xfold: 327)
folded = foldAlongY(folded, yfold: 223)
folded = foldAlongX(folded, xfold: 163)
folded = foldAlongY(folded, yfold: 111)
folded = foldAlongX(folded, xfold: 81)
folded = foldAlongY(folded, yfold: 55)
folded = foldAlongX(folded, xfold: 40)
folded = foldAlongY(folded, yfold: 27)
folded = foldAlongY(folded, yfold: 13)
folded = foldAlongY(folded, yfold: 6)

var paper = ""
    for y in 0..<folded[0].count {
        for x in 0..<folded.count {
            paper.append(folded[x][y] ? "#" : " ")
        }
        paper.append("\n")
    }

    return paper
}

print(part1()) // Answer: 785
print(part2()) // Answer: FJAHJGAH
