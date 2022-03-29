#!/usr/bin/env swift

typealias Boards = [[Int]]

func readBoard() -> Boards {
    var board = [[Int]]()
    while let line = readLine() {
        if line.isEmpty {
            return board
        }
        board.append(line.split(separator: " ").map {
            Int($0)!
        })
    }
    return board
}

func readInput() -> ([Int], [Boards]) {
    let drawer = readLine()!.split(separator: ",").map { Int(String($0))! }
    _ = readLine()

    var boards = [Boards]()
    while true {
        let board = readBoard()
        if board.isEmpty {
            return (drawer, boards)
        }
        boards.append(board)
    }
}

var (drawer, boards) = readInput()

func checkBingo(board: Boards, row: Int, col: Int) -> Bool {
    var win = true
    for i in 0...4 where board[row][i] >= 0 {
        win = false
        break
    }
    if win { return true} else { win = true}
    for i in 0...4 where board[i][col] >= 0 {
        win = false
        break
    }
    return win
}

func checkBoard(_ board: inout Boards, _ num: Int) -> Bool {
    for i in 0...4 {
        for j in 0...4 where board[i][j] == num {
            board[i][j] = -board[i][j]
            return checkBingo(board: board, row: i%5, col: j)
        }
    }
    return false
}

func sumUnmarked(_ board: Boards) -> Int {
    var sum = 0
    for i in 0...4 {
        for j in 0...4 where board[i][j] > 0 {
            sum += board[i][j]
        }
    }
    return sum
}

func part1() -> String {
    repeat {
        let number = drawer.removeFirst()
        for i in 0...boards.count - 1 where checkBoard(&boards[i], number) {
            return String(sumUnmarked(boards[i]) * number)
        }
    } while (!drawer.isEmpty)
    print("panic: No Winner Board!")
    fatalError()
}

func part2() -> String {
   var lastBoardToWin = 0
   var lastNumberToWin = 0
   var winnerSet: Set<Int> = []

   repeat {
        let number = drawer.removeFirst()
        for i in 0...boards.count - 1 where
            (!winnerSet.contains(i) && checkBoard(&boards[i], number)) {
                winnerSet.insert(i)
                lastBoardToWin = i
                lastNumberToWin = number
        }
    } while (!drawer.isEmpty)
    return String(sumUnmarked(boards[lastBoardToWin]) * lastNumberToWin)
}

print(part1())
print(part2())
