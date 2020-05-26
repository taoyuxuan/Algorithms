import UIKit

//239. 滑动窗口最大值
//给定一个数组 nums，有一个大小为 k 的滑动窗口从数组的最左侧移动到数组的最右侧。你只可以看到在滑动窗口内的 k 个数字。滑动窗口每次只向右移动一位。
//
//返回滑动窗口中的最大值。
//
//进阶：
//你能在线性时间复杂度内解决此题吗？
//示例:
//输入: nums = [1,3,-1,-3,5,3,6,7], 和 k = 3
//输出: [3,3,5,5,6,7]
//解释:
//  滑动窗口的位置                最大值
//---------------               -----
//[1  3  -1] -3  5  3  6  7       3
// 1 [3  -1  -3] 5  3  6  7       3
// 1  3 [-1  -3  5] 3  6  7       5
// 1  3  -1 [-3  5  3] 6  7       5
// 1  3  -1  -3 [5  3  6] 7       6
// 1  3  -1  -3  5 [3  6  7]      7


// *********************** 解法一 双端队列 + 插入时判断大小 ************************* //
/// 这个方法是从暴力解法 优化得来的，每次元素插入队列的时候，将它前面较小的值都移除出去，
/// 留下的队列的最前面的就是最小的值
class Solution {
    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        let count = nums.count
        if k == 0 || count == 0 {
            return []
        }
        var maxArr: [Int] = []
        var queue: [Int] = []
        
        for i in 0..<count {
            // 清除第一个元素
            if !queue.isEmpty && queue.first == i - k {
                queue.removeFirst()
            }
            // 清除i前面比nums[i]小的元素
            while !queue.isEmpty && (nums[i] > nums[queue.last!]) {
                queue.removeLast()
            }
            // 添加第i个元素
            queue.append(i)
            if i >= k - 1 {
                maxArr.append(nums[queue.first!])
            }
        }
        
        return maxArr
    }
}


// ****************************** 解法二 动态规划***************************** //
/// 将数据分块，每k个为一组，循环一次，组建lefts和rights数组，记录每个元素左边k个元素的最大值和右边k个元素的最大值
/// 最后再循环一遍计算k个元素后 left[i]和right[i]的最大值
class Solution2 {
    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        let count = nums.count
        if k == 0 || count == 0 {
            return []
        }

        var lefts: [Int] = Array.init(repeating: 0, count: count)
        var rights: [Int] = Array.init(repeating: 0, count: count)
        rights[count-1] = nums[count-1]
        for i in 0..<count {
            if i%k == 0 {
                lefts[i] = nums[i]
            } else {
                lefts[i] = max(nums[i], lefts[i-1])
            }
            let j = count - 1 - i
            if i == 0 { continue }
            if (j+1)%k == 0 {
              rights[j] = nums[j]
            } else {
                rights[j] = max(nums[j], rights[j+1])
            }
        }
        var results: [Int] = [lefts[k-1]]
        // 再循环一遍，扩充结果数组
        for i in k..<count {
            results.append(max(lefts[i], rights[i-k+1]))
        }

        return results
    }
}
