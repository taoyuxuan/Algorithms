import UIKit

//287. 寻找重复数
//给定一个包含 n + 1 个整数的数组 nums，其数字都在 1 到 n 之间（包括 1 和 n），可知至少存在一个重复的整数。假设只有一个重复的整数，找出这个重复的数。
//
//示例 1:
//输入: [1,3,4,2,2]
//输出: 2
//示例 2:
//输入: [3,1,3,4,2]
//输出: 3
//说明：
//不能更改原数组（假设数组是只读的）。
//只能使用额外的 O(1) 的空间。
//时间复杂度小于 O(n2) 。
//数组中只有一个重复的数字，但它可能不止重复出现一次。


// ************************* 解法一 二分查找 ****************************//
/// 我能说我这么简单的题都没做出来吗？！！！ 我又是看的答案！
/// 1.nums数组中只包括 1到n之间的数字。如果只有一个重复数字的话，只有这个target出现了两次，
/// 其余的各出现了1次，小于targe的数 i 满足 cnt[i] = i；大于等于target的数 j 满足cnt[j]=j+1
/// 2.如果测试用例中target出现了3次以上，那必然有一些数是不存在于nums数组中的，这时候相当于用targe替换了这些数
/// 如果替换的 i 小于target 那么 [0, target-1] 的值均减1，其他不变；如果替换的数 j 大于等于target，那么[target, j-1]的cnt值均增加1，其他不变。
class Solution {
    func findDuplicate(_ nums: [Int]) -> Int {
        let count = nums.count
        var l = 0
        var r = count-1
        var ans: Int = -1
        while l <= r {
            let mid = (l+r)/2
            var cnt = 0
            for i in 0..<count {
                cnt += (nums[i] <= mid ? 1 : 0)
            }
            if cnt <= mid {
                l = mid + 1
            } else {
                r = mid - 1
                ans = mid
            }
        }
        
        return ans
    }
}
let solu = Solution()
let result = solu.findDuplicate([1,3,4,2,2])
print(result)



// ************************* 解法二 二进制 ****************************//
/// 通过计算每个数  每一位是0 还是1。跟正常的0 到 1相比哪一位多1，并记录下不同位数的位，然后将位数统一或进一个数内
/// 得到的结果就是想要的

class Solution2 {
    func findDuplicate(_ nums: [Int]) -> Int {
        let count = nums.count
        var ans = 0
        var bit_max = 31
        while (((count-1) >> bit_max) == 0) {
            bit_max -= 1
        }
        for bit in 0..<bit_max {
            var x = 0
            var y = 0
            for i in 0..<count {
                // 判断当前位是否为1，如果为1 数加1
                if nums[i] & (1 << bit) > 0 {
                    x += 1
                }
                // 判断正常位时
                if i >= 1 && (i & (1 << bit) == 1) {
                    y += 1
                }
            }
            if x > y {
                ans |= 1 << bit
            }
        }
        return ans
    }
}
let solu2 = Solution2()
let result2 = solu2.findDuplicate([1,3,4,2,2])
print(result2)


// ************************* 解法二 快慢指针法 ****************************//
/// 这种方法 我不太明白的是：为什么需要进行两次循环？
/// Floyd 判环算法
class Solution3 {
    func findDuplicate(_ nums: [Int]) -> Int {
        var slow = 0
        var fast = 0
        repeat {
            slow = nums[slow]
            fast = nums[nums[fast]]
        } while slow != fast
        slow = 0
        repeat {
            slow = nums[slow]
            fast = nums[fast]
        } while slow != fast
        return  slow
    }
}
let solu3 = Solution3()
let result3 = solu3.findDuplicate([1,3,4,2,2])
print(result3)
