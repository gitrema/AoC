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
        let cmd = $0.split(separator: " ")
        return (String(cmd[0]), Int(cmd[1])!)
    }

struct Point: Hashable {
    var x: Int
    var y: Int

    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

func move(_ knot: Point, direction dir: String) -> Point {
    var newPosition = knot
    switch dir {
    case "U":
        newPosition.y += 1
    case "D":
        newPosition.y -= 1
    case "R":
        newPosition.x += 1
    case "L":
        newPosition.x -= 1
    default:
        fatalError("Unknown direction")
    }
    return newPosition
}

func visitedTailPosition(knotLength length: Int) -> Int {
   var knots = Array(repeating: Point(x: 0, y: 0), count: length)
   var visited = Set<Point>([Point(x: 0, y: 0)])

   parsed.forEach {
        for _ in 0..<$0.1 {
            knots[0] = move(knots[0], direction: $0.0)
            for knot in 1..<length {
                let xdist = knots[knot - 1].x - knots[knot].x
                let ydist = knots[knot - 1].y - knots[knot].y
                if abs(xdist) > 1 || abs(ydist) > 1 {
                    if xdist != 0 {
                        knots[knot].x += (xdist < 0) ? -1 : 1
                    }
                    if ydist != 0 {
                        knots[knot].y += (ydist < 0) ? -1 : 1
                    }
                }
                visited.insert(knots.last!)
            }
        }
   }
   return visited.count
}

func part1() -> Int {
    return visitedTailPosition(knotLength: 2)
}
print("part1: \(part1())") // part1: 6464

func part2() -> Int {
    return visitedTailPosition(knotLength: 10)
}
print("part2: \(part2())") // part2: 2604
