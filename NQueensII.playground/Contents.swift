import UIKit

//51. N皇后
//n 皇后问题研究的是如何将 n 个皇后放置在 n×n 的棋盘上，并且使皇后彼此之间不能相互攻击。
//
//上图为 8 皇后问题的一种解法。
//给定一个整数 n，返回所有不同的 n 皇后问题的解决方案。
//每一种解法包含一个明确的 n 皇后问题的棋子放置方案，该方案中 'Q' 和 '.' 分别代表了皇后和空位。
//
//示例:
//输入: 4
//输出: [
// [".Q..",  // 解法 1
//  "...Q",
//  "Q...",
//  "..Q."],
//
// ["..Q.",  // 解法 2
//  "Q...",
//  "...Q",
//  ".Q.."]
//]
//解释: 4 皇后问题存在两个不同的解法。
//
//提示：
//皇后，是国际象棋中的棋子，意味着国王的妻子。皇后只做一件事，那就是“吃子”。当她遇见可以吃的棋子时，就迅速冲上去吃掉棋子。当然，她横、竖、斜都可走一到七步，可进可退。（引用自 百度百科 - 皇后 ）


// *********************** 解法一 回溯 *************************//
class Solution {
    var solution: [[String]] = []
    
    var col: [Bool] = []
    var pie: [Bool] = [] // 主对角线  x-y = 常数
    var na: [Bool] = []  // 副对角线  x+y = 常数

    func solveNQueens(_ n: Int) -> [[String]] {
        self.col = Array.init(repeating: false, count: n)
        self.pie = Array.init(repeating: false, count: 2*n-1)
        self.na = Array.init(repeating: false, count: 2*n-1)
        
        var arr: [Int] = Array.init(repeating: 0, count: n)
        placeQueens(n, 0, &arr)
        
        return solution
    }

    /// index: 当前访问的行数
    /// rows: 用来存放满足题意的一种情况
    private func placeQueens(_ n: Int, _ index: Int, _ rows: inout  [Int]) {
        if index == n {
            // 说明已经到了最后一行，说明是有效答案
            addSolution(rows, n)
            return
        }
        
        for i in 0..<n {
            if isOkColumn(index, i, n) {
                rows.append(i)
                col[i] = true
                pie[index-i+n-1] = true
                na[index+i] = true
                placeQueens(n, index+1, &rows)
                col[i] = false
                pie[index-i+n-1] = false
                na[index+i] = false
                rows.removeLast()
            }
        }
    }
    
    private func isOkColumn(_ row: Int, _ column: Int, _ n: Int) -> Bool {
        if !col[column] && !pie[row-column+n-1] && !na[row+column] {
            return true
        }
        return false
    }
    
    private func addSolution(_ rows: [Int], _ n: Int) {
        var arr: [String] = []
        for val in rows {
            var chars:[Character] = Array.init(repeating: Character("."), count: n)
            chars[val] = Character("Q")
            arr.append(String(chars))
        }
        solution.append(arr)
    }
}

let solu = Solution()
let result = solu.solveNQueens(4)
print(result)
