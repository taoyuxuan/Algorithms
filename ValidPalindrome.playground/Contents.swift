import UIKit
//
//680. 验证回文字符串 Ⅱ
//给定一个非空字符串 s，最多删除一个字符。判断是否能成为回文字符串。
//
//示例 1:
//输入: "aba"
//输出: True
//
//示例 2:
//输入: "abca"
//输出: True
//解释: 你可以删除c字符。
//
//注意:
//字符串只包含从 a-z 的小写字母。字符串的最大长度是50000。


//*********************************** 解法一 官方解法 *******************************//
/// 这道题我自己没想出来，想了好半天，不小心又陷入了死磕模式，该死！！！
/// 最烦的就是这种字符串操作，又包含字符操作的了，没有直接操作字符的接口，要么用string.index，刚开始就用的这种，导致运行超时，之前一次也是，因为操作string.index 各种复杂，各种麻烦，还是对string的实现不太了解的原因！！
/// 现在改成map出一个字符数组，比操作String.index快多了！！！ 经验教训！
/// 再说说思路： 和正常的判断回文差不多，双指针法，前后对比。这道题目要求可以删除一个字符，然后判读剩余的能否组成回文，可以的话返回true，这个解法的思路是遇到不一样的字符的时候，删除前面的一个循环尝试对比，然后删除后面的一个循环尝试对比，只要有一个能称为回文，那就返回true；
class Solution {
    func validPalindrome(_ s: String) -> Bool {
        let source: [Character] = s.map { $0 }
        let count: Int = s.count
        
        var lower: Int = 0
        var upper: Int = count - 1
        
        while lower < upper {
            if source[lower] != source[upper] {
                var flag1: Bool = true
                var flag2: Bool = true
                
                var nlower: Int = lower+1
                var nupper: Int = upper
                while nlower < nupper {
                    if source[nlower] != source[nupper] {
                        flag1 = false
                        break
                    }
                    nlower += 1
                    nupper -= 1
                }
                
                nlower = lower
                nupper = upper-1
                while nlower < nupper {
                    if source[nlower] != source[nupper] {
                        flag2 = false
                        break
                    }
                    nlower += 1
                    nupper -= 1
                }
                
                if flag1 || flag2 {
                    return true;
                } else {
                    return false;
                }
            } else {
                lower += 1
                upper -= 1
            }
        }
        
        return true
    }
}

let solu = Solution()
let result = solu.validPalindrome("abcdedtcba")
print(result)


//*********************************** 解法二 简洁解法 *******************************//
/// 与题解一思路一样，只不过代码更简洁了些。
class Solution2 {
    
    var source: [Character] = []
    func validPalindrome(_ s: String) -> Bool {
        self.source = s.map { $0 }
        let count: Int = s.count
        
        var i = 0
        var j = count-1
        while i<j && source[i] == source[j] {
            i+=1
            j-=1
        }
        
        if i>=j {
            return true
        }
        
        return isValidStrictPalindrome(i+1, j) || isValidStrictPalindrome(i, j-1)
    }
    
    private func isValidStrictPalindrome(_ lower: Int, _ upper: Int) -> Bool {
        var i = lower
        var j = upper
        while i < j && source[i] == source[j] {
            i += 1
            j -= 1
        }
        return i>=j
    }
    
}

let solu2 = Solution2()
let result2 = solu.validPalindrome("abcdedtcba")
print(result2)



//*********************************** 解法三 递归 *******************************//
class Solution3 {
    
    var source: [Character] = []
    func validPalindrome(_ s: String) -> Bool {
        self.source = s.map { $0 }
        let count: Int = s.count
        
        return isValid(0, count-1, 1)
    }
    
    func isValid(_ lower: Int, _ upper: Int, _ deleteCount: Int) -> Bool {
        // 终止条件
        if lower >= upper {
            return true
        }
        if source[lower] == source[upper] {
            return isValid(lower+1, upper-1, deleteCount)
        } else if deleteCount > 0 {
            return isValid(lower+1, upper, deleteCount-1) || isValid(lower, upper-1, deleteCount-1)
        } else {
            return false
        }
    }
}

let solu3 = Solution3()
let result3 = solu.validPalindrome("abcdedtba")
print(result3)

