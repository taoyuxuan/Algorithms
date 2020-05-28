import UIKit

//974. 和可被 K 整除的子数组
//给定一个整数数组 A，返回其中元素之和可被 K 整除的（连续、非空）子数组的数目。
//
//示例：
//输入：A = [4,5,0,-2,-3,1], K = 5
//输出：7
//解释：
//有 7 个子数组满足其元素之和可被 K = 5 整除：
//[4, 5, 0, -2, -3, 1], [5], [5, 0], [5, 0, -2, -3], [0], [0, -2, -3], [-2, -3]
//
//提示：
//1 <= A.length <= 30000
//-10000 <= A[i] <= 10000
//2 <= K <= 10000


// ***************************** 解法一 前缀和+hash ****************************** //
/// 这个最大的一个问题就是如果和负数的时候，取模如何判断，刚开始我是没考虑负数的情况导致 [-1, 2, 9] 2 这个用例过不去，
/// 所以，我又死磕了，！！！！ 浪费时间！！
/// 看答案 很简单，直接加一个K 然后再取模就完事了！！
class Solution {
    func subarraysDivByK(_ A: [Int], _ K: Int) -> Int {
        let count: Int = A.count
        
        var sumsMap: [Int: Int] = [:]
        var current: Int = 0 //前缀和
        var result: Int = 0
        for val in A {
            current += val
            let key: Int = (current%K + K) % K
            var preCount: Int = 0
            if let cnt = sumsMap[key] {
                preCount = cnt
            }
            sumsMap[key] = preCount + 1
            result += preCount
            if key == 0 {
                result += 1
            }
        }
        
        return result
    }
}
let solu = Solution()
//let result = solu.subarraysDivByK([-1, 2, 9], 2)
let result = solu.subarraysDivByK([4,5,0,-2,-3,1], 5)
print(result)
