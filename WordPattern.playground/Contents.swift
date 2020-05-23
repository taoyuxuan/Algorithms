import UIKit

//290. 单词规律
//给定一种规律 pattern 和一个字符串 str ，判断 str 是否遵循相同的规律。
//这里的 遵循 指完全匹配，例如， pattern 里的每个字母和字符串 str中的每个非空单词之间存在着双向连接的对应规律。
//
//示例1:
//输入: pattern = "abba", str = "dog cat cat dog"
//输出: true
//
//示例 2:
//输入:pattern = "abba", str = "dog cat cat fish"
//输出: false
//
//示例 3:
//输入: pattern = "aaaa", str = "dog cat cat dog"
//输出: false
//
//示例 4:
//输入: pattern = "abba", str = "dog dog dog dog"
//输出: false

// ****************************  解法一 *******************************//
/// 这里有问题哈～
/// 一个hash map中 一个key只能对应一个value；但是无法保证多个key对应同一个value；
/// 也就是说单一一个haspmap O(1)复杂度无法判断出到底有没有多个key对应的是同一个value
/// 而题中要求的 不管是一个pattern对应多个word 或者多个pattern对应一个word；这两者情况都是false
/// 所以只能搞两个hash map进行存储，确保快速查找；
class Solution {
    func wordPattern(_ pattern: String, _ str: String) -> Bool {
        let words: [Substring] = str.split(separator: Character(" "))
        let patternChars: [Character] = pattern.map { $0 }
        let wcnt: Int = words.count
        let pcnt: Int = patternChars.count
        if wcnt != pcnt {
            return false
        }
        
        var mapc: [Substring: Character] = [:]
        var mapw: [Character: Substring] = [:]
        
        for (i, substr) in words.enumerated() {
            let pchar: Character = patternChars[i]
            if let tmpc = mapc[substr], tmpc != pchar {
                return false
            } else if let tmpw = mapw[pchar], tmpw != substr {
                return false
            } else {
                mapc[substr] = pchar
                mapw[pchar] = substr
            }
        }
        
        return true
    }
}

let solu = Solution()
let result = solu.wordPattern("aaaa", "dog cat cat dog")
print(result)
