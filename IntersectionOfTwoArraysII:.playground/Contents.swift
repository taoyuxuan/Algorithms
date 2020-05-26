import UIKit

//350. 两个数组的交集 II
//给定两个数组，编写一个函数来计算它们的交集。
//
//示例 1:
//输入: nums1 = [1,2,2,1], nums2 = [2,2]
//输出: [2,2]
//
//示例 2:
//输入: nums1 = [4,9,5], nums2 = [9,4,9,8,4]
//输出: [4,9]
//
//说明：
//输出结果中每个元素出现的次数，应与元素在两个数组中出现的次数一致。
//我们可以不考虑输出结果的顺序。
//进阶:
//如果给定的数组已经排好序呢？你将如何优化你的算法？
//如果 nums1 的大小比 nums2 小很多，哪种方法更优？
//如果 nums2 的元素存储在磁盘上，磁盘内存是有限的，并且你不能一次加载所有的元素到内存中，你该怎么办？

// ********************** 解法一 ************************** //
class Solution {
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        
        let len1: Int = nums1.count
        let len2: Int = nums2.count
        if len1 > len2 {
            return intersect(nums2, nums1)
        }
        
        // 直接交换参数 或者判断一下参数的大小
        // let minArr: [Int] = (len1 == len2) ? nums1 : (len1 < len2 ? nums1 : nums2)
        // let maxArr: [Int] = (len1 == len2) ? nums2 : (len1 > len2 ? nums1 : nums2)

        var map: [Int: Int] = [:]
        for (_, val) in nums1.enumerated() {
            if let cnt = map[val] {
                map[val] = cnt + 1
            } else {
                map[val] = 1
            }
        }
        var result: [Int] = []
        nums2.forEach { val in
            if let idx = map[val], idx > 0 {
                result.append(val)
                map[val] = idx - 1
                if idx - 1 == 0 {
                    map.removeValue(forKey: val)
                }
            }
        }

        return result
    }
}


