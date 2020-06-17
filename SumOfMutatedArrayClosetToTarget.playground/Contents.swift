import UIKit

//1300. 转变数组后最接近目标值的数组和
//给你一个整数数组 arr 和一个目标值 target ，请你返回一个整数 value ，使得将数组中所有大于 value 的值变成 value 后，数组的和最接近  target （最接近表示两者之差的绝对值最小）。
//如果有多种使得和最接近 target 的方案，请你返回这些整数中的最小值。
//请注意，答案不一定是 arr 中的数字。
//
//示例 1：
//输入：arr = [4,9,3], target = 10
//输出：3
//解释：当选择 value 为 3 时，数组会变成 [3, 3, 3]，和为 9 ，这是最接近 target 的方案
//
//示例 2：
//输入：arr = [2,3,5], target = 10
//输出：5
//
//示例 3：
//输入：arr = [60864,25176,27249,21296,20204], target = 56803
//输出：11361
//提示：
//1 <= arr.length <= 10^4
//1 <= arr[i], target <= 10^5

// ************************ 自己的解法 *************************** //
/// 思路：
/// 1.首先排序 O(nlogn);
/// 2.然后计算target的平均值
/// 3.然后二分查找到 与平均值相近的位置
/// 4.然后从平均值相近的位置开始遍历，得出剩余值平均值小于当前值时停止，并记录最后一个大于的值
/// 然后查找判断这个平均值和平均值大于1的值进行比较，哪个和target更接近，接近的则是最后的结果值
/// 特殊情况 ⚠️  1.所有值都大于平均值  2.和正好等于target的情况 3.和小于target的情况。


class Solution {
    func findBestValue(_ arr: [Int], _ target: Int) -> Int {
        let sortedNums: [Int] = arr.sorted()
        let count: Int = arr.count
        let average: Int = target/count

        if sortedNums[0] >= average {
            let ave1: Int = target - average*count
            let ave2: Int = (average + 1)*count - target
            return ave1 > ave2 ? average+1 : average
        }
        
        var l: Int = 0
        var r: Int = count - 1
        var startIdx: Int = l
        while l < r {
            let mid: Int = (l+r)/2
            if sortedNums[mid] == average {
                startIdx = mid
                break
            } else if mid > 0 && sortedNums[mid] > average && sortedNums[mid-1] <= average {
                startIdx = mid - 1
                break
            } else if sortedNums[mid] <= average && sortedNums[mid+1] > average {
                startIdx = mid
                break
            } else if sortedNums[mid] > average {
                r = mid - 1
            } else if sortedNums[mid] < average{
                l = mid + 1
            }
        }

        var currentSum: Int = 0
        var validSum: Int = 0
        var lastIdx: Int = 0
        var ans: Int = 0
        var shouldJudge: Bool = false
        for i in 0..<count {
            currentSum += sortedNums[i]
            if i < startIdx {
                continue
            }
            let remainCount: Int = count - 1 - i
            var remain: Int = sortedNums[i]
            if remainCount != 0 {
                remain = (target - currentSum)/remainCount
            }

            if remain >= sortedNums[i] {
                ans = remain
                lastIdx = i
                validSum = currentSum
                if remain == sortedNums[i] {
                    shouldJudge = false
                    break
                } else {
                    shouldJudge = true
                }
            } else {
                break
            }
        }

        if shouldJudge {
            let t1 = validSum + ans * (count-1-lastIdx)
            let t2 = validSum + (ans + 1) * (count-1-lastIdx)
            ans = (target-t1) > (t2 - target) ? ans + 1 : ans
        }
        
        return ans
    }
}
