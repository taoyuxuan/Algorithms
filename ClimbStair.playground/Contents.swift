import UIKit


// **************** 合理利用缓存的解法 ******************/
class Solution {
    var fn: [Int?] = []
    func climbStairs(_ n: Int) -> Int {
        fn = Array.init(repeating: nil, count: n+1)
        return getMethods(n)
    }

    func getMethods(_ n: Int) -> Int {
        if n == 1 {
            return 1
        }
        if n == 2 {
            return 2
        }

        var pre2: Int
        if let tmp2 = fn[n-2] {
            pre2 = tmp2
        } else {
            pre2 = getMethods(n-2)
        }
        var pre1: Int
        if let tmp1 = fn[n-1] {
            pre1 = tmp1
        } else {
            pre1 = getMethods(n-1)
        }
        fn[n] = pre2 + pre1
        return pre2 + pre1
    }
}

let solu1 = Solution()
let result1 = solu1.climbStairs(10)
print(result1)

// **************** 精简解法-- 最朴素的，但是时间复杂度很高 ******************/
class Solution2 {
    func climbStairs(_ n: Int) -> Int {
        return getMethods(n)
    }

    func getMethods(_ n: Int) -> Int {
        if n == 1 {
            return 1
        }
        if n == 2 {
            return 2
        }

        return (getMethods(n-1) + getMethods(n-2))
    }
}

let solu2 = Solution2()
let result2 = solu2.climbStairs(10)
print(result2)


// **************** 迭代法 - 官方解法叫 动态规划  ******************/
class Solution3 {
    func climbStairs(_ n: Int) -> Int {
        var fn: [Int] = Array.init(repeating: 0, count: n+1)
        
        for i in 1...n {
            if i == 1 {
                fn[1] = 1
            } else if i == 2 {
                fn[2] = 2
            } else {
                fn[i] = fn[i-1] + fn[i-2]
            }
        }
        return fn[n]
    }
}

let solu3 = Solution3()
let result3 = solu3.climbStairs(10)
print(result3)

// **************** 在动态规划的基础上 优化空间使用程度  ******************/
/// 巧妙
class Solution4 {
    func climbStairs(_ n: Int) -> Int {
        
        var pre2: Int = 1
        var pre1: Int = 2
        
        for _ in 3...n {
            let tmp: Int = pre1 + pre2
            pre2 = pre1
            pre1 = tmp
        }
        
        return pre1
    }
}

let solu4 = Solution4()
let result4 = solu4.climbStairs(10)
print(result4)
