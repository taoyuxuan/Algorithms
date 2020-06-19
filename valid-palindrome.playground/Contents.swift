import UIKit

//125. 验证回文串
//给定一个字符串，验证它是否是回文串，只考虑字母和数字字符，可以忽略字母的大小写。
//说明：本题中，我们将空字符串定义为有效的回文串。
//
//示例 1:
//输入: "A man, a plan, a canal: Panama"
//输出: true
//
//示例 2:
//输入: "race a car"
//输出: false


class Solution {
    func isPalindrome(_ s: String) -> Bool {
        let lowercasestr: String = s.lowercased()
        let srcchars: [Character] = lowercasestr.map { $0 }
        var l: Int = 0
        var r: Int = srcchars.count - 1
        while l <= r {
            var lvalid: Bool = false
            var rvalid: Bool = false
            if srcchars[l] >= "a" && srcchars[l] <= "z" || (srcchars[l] >= "0" && srcchars[l] <= "9") {
                lvalid = true
            }
            if srcchars[r] >= "a" && srcchars[r] <= "z" || (srcchars[r] >= "0" && srcchars[r] <= "9") {
                rvalid = true
            }
            if lvalid && rvalid {
                if srcchars[l] == srcchars[r] {
                    l += 1
                    r -= 1
                } else {
                    return false
                }
            } else if lvalid {
                r -= 1
            } else if rvalid {
                l += 1
            } else {
                l += 1
                r -= 1
            }
        }
        
        return true
    }
}
let solu = Solution()
let result = solu.isPalindrome("race a car")
print(result)
