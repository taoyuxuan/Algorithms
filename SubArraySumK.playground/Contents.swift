import UIKit

//560. 和为K的子数组
//给定一个整数数组和一个整数 k，你需要找到该数组中和为 k 的连续的子数组的个数。
//
//示例 1 :
//
//输入:nums = [1,1,1], k = 2
//输出: 2 , [1,1] 与 [1,1] 为两种不同的情况。
//说明 :
//
//数组的长度为 [1, 20,000]。
//数组中元素的范围是 [-1000, 1000] ，且整数 k 的范围是 [-1e7, 1e7]。


// *************************** 解法一 暴力解法****************************//
/// 刚开始只想到暴力解法，而且想减少一点时间，就想着将最后几位sum小于k的直接退出，
/// 后来提交时，发现自己忘了元素有可能为负数的情况了，如果为负数的话，加上负数元素小，减去它之后总和会变大
class Solution {
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        let count: Int = nums.count
        
        var result: Int = 0
        for (i, val) in nums.enumerated() {
            var sum: Int = val
            if sum == k {
                result += 1
            }
            var j: Int = i+1
            while j < count {
                sum += nums[j]
                if sum == k {
                    result += 1
                }
                j += 1
            }
        }

        return result
    }
}

// *************************** 解法二 前缀和+哈希表 ****************************//
/// 用哈希表记录前缀和出现的次数 和为key 次数为value； j...k 的和为k的话，   sum[i] - k == pre[j-1]；到第i个的时候计算sum[i]-k 出现的次数 直接查哈希表即可。
/// 时间复杂度 O(n)
/// 空间复杂度 O(n)
class Solution2 {
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        var map: [Int: Int] = [0:1]
        var pre: Int = 0
        
        var result: Int = 0
        
        nums.forEach { val in
            pre += val
            if let tmpCount = map[pre-k] {
                result += tmpCount
            }
            if let precount = map[pre] {
                map[pre] = precount + 1
            } else {
                map[pre] = 1
            }
        }
        
        return result
    }
}

let solu2 = Solution2()
let result2 = solu2.subarraySum([28,54,7,-70,22,65,-6], 100)
print(result2)
