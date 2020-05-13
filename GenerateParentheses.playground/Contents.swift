import UIKit

//题目：数字 n 代表生成括号的对数，请你设计一个函数，用于能够生成所有可能的并且 有效的 括号组合。
//
//示例：
//
//输入：n = 3
//输出：[
//       "((()))",
//       "(()())",
//       "(())()",
//       "()(())",
//       "()()()"
//     ]

// ******************** 第一个解法 ******************//
/// 其实这个解法就是回溯法，只不过，str+""为我们省去了抹去原来的选择的步骤；

class Solution {
    var result: [String] = []
    func generateParenthesis(_ n: Int) -> [String] {
        generateDeep("", n, 0, 0)
        return result
    }
    
    func generateDeep(_ str: String, _ n: Int, _ leftc: Int, _ rightc: Int) {
        if str.count >= n*2 {
            // 结束条件是：超过2n个时，说明括号已达到数量
            result.append(str)
            return
        }
        
        // 左括号数不能大于 n
        if leftc < n {
            generateDeep(str+"(", n, leftc+1, rightc)
        }
        // 右括号数不能大于 n  而且还不能比左括号多
        if leftc > rightc {
            generateDeep(str+")", n, leftc, rightc+1)
        }
    }
}

let solu = Solution()
let r = solu.generateParenthesis(3)
print(r)
