import UIKit

//4. 寻找两个正序数组的中位数
//给定两个大小为 m 和 n 的正序（从小到大）数组 nums1 和 nums2。
//请你找出这两个正序数组的中位数，并且要求算法的时间复杂度为 O(log(m + n))。
//你可以假设 nums1 和 nums2 不会同时为空。
//
//示例 1:
//nums1 = [1, 3]
//nums2 = [2]
//则中位数是 2.0
//示例 2:
//nums1 = [1, 2]
//nums2 = [3, 4]
//则中位数是 (2 + 3)/2 = 2.5


// **************************** 解法一 二分查找 ****************************** //
class Solution {
    
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        let len1 = nums1.count
        let len2 = nums2.count
        let totalLen = len1 + len2
        if totalLen % 2 == 1 {
            // 奇数
            let midIndex = totalLen/2
            
            
        } else {
            // 偶数
            let midIdx1 = totalLen/2 - 1
            let midIdx2 = totalLen/2
//            let me
        }
        
        return 0
    }
    
    func getKthElement(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> Int {
        let len1: Int = nums1.count
        let len2: Int = nums2.count
        var idx1: Int = 0
        var idx2: Int = 0
        var kthElement: Int = 0
        var tk: Int = k
        while true {
            if idx1 == len1 {
                return nums2[idx2 + tk - 1]
            }
            if idx2 == len2 {
                return nums1[idx1 + tk - 1]
            }
            
            if tk == 1 {
                return min(nums1[idx1], nums2[idx2])
            }
            
            let half = tk/2
            let newidx1 = min(idx1+half, len1) - 1
            let newidx2 = min(idx2+half, len2) - 1
            let pivot1 = nums1[newidx1]
            let pivot2 = nums2[newidx2]
            if pivot1 < pivot2 {
                tk -= (newidx1 - idx1 + 1)
                idx1 = newidx1 + 1
            } else {
                tk -= newidx2 - idx2 + 1
                idx2 = newidx2 + 1
            }
        }
    }
}

let solu = Solution()
let result = solu.findMedianSortedArrays([1, 2], [3,4])
print(result)
