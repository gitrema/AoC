struct Matrix<Element> {
    var storage = [[Element]]()
    var ncols = 0
    var nrows = 0

    init(nrows: Int, ncols: Int) {
        self.storage = [Element](repeating: 0.0, count: nrows*ncols)
        self.nrows = nrows
        self.ncols = ncols
    }

    func rows() -> [Element] {

    }

    func cols() -> [Element] {

    }

    subscript(row: Int, col: Int) -> Element {
        get {
            return storage[(row * ncols) + col]
        }
        set {
            storage[(row * ncols) + col] = newValue
        }
    }

    func transpose() -> Matrix<Element> {
        let trans = Matrix(rows: self.ncols, columns: self.nrows)
        for row in 0..<self.nrows {
            for col in 0..<self.ncols {
                trans[col, row] = self[row, col]
            }
        }
        return trans
    }

    func toString() -> String {
        var description = ""
        for row in 0..<self.nrows {
            for col in 0..<self.ncols {
                description += String(self[row, col])
            }
            description += "\n"
        }
        return description
    }
}
