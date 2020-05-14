import UIKit


//给定一个非空整数数组，除了某个元素只出现一次以外，其余每个元素均出现两次。找出那个只出现了一次的元素。
//
//说明：
//
//你的算法应该具有线性时间复杂度。 你可以不使用额外空间来实现吗？
//
//示例 1:
//
//输入: [2,2,1]
//输出: 1
//示例 2:
//
//输入: [4,1,2,1,2]
//输出: 4


// ******************* 解法1 异或 *********************//
/// 位运算是我第一个想到的办法，因为之前做过一个类似的，并且比这个难的题目，那个题目是寻找不重复的两个数，做两次位运算
/// 这个更简单，只有一个不重复的数，所以整个表异或下来就是想要的值，时间复杂度O(n)，空间复杂度 O(1)
/// 刚开始不知道 0^一个值 等于它本身，所以其实初始值设置0就可以；
/// 但是这种方法：执行用时 : 100 ms, 在所有 Swift 提交中击败了70.39%的用户；是否有更高效的解法？？
class Solution {
    func singleNumber(_ nums: [Int]) -> Int {
        var result: Int = 0
        nums.forEach { val in
            result ^= val
        }

        return result
    }
}


// ******************* 解法2 hash map *********************//
///
class Solution2 {
    func singleNumber(_ nums: [Int]) -> Int {
        var map: [Int: Int] = [:]
        nums.forEach { val in
            if let _ = map[val] {
                map.removeValue(forKey: val)
            } else {
                map[val] = 1
            }
        }
        
        var result = 0
        if let (key, _) = map.first {
            result = key
        }

        return result
    }
}

let solu2 = Solution2()
let result2 = solu2.singleNumber([2,1,2,3,1,4,3,4,7])
print(result2)


// ******************* 解法2 利用数学公式 *********************//
/// 公式：2∗(a+b+c)−(a+a+b+b+c)=c
class Solution3 {
    func singleNumber(_ nums: [Int]) -> Int {
        var sum1: Int = 0
        var sum2: Int = 0
        var set: Set = Set<Int>()
        nums.forEach { val in
            if !set.contains(val){
                set.insert(val)
                sum1 += val
            }
            sum2 += val
        }

        return (2*sum1 - sum2)
    }
}

let solu3 = Solution3()
let result3 = solu3.singleNumber([2,1,2,3,1,4,3,4,7])
print(result3)
