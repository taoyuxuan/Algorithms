import UIKit

//198. 打家劫舍
//你是一个专业的小偷，计划偷窃沿街的房屋。每间房内都藏有一定的现金，影响你偷窃的唯一制约因素就是相邻的房屋装有相互连通的防盗系统，如果两间相邻的房屋在同一晚上被小偷闯入，系统会自动报警。
//给定一个代表每个房屋存放金额的非负整数数组，计算你 不触动警报装置的情况下 ，一夜之内能够偷窃到的最高金额。
//
//示例 1:
//输入: [1,2,3,1]
//输出: 4
//解释: 偷窃 1 号房屋 (金额 = 1) ，然后偷窃 3 号房屋 (金额 = 3)。
//     偷窃到的最高金额 = 1 + 3 = 4 。
//示例 2:
//输入: [2,7,9,3,1]
//输出: 12
//解释: 偷窃 1 号房屋 (金额 = 2), 偷窃 3 号房屋 (金额 = 9)，接着偷窃 5 号房屋 (金额 = 1)。
//     偷窃到的最高金额 = 2 + 9 + 1 = 12 。

// **************************** 解法一 动态规划 **************************** //
/// 其实刚开始能想到是用动态规划，但是吧，还是不会找动态方程，还有初始条件，知道第n个结果是由第n-1个结果选择或者不选择决定的
class Solution {
    func rob(_ nums: [Int]) -> Int {
        let count: Int = nums.count
        
        if count < 3 {
            if count == 0 {
                return 0
            } else if count == 1 {
                return nums[0]
            }
            return max(nums[0], nums[1])
        }
        
        var pre2: Int = nums[0]
        var pre1: Int = max(nums[0], nums[1])
        for i in 2..<count {
            let current = max(pre2+nums[i], pre1)
            pre2 = pre1
            pre1 = current
        }
        
        return pre1
    }
}

let solu = Solution()
let result = solu.rob([2,7,9,3,1])
print(result)
