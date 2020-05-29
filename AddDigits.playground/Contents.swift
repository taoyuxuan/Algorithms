import UIKit

//258. 各位相加
//给定一个非负整数 num，反复将各个位上的数字相加，直到结果为一位数。
//
//示例:
//输入: 38
//输出: 2
//解释: 各位相加的过程为：3 + 8 = 11, 1 + 1 = 2。 由于 2 是一位数，所以返回 2。
//进阶:
//你可以不使用循环或者递归，且在 O(1) 时间复杂度内解决这个问题吗？

// ******************************* 解法一 正常方法 ******************************* //
class Solution {
    func addDigits(_ num: Int) -> Int {
        var tnum: Int = num
        
        while tnum > 10 {
            var sum: Int = 0
            while tnum > 0 {
                sum += tnum%10
                tnum /= 10
            }
            tnum = sum
        }
        
        return tnum
    }
}
let solu = Solution()
let result = solu.addDigits(38)
print(result)



// ******************************* 解法一 数学归纳法 ******************************* //

class Solution2 {
    func addDigits(_ num: Int) -> Int {
        
        return (num - 1)%9 + 1
    }
}
let solu2 = Solution2()
let result2 = solu2.addDigits(38)
print(result2)
