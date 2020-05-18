import UIKit

//152. 乘积最大子数组
//给你一个整数数组 nums ，请你找出数组中乘积最大的连续子数组（该子数组中至少包含一个数字），并返回该子数组所对应的乘积。
//
//示例 1:
//输入: [2,3,-2,4]
//输出: 6
//解释: 子数组 [2,3] 有最大乘积 6。
//
//示例 2:
//输入: [-2,0,-1]
//输出: 0
//解释: 结果不能为 2, 因为 [-2,-1] 不是子数组。

// ***************************** 解法一 暴力破解 *****************************//
/// 时间复杂度O(n^2);  空间复杂度：O(1)

class Solution {
    func maxProduct(_ nums: [Int]) -> Int {
        let count: Int = nums.count
        
        var max: Int = 0
        
        var i: Int = 0
        nums.forEach { val in
            var currentMulti: Int = 1
            for j in i..<count {
                currentMulti *= nums[j]
                if currentMulti > max {
                    max = currentMulti
                }
            }
            i += 1
        }
        
        return max
    }
}

let solu = Solution()
let result = solu.maxProduct([2,-5,-2,-4,3])
print(result)


// ***************************** 解法二 优化方案 动态规划 *****************************//
/// 时间复杂度O(n);空间复杂度: O(n)
class Solution2 {
    func maxProduct(_ nums: [Int]) -> Int {
        let count: Int = nums.count
        
        var maxMulti: [Int] = nums
        var minMulti: [Int] = nums
        
        var i: Int = 0
        nums.forEach { val in
            if i != 0 {
                maxMulti[i] = max(maxMulti[i-1]*val, max(minMulti[i-1]*val, val))
                minMulti[i] = min(minMulti[i-1]*val, min(maxMulti[i-1]*val, val))
            }
            i += 1
        }
        
        var maxV: Int = 1
        var j: Int = 0
        maxMulti.forEach { val in
            if j == 0 {
                maxV = val
            } else {
                maxV = val > maxV ? val : maxV
            }
            j += 1
        }
        
        return maxV
    }
}
let solu2 = Solution2()
let result2 = solu.maxProduct([2,-5,-2,-4,3])
print(result2)

// ***************************** 解法三 优化方案 动态规划空间优化 *****************************//
/// 时间复杂度O(n); 空间复杂度: O(1)
class Solution3 {
    func maxProduct(_ nums: [Int]) -> Int {
        var maxMulti: Int = nums[0]
        var minMulti: Int = nums[0]
        var maxV: Int = nums[0]
        
        var i: Int = 0
        nums.forEach { val in
            if i != 0 {
                let nextMaxMulti = max(maxMulti*val, max(minMulti*val, val))
                let nextMinMulti = min(minMulti*val, min(maxMulti*val, val))
                maxV = nextMaxMulti > maxV ? nextMaxMulti : maxV
                maxMulti = nextMaxMulti
                minMulti = nextMinMulti
            }
            i += 1
        }
        
        return maxV
    }
}
let solu3 = Solution3()
let result3 = solu.maxProduct([2,-5,-2,-4,3])
print(result3)

// ***************************** 解法四 国际站高票答案 *****************************//
/// 时间复杂度O(n); 空间复杂度: O(1)
/// 其实这个就是方法三一样的思想，都是动态规划而且用O(1)空间复杂度
/// 只不过代码很漂亮，在此做借鉴
// c++的代码：
//int maxProduct(int A[], int n) {
//    // store the result that is the max we have found so far
//    int r = A[0];
//
//    // imax/imin stores the max/min product of
//    // subarray that ends with the current number A[i]
//    for (int i = 1, imax = r, imin = r; i < n; i++) {
//        // multiplied by a negative makes big number smaller, small number bigger
//        // so we redefine the extremums by swapping them
//        if (A[i] < 0)
//            swap(imax, imin);
//
//        // max/min product for the current number is either the current number itself
//        // or the max/min by the previous number times the current one
//        imax = max(A[i], imax * A[i]);
//        imin = min(A[i], imin * A[i]);
//
//        // the newly computed max value is a candidate for our global result
//        r = max(r, imax);
//    }
//    return r;
//}
class Solution4 {
    func maxProduct(_ nums: [Int]) -> Int {
        var maxV: Int = nums[0]
        
        var iMax: Int = maxV
        var iMin: Int = maxV
        for i in 1..<nums.count {
            // 如果当前元素小于0，那么对于当前元素来说最大值就是iMin
            if nums[i] < 0 {
                swap(&iMax, &iMin)
            }
            iMax = max(nums[i], iMax*nums[i])
            iMin = min(nums[i], iMin*nums[i])
            maxV = max(iMax, maxV)
        }
        
        return maxV
    }
}
let solu4 = Solution()
let result4 = solu.maxProduct([2,-5,-2,-4,3])
print(result4)
