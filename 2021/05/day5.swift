#!/usr/bin/env swift

struct Point: Hashable {
    let x: Int
    let y: Int

    static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

struct Segment {
    let a: Point
    let b: Point
}

func readInput() -> [Segment] {
    var segments = [Segment]()
    while let line = readLine() {
        let elements = line.split(separator: " ")
                          .filter { $0 != "->" }
                          .map { String($0) }
        let pointA = elements[0].split(separator: ",").map { Int(String($0))! }
        let pointB = elements[1].split(separator: ",").map { Int(String($0))! }
        segments.append(Segment(a: Point(x: pointA[0], y: pointA[1]), b: Point(x: pointB[0], y: pointB[1])))
    }
    return segments
}
let segments = readInput()

func part1() -> String {
    var table = [Point: Int]()
    segments.forEach { segment in
        if segment.a.x == segment.b.x {
            let lower = min(segment.a.y, segment.b.y)
            let upper = max(segment.a.y, segment.b.y)
            for i in lower...upper {
                table[Point(x: segment.a.x, y: i), default: 0] += 1
            }
        } else if segment.a.y == segment.b.y {
            let lower = min(segment.a.x, segment.b.x)
            let upper = max(segment.a.x, segment.b.x)
            for i in lower...upper {
                table[Point(x: i, y: segment.a.y), default: 0] += 1
            }
        }
    }

    var intersectPoints = 0
    for (_, weight) in table where weight > 1 {
        intersectPoints += 1
    }
    return String(intersectPoints)
}

func part2() -> String {
    var table = [Point: Int]()
    segments.forEach { segment in
        if segment.a.x == segment.b.x {
            let lower = min(segment.a.y, segment.b.y)
            let upper = max(segment.a.y, segment.b.y)
            for i in lower...upper {
                table[Point(x: segment.a.x, y: i), default: 0] += 1
            }
        } else if segment.a.y == segment.b.y {
            let lower = min(segment.a.x, segment.b.x)
            let upper = max(segment.a.x, segment.b.x)
            for i in lower...upper {
                table[Point(x: i, y: segment.a.y), default: 0] += 1
            }
        } else if abs(segment.a.x - segment.b.x) == abs(segment.a.y - segment.b.y) {
            let distance = abs(segment.a.x - segment.b.x)
            let xinc = (segment.a.x - segment.b.x) < 0 ? 1 : -1
            let yinc = (segment.a.y - segment.b.y) < 0 ? 1 : -1
            for i in 0...distance {
                let nextx = segment.a.x + i*xinc
                let nexty = segment.a.y + i*yinc
                table[Point(x: nextx, y: nexty), default: 0] += 1
            }
        }
    }
    var intersectPoints = 0
    for (_, weight) in table where weight > 1 {
        intersectPoints += 1
    }
    return String(intersectPoints)
}

print(part1())
print(part2())
