import UIKit

//面试题29. 顺时针打印矩阵
//输入一个矩阵，按照从外向里以顺时针的顺序依次打印出每一个数字。
//
//
//示例 1：
//输入：matrix = [[1,2,3],[4,5,6],[7,8,9]]
//输出：[1,2,3,6,9,8,7,4,5]
//示例 2：
//输入：matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]
//输出：[1,2,3,4,8,12,11,10,9,5,6,7]
//限制：
//0 <= matrix.length <= 100
//0 <= matrix[i].length <= 100


// ********************* 解法一 模拟 ************************//
/// 利用方向数组 和 以访问过的进行记录
class Solution {
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        let h: Int = matrix.count
        if h == 0 {
            return []
        }
        let w: Int = matrix[0].count
        var ans: [Int] = []
        var visited:[[Bool]] = Array(repeating: Array(repeating: false, count: w), count: h)
        var dire: [[Int]] = [[0, 1], [1,0], [0,-1],[-1,0]]
        var dirIdx: Int = 0
        var row = 0
        var column = 0
        let total: Int = w*h
        for i in 0..<total {
            ans.append(matrix[row][column])
            visited[row][column] = true
            let nextRow = row + dire[dirIdx][0]
            let nextColoum = column + dire[dirIdx][1]
            if nextRow < 0 || nextRow >= h || nextColoum >= w || nextColoum < 0 || visited[nextRow][nextColoum] {
                dirIdx = (dirIdx + 1)%4
            }
            row += dire[dirIdx][0]
            column += dire[dirIdx][1]
        }
        
        return ans
    }
}
let solu = Solution()
let result = solu.spiralOrder([[1,2,3,4],[5,6,7,8],[9,10,11,12]])
print(result)

// ********************* 解法一 按层遍历 ************************//
/// 从最外层开始，依次向内
/// 这里的停止条件有点不是那么搞懂，举例子走一遍
class Solution2 {
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        let h: Int = matrix.count
        if h == 0 {
            return []
        }
        let w: Int = matrix[0].count
        var ans: [Int] = []
        
        var left: Int = 0
        var right: Int = w-1
        var top: Int = 0
        var bottom: Int = h-1
        while left <= right && top <= bottom {
            // 先遍历上层
            for column in left...right {
                ans.append(matrix[top][column])
            }
            // 遍历右侧
            if top + 1 <= bottom {
                for row in (top+1)...bottom {
                    ans.append(matrix[row][right])
                }
            }
            
            if left < right && top < bottom {
                for colum in (left..<(right)).reversed() {
                    ans.append(matrix[bottom][colum])
                }
                
                for row in (top+1..<bottom).reversed() {
                    ans.append(matrix[row][left])
                }
            }
            
            left += 1
            right -= 1
            top += 1
            bottom -= 1
        }
        
        return ans
    }
}
let solu2 = Solution2()
let result2 = solu2.spiralOrder([[1,2,3,4],[5,6,7,8],[9,10,11,12]])
print(result2)
