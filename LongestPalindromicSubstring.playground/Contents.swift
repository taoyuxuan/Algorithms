import UIKit

//5. 最长回文子串
//给定一个字符串 s，找到 s 中最长的回文子串。你可以假设 s 的最大长度为 1000。
//
//示例 1：
//输入: "babad"
//输出: "bab"
//注意: "aba" 也是一个有效答案。
//
//示例 2：
//输入: "cbbd"
//输出: "bb"


// *********************************** 解法一 动态规划 *******************************//
/// 我能说我又没做出来吗？？？只能看答案
/// 这个方案的思路是建立一个邻接矩阵来存储每个区域的的子串是否为回文串
/// 从长度为0的子串开始，从左向右遍历，并记录标志，而且进行比较当前最大子串的长度
/// 时间复杂度: O(n^2)；空间复杂度: O(n^2)

class Solution {
    func longestPalindrome(_ s: String) -> String {
        let count = s.count
        var dp: [[Int]] = Array.init(repeating: Array.init(repeating: 0, count: count), count: count)
        
        let startIndex = s.startIndex
        var resultStr = ""
        for len in 0..<count {
            var i = 0
            while i+len < count {
                let j = i + len
                if len == 0 {
                    dp[i][j] = 1;
                } else {
                    let iidx = s.index(startIndex, offsetBy: i)
                    let jidx = s.index(startIndex, offsetBy: j)
                    
                    if len == 1 {
                        dp[i][j] = (s[iidx] == s[jidx]) ? 1 : 0
                    } else {
                        dp[i][j] = ((s[iidx] == s[jidx]) && dp[i+1][j-1] == 1) ? 1: 0
                    }
                    
                    if dp[i][j] == 1 && (len + 1) > resultStr.count{
                        resultStr = String(s[iidx...jidx])
                    }
                }
                
                i = i + 1
            }
        }
        
        return resultStr
    }
}
let solu = Solution()
let result = solu.longestPalindrome("babad")
print(result)


// *********************************** 解法二 中心扩展法 *******************************//
/// 从每一位字符开始，进行向外扩展，扩展到的最大的字符串进行记录
/// 时间复杂度: O(n^2)；空间复杂度: O(1)

class Solution2 {
    
    func longestPalindrome(_ s: String) -> String {
        let count = s.count
        let chars: [Character] = s.map { $0 }
        var start: Int = 0
        var end: Int = 0
        for i in 0..<count {
            let len1 = expand(chars, i, i)
            let len2 = expand(chars, i, i+1)
            let maxLen = max(len1, len2)
            if maxLen > (end - start) {
                start = i - (maxLen - 1)/2
                end = i + maxLen/2
            }
        }
        let sidx = s.index(s.startIndex, offsetBy: start)
        let eidx = s.index(s.startIndex, offsetBy: end)
        return String(s[sidx...eidx])
    }
    
    func expand(_ chars: [Character], _ left: Int, _ right: Int) -> Int {
        let count = chars.count
        var l = left
        var r = right
        while r < count && l >= 0 {
            if chars[l] != chars[r] {
                // 如果相等 就认为是回文串，继续匹配，不是就退出
                break
            }
            l -= 1
            r += 1
        }
        
        return r-l-1
    }
}
let solu2 = Solution2()
let result2 = solu2.longestPalindrome("babad")
print(result2)


// *********************************** 解法三 Manacher 算法 *******************************//
/// 这个方法就不太懂了。。。 很复杂 抄了一遍。
/// 时间复杂度: O(n)；空间复杂度: O(n)

class Solution3 {
    func longestPalindrome(_ s: String) -> String {
        let chars: [Character] = s.map { $0 }
        var newchars: [Character] = [Character("^")]
        chars.forEach { c in
            newchars.append(Character("#"))
            newchars.append(c)
        }
        newchars.append(Character("#"))
        newchars.append(Character("$"))
        
        let newcount: Int = newchars.count
        var p: [Int] = Array.init(repeating: 0, count: newcount)
        var C: Int = 0
        var R: Int = 0
        for i in 1..<newcount-1 {
            let i_mirror = 2 * C - i
            if R > i {
                p[i] = min(R-i, p[i_mirror]) // 防止超出R
            } else {
                p[i] = 0 // 等于R的情况
            }
            
            while newchars[i+1+p[i]] == newchars[i-1-p[i]] {
                p[i] += 1
            }
            
            // 判断是否需要更新R
            if i + p[i] > R {
                C = i
                R = i + p[i]
            }
        }
        
        var maxLen = 0
        var centerIndex = 0
        for i in 1..<newcount-1 {
            if p[i] > maxLen {
                maxLen = p[i]
                centerIndex = i
            }
        }
        
        let start = (centerIndex - maxLen)/2 // 最开始讲的求原字符串下标
        let end = start + maxLen
        let sidx = s.index(s.startIndex, offsetBy: start)
        let eidx = s.index(s.startIndex, offsetBy: end)
        return String(s[sidx..<eidx])
    }
}

let solu3 = Solution3()
let result3 = solu3.longestPalindrome("babad")
print(result3)


// *********************************** 解法四 自己的暴力解法 *******************************//
/// 当然这种方案是不对的;不推荐 但是是作为优化的第一步基础
/// 时间复杂度: O(n^3)；空间复杂度: O(1)
class Solution4 {
    func longestPalindrome(_ s: String) -> String {
        //1.暴力解法
        //2.优化解法 -

        let count = s.count
        var maxString = ""
        let chars: [Character] = s.map { $0 }
        
        for i in 0..<count {
            var currentStr = ""
            if maxString.count > (count-1-i) {
                break;
            }
            for j in i..<count {
                let c = chars[j]
                currentStr.append(c)
                if isValid(currentStr), currentStr.count > maxString.count {
                    maxString = currentStr
                }
            }
        }
        
        return maxString
    }

    func isValid(_ subStr: String) -> Bool {
        let count = subStr.count
        let chars: [Character] = subStr.map { $0 }
        var l = 0
        var r = count-1
        while l < r {
            if chars[l] != chars[r] {
                return false
            }
            l += 1
            r -= 1
        }
        return true
    }
}
