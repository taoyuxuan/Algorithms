import UIKit

//912. 排序数组
//给你一个整数数组 nums，请你将该数组升序排列。
//
//示例 1：
//输入：nums = [5,2,3,1]
//输出：[1,2,3,5]
//示例 2：
//
//输入：nums = [5,1,1,2,0,0]
//输出：[0,0,1,1,2,5]
//
//提示：
//1 <= nums.length <= 50000
//-50000 <= nums[i] <= 50000
// https://leetcode-cn.com/problems/sort-an-array/


// ************************ 复习基础排序算法 ***************************//
/// 所有简单排序都是稳定排序
/// 简单排序的时间复杂度都是O(n^2)

// ************************ 1.选择排序 ***************************//
/// 原地排序算法 对于c++它不需要重新开辟空间，由于swift传递的数组是不可修改的，
/// 所以需要开辟一块可变的空间；理论上选择排序是原地排序算法；
/// 时间复杂度 O(n^2)；空间复杂度：O(1)
/// 稳定排序
class Solution {
    func sortArray(_ nums: [Int]) -> [Int] {
        let count: Int = nums.count
        var result:[Int] = nums
        for i in 0..<count {
            var minIdx: Int = i
            var minValue: Int = result[i]
            for j in i+1..<count {
                if result[j] < minValue {
                    minIdx = j
                    minValue = result[j]
                }
            }
            if i != minIdx {
                result[minIdx] = result[i]
                result[i] = minValue
            }
        }
        return result
    }
}

let solu = Solution()
let result = solu.sortArray([5,1,1,2,0,0])
print("选择排序：\(result)")

// ************************ 2.冒泡排序 ***************************//
/// 原地排序算法
/// 时间复杂度：O(n^2)；空间复杂度：O(1)
/// 稳定排序算法
class Solution2 {
    
    func sortArray(_ nums: [Int]) -> [Int] {
        var sources: [Int] = nums
        let count: Int = nums.count
        for i in 0..<(count-1) {
            var pre: Int = 0
            for j in 1..<(count-i) {
                if sources[j] < sources[pre] {
                    let prev = sources[pre]
                    sources[pre] = sources[j]
                    sources[j] = prev
                }
                pre = j
            }
        }
        return sources
    }
}

let solu2 = Solution2()
let result2 = solu2.sortArray([5,1,1,2,0,0])
print("冒泡排序：\(result2)")

// ************************ 3.插入排序 ***************************//
/// 原地排序
/// 时间复杂度：O(n^2)；空间复杂度：O(1)
/// 稳定排序
class Solution3 {
    func sortArray(_ nums: [Int]) -> [Int] {
        var sources: [Int] = nums
        let count = nums.count
        for i in 0..<count {
            let curVal = sources[i]
            var preIdx: Int = i
            var j: Int = i-1
            while j >= 0 {
                if sources[j] > curVal {
                    sources[preIdx] = sources[j]
                    sources[j] = curVal
                    preIdx = j
                } else {
                    break;
                }
                j -= 1
            }
        }
        return sources
    }
}

let solu3 = Solution3()
let result3 = solu3.sortArray([5,1,1,2,0,0])
print("插入排序：\(result3)")

// ************************ 4.希尔排序 ***************************//
/// 由于希尔排序尚未求的一个最好的增量序列，所以暂且先这样，等刷第二遍的时候再补上。
class Solution4 {
    
    func sortArray(_ nums: [Int]) -> [Int] {
        
        return []
    }
}


// ************************ 5.快速排序 ***************************//
/// 原地排序
/// 时间复杂度：O(nlogn)；空间复杂度为递归调用的深度: O(logn)
/// 非稳定排序
class Solution5 {
    
    var sources:[Int] = []
    
    func sortArray(_ nums: [Int]) -> [Int] {
        sources = nums
        quickSort(0, nums.count-1)
        return sources
    }
    
    func quickSort(_ low: Int, _ high: Int) {
        if low >= high {
            return
        }
        
        let midIdx = partion(low, high)
        quickSort(low, midIdx-1)
        quickSort(midIdx+1, high)
    }
    
    func partion(_ low: Int, _ high: Int) -> Int {
        let tmp: Int = sources[low]
        var l: Int = low
        var h: Int = high
        while l < h {
            while l < h && sources[h] >= tmp {
                h -= 1
            }
            sources[l] = sources[h]
            while l < h && sources[l] <= tmp {
                l += 1
            }
            sources[h] = sources[l]
        }
        sources[l] = tmp
        return l
    }
}

let solu5 = Solution5()
let result5 = solu5.sortArray([5,1,1,2,0,0])
print("快速排序：\(result5)")


// ************************ 6.堆排序 ***************************//
/// 原地排序
/// 时间复杂度：O(nlogn)；空间复杂度：O(1)
/// 非稳定排序
class Solution6 {
    var sources: [Int] = []
    func sortArray(_ nums: [Int]) -> [Int] {
        sources = nums
        let count = nums.count
        // 创建大顶堆
        var i = count/2
        while i >= 0 {
            heapify(i, count)
            i -= 1
        }
        
        // 取出堆顶元素进行排序
        var j = count - 1
        while j > 0 {
            let tmp = sources[j]
            sources[j] = sources[0]
            sources[0] = tmp
            heapify(0, j)
            j -= 1
        }
        
        return sources
    }
    
    func heapify(_ i: Int, _ len: Int) {
        var idx: Int = i
        while 2*(idx+1)-1 < len {
            let lIdx: Int = 2*(idx+1) - 1
            let rIdx: Int = 2*(idx+1)
            var largeIdx: Int = lIdx
            // 判断左右孩子，哪个结点比较大
            if rIdx < len && sources[rIdx] > sources[lIdx] {
                largeIdx = rIdx
            }
            
            // 父亲结点和孩子结点中教大的那个比较，如果父亲结点小，那需要交换
            if sources[largeIdx] > sources[idx] {
                let tmp = sources[idx]
                sources[idx] = sources[largeIdx]
                sources[largeIdx] = tmp
            }
            idx = largeIdx
        }
    }
}
let solu6 = Solution6()
let result6 = solu6.sortArray([5,1,1,2,0,0])
print("堆排序：\(result6)")

// ************************ 7.归并排序 ***************************//
/// 非原地排序，利用了辅助内存，辅助内存是 O(n)
/// 时间复杂度：O(nlogn)；空间复杂度: O(n)
/// 稳定排序
class Solution7 {
    var sources: [Int] = []
    func sortArray(_ nums: [Int]) -> [Int] {
        sources = nums
        mergeSort(0, nums.count-1)
        return sources
    }
    
    func mergeSort(_ low: Int, _ high: Int) {
        if low >= high {
            return
        }
        let mid: Int = (low + high)/2
        mergeSort(low, mid)
        mergeSort(mid+1, high)
        mergeTwoSub(low, mid, high)
    }
    
    func mergeTwoSub(_ low: Int, _ mid: Int, _ high: Int) {
        var tmpArr: [Int] = []
        var p1: Int = low
        var p2: Int = mid + 1
        while p1 <= mid && p2 <= high {
            if sources[p1] <= sources[p2] {
                tmpArr.append(sources[p1])
                p1 += 1
            } else {
                tmpArr.append(sources[p2])
                p2 += 1
            }
        }
        
        while p1 <= mid {
            tmpArr.append(sources[p1])
            p1 += 1
        }
        
        while p2 <= high {
            tmpArr.append(sources[p2])
            p2 += 1
        }
        
        for i in 0...(high-low) {
            sources[low + i] = tmpArr[i]
        }
    }
}

let solu7 = Solution7()
let result7 = solu7.sortArray([5,1,1,2,0,0])
print("归并排序：\(result7)")
