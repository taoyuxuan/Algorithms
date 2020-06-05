import UIKit

//面试题05. 替换空格
//请实现一个函数，把字符串 s 中的每个空格替换成"%20"。
//
//示例 1：
//输入：s = "We are happy."
//输出："We%20are%20happy."

// **************************** 解法一 *************************** //
class Solution {
    func replaceSpace(_ s: String) -> String {
        return s.replacingOccurrences(of: " ", with: "%20")
    }
}
let solu = Solution()
let result = solu.replaceSpace("We are happy.")
print(result)
