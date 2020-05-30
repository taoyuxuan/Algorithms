import UIKit

//84. 柱状图中最大的矩形
//给定 n 个非负整数，用来表示柱状图中各个柱子的高度。每个柱子彼此相邻，且宽度为 1 。
//
//求在该柱状图中，能够勾勒出来的矩形的最大面积。
//
//以上是柱状图的示例，其中每个柱子的宽度为 1，给定的高度为 [2,1,5,6,2,3]。
//
//图中阴影部分为所能勾勒出的最大矩形面积，其面积为 10 个单位。
//示例:
//输入: [2,1,5,6,2,3]
//输出: 10


// ******************************** 解法一 单调栈 ******************************** //
/// 官方解法； 虽然右侧最小数组赋值还没太懂，其他的能看明白
class Solution {
    func largestRectangleArea(_ heights: [Int]) -> Int {
        let count = heights.count
        if count == 0 {
            return 0
        }

        var leftLeast: [Int] = Array.init(repeating: -1, count: count)
        var rightLeast: [Int] = Array.init(repeating: count, count: count)
        
        var stack: [Int] = [] // 维护单调栈
        for i in 0..<count {
            while !stack.isEmpty && heights[stack.last!] >= heights[i] {
                rightLeast[stack.last!] = i
                stack.removeLast()
            }

            leftLeast[i] = stack.last ?? -1
            stack.append(i)
        }
        
        //由于在逻辑上需要把栈内剩余的数据出栈，出栈后，右方向的最小值都是 count，而我们在初始化时就将每个元素的右边界设置成count，所以无须做出栈修改了
        
        var maxArea: Int = 0
        // 遍历一遍高度
        for i in 0..<count {
            let l: Int = leftLeast[i]
            let r: Int = rightLeast[i]
            let current = heights[i] * (r-1-l)
            
            maxArea = max(current, maxArea)
        }
        
        return maxArea
    }
}

let solu = Solution()
//let result = solu.largestRectangleArea([2,1,5,6,2,3])
let result = solu.largestRectangleArea([6,7,5,2,4,5,9,3])
print(result)


// ******************************** 解法二 单调栈 ******************************** //
/// 自己根据官方思想做的一种逻辑; 主要思想还是先补充左右的最小值
class Solution2 {
    /// 1.暴力解法，双层循环，对比面积
    /// 2.单个元素，左右扩散查找小于当前结点的； 算不算贪心算法？
    func largestRectangleArea(_ heights: [Int]) -> Int {
        let count: Int = heights.count
        if count == 0 {
            return 0
        }
        if count == 1 {
            return heights[0]
        }
        var maxArea: Int = 0
        var leftLeast: [Int] = Array(repeating: -1, count: count)
        var rightLeast: [Int] = Array(repeating: count, count: count)

        for i in 0..<count {
            var l: Int = i - 1
            while l >= 0 && heights[l] >= heights[i] {
                if heights[l] == heights[i] {
                    l = leftLeast[l]
                    break
                } else {
                    l = leftLeast[l]
                }
            }
            leftLeast[i] = l

            let idx: Int = count-1-i
            var r: Int = idx + 1
            while r < count && heights[r] >= heights[idx] {
                if heights[r] == heights[idx] {
                    r = rightLeast[r]
                    break
                } else {
                    r = rightLeast[r]
                }
            }
            rightLeast[idx] = r
        }

        for i in 0..<count {
            let ch: Int = heights[i]
            let l: Int = leftLeast[i]
            let r: Int = rightLeast[i]
            let currentArea: Int = ch * (r - 1 - l)
            maxArea = max(maxArea, currentArea)
        }

        return maxArea
    }
}
let solu2 = Solution2()
//let result = solu.largestRectangleArea([2,1,5,6,2,3])
let result2 = solu2.largestRectangleArea([6,7,5,2,4,5,9,3])
print(result2)

