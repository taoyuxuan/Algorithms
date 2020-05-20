import UIKit

//1371. 每个元音包含偶数次的最长子字符串
//给你一个字符串 s ，请你返回满足以下条件的最长子字符串的长度：每个元音字母，即 'a'，'e'，'i'，'o'，'u' ，在子字符串中都恰好出现了偶数次。
//
//
//示例 1：
//输入：s = "eleetminicoworoep"
//输出：13
//解释：最长子字符串是 "leetminicowor" ，它包含 e，i，o 各 2 个，以及 0 个 a，u 。
//
//示例 2：
//输入：s = "leetcodeisgreat"
//输出：5
//解释：最长子字符串是 "leetc" ，其中包含 2 个 e 。
//
//示例 3：
//输入：s = "bcbcbc"
//输出：6
//解释：这个示例中，字符串 "bcbcbc" 本身就是最长的，因为所有的元音 a，e，i，o，u 都出现了 0 次。
//
//提示：
//1 <= s.length <= 5 x 10^5
//s 只包含小写英文字母。

// ******************************* 解法一 官方解法 前缀和+哈希 **********************************//
/// 啊！不会做！只能看答案！
/// 利用前缀和的思想 
class Solution {
    func findTheLongestSubstring(_ s: String) -> Int {
        var resultLen: Int = 0
        var pos:[Int: Int] = [0:0]
        var status: Int = 0
        let chars: [Character: Int] = [Character("a"):0, Character("e"):1, Character("i"):2, Character("o"):3, Character("u"):4]
        
        var i=0
        s.forEach { c in
            if let inLoc = chars[c] {
                status ^= 1<<inLoc
            }
            if let loc = pos[status] {
                resultLen = max(resultLen, i+1-loc)
            } else {
                pos[status] = i+1
            }
            i += 1
        }
        
        return resultLen
    }
}
let solu = Solution()
let result = solu.findTheLongestSubstring("leetcodeisgreat")
print(result)
