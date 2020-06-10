import UIKit

//9. 回文数
//判断一个整数是否是回文数。回文数是指正序（从左向右）和倒序（从右向左）读都是一样的整数。
//
//示例 1:
//输入: 121
//输出: true
//示例 2:
//输入: -121
//输出: false
//解释: 从左向右读, 为 -121 。 从右向左读, 为 121- 。因此它不是一个回文数。
//示例 3:
//输入: 10
//输出: false
//解释: 从右向左读, 为 01 。因此它不是一个回文数。
//进阶:
//你能不将整数转为字符串来解决这个问题吗？


// **************************** 解法一 回文串 ***************************** //
class Solution {
    func isPalindrome(_ x: Int) -> Bool {
        if x < 0 || (x % 10 == 0 && x != 0){
            return false
        }
        
        var src: Int = x
        var reverseNum: Int = 0
        
        while src > reverseNum { // 这里的判断挺巧的，
            let last = src % 10
            reverseNum *= 10
            reverseNum += last
            src /= 10
        }
        
        return (src == reverseNum) || (reverseNum/10 == src)
    }
}
let solu = Solution()
let result = solu.isPalindrome(-121)
print(result)
