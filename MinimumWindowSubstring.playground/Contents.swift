import UIKit

//76. 最小覆盖子串
//给你一个字符串 S、一个字符串 T，请在字符串 S 里面找出：包含 T 所有字符的最小子串。
//
//示例：
//输入: S = "ADOBECODEBANC", T = "ABC"
//输出: "BANC"
//说明：
//如果 S 中不存这样的子串，则返回空字符串 ""。
//如果 S 中存在这样的子串，我们保证它是唯一的答案。

// *************************** 解法 滑动窗口 ************************ //
/// 这个是真的不会啊。。。只能抄答案

class Solution {
    
    var orgin: [Character: Int] = [:]
    var cnt: [Character: Int] = [:]
    
    func minWindow(_ s: String, _ t: String) -> String {
        let tcount: Int = t.count
        let subChars: [Character] = t.map { $0 }
        subChars.forEach { c in
            if let tmpCnt = orgin[c] {
                orgin[c] = tmpCnt
            } else {
                orgin[c] = 1
            }
        }

        var l: Int = 0
        var ansL = -1
        var minLen: Int = Int.max
        
        let chars: [Character] = s.map { $0 }
        
        for (r, c) in chars.enumerated() {
            if let _ = orgin[c] {
                if let tmpcnt = cnt[c] {
                    cnt[c] = tmpcnt + 1
                } else {
                    cnt[c] = 1
                }
            }

            if r-l + 1 < tcount {
                continue
            }
            
            while check() && l <= r {
                if r-l+1 < minLen {
                    minLen = r-l+1
                    ansL = l
                }
                if let _ = orgin[chars[l]] {
                    if let tmpcnt = cnt[chars[l]] {
                        cnt[chars[l]] = tmpcnt - 1
                    }
                }
                l += 1
            }
        }
        
        if ansL == -1 {
            return ""
        }
        
        let sidx = s.index(s.startIndex, offsetBy: ansL)
        let eidx = s.index(s.startIndex, offsetBy: ansL+minLen)
        
        return String(s[sidx..<eidx])
    }
    
    func check() ->Bool {
        for item in orgin {
            if let count = cnt[item.key] {
                if count < item.value {
                    return false
                }
            } else { return false }
        }
        return true
    }
}

let solu = Solution()
let result = solu.minWindow("ADOBECODEBANC", "ABC")
print(result)
