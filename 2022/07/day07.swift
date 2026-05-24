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
        String($0)
    }

class iNode {
    var parent: iNode?
    var content: [iNode] = [iNode]()
    var name: String = ""
    var size: Int = 0
    var type: Int = 0
}

func computeSize(_ node: iNode) -> Int {
    var size = 0

    node.content.forEach {
        if $0.type == 0 {
            size += computeSize($0)
        } else {
            size += $0.size
        }
    }
    node.size = size
    return size
}

func parseInput() -> iNode {
    let root = iNode()
    root.name = "/"

    var currDir = root
    parsed.forEach {
        let cmd = $0.split(separator: " ")
        if cmd[0] == "$" {
            switch cmd[1] {
            case "cd":
                if cmd[2] == "/" {
                    currDir = root
                } else if cmd[2] == ".." {
                    currDir = currDir.parent!
                } else {
                    currDir = currDir.content.first() { $0.name == cmd[2] }!
                }
            case "ls":
                break
            default:
                fatalError("unexpected command: \(cmd[1])")
            }
        } else {
            if cmd[0] == "dir" {
                let node = iNode()
                node.parent = currDir
                node.name = String(cmd[1])
                currDir.content.append(node)
            } else {
                let node = iNode()
                node.parent = currDir
                node.name = String(cmd[1])
                node.size = Int(cmd[0])!
                node.type = 1
                currDir.content.append(node)
            }
        }
    }
    _ = computeSize(root)
    return root
}

let root = parseInput()

func dirsToDelete(_ unused: Int, _ node: iNode) -> [Int] {
    guard node.type == 0 else {
        return [Int]()
    }

    var result = [Int]()
    if (unused + node.size) >= 30000000 {
        result.append(node.size)
    }
    node.content.forEach {
        result.append(contentsOf: dirsToDelete(unused, $0))
    }
    return result
}

func part2() -> Int {
    return dirsToDelete((70000000 - root.size), root).sorted().first!
}
print("part2: \(part2())") // 4370655

func sumDirLessThan100000(_ node: iNode) -> Int {
    guard node.type == 0 else {
        return 0
    }
    var size = 0
    if node.size < 100000 {
        size = node.size
    }
    node.content.forEach {
       size += sumDirLessThan100000($0)
    }
    return size
}

func part1() -> Int {
    return sumDirLessThan100000(root)
}
print("part1: \(part1())") // 1783610
