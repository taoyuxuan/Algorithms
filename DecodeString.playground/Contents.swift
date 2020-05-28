import UIKit

//394. 字符串解码
//给定一个经过编码的字符串，返回它解码后的字符串。
//编码规则为: k[encoded_string]，表示其中方括号内部的 encoded_string 正好重复 k 次。注意 k 保证为正整数。
//你可以认为输入字符串总是有效的；输入字符串中没有额外的空格，且输入的方括号总是符合格式要求的。
//此外，你可以认为原始数据不包含数字，所有的数字只表示重复的次数 k ，例如不会出现像 3a 或 2[4] 的输入。
//
//示例:
//s = "3[a]2[bc]", 返回 "aaabcbc".
//s = "3[a2[c]]", 返回 "accaccacc".
//s = "2[abc]3[cd]ef", 返回 "abcabccdcdcdef".


// ********************** 解法一 辅助栈 *************************//
/// 时间复杂度 O(n*h) n是字符串个数 h是一个字符串平均长度
/// 空间复杂度 也就是栈的长度 O(h)
class Solution {
    func decodeString(_ s: String) -> String {
        var result: String = ""
        var stack: [String] = []
        for c in s {
            if c == Character("]") {
                // 开始出栈 并解析
                var time: Int = 0
                var move: Int = 1
                var substr: String = ""
                var decoding = true
                while !stack.isEmpty, let top = stack.last {
                    if top == "[" {
                        if decoding == false {
                            break
                        }
                        decoding = false
                        stack.removeLast()
                    } else if top.count == 1, let onechar = top.first, onechar.isNumber {
                        if let val = onechar.wholeNumberValue {
                            time += (move * val)
                        }
                        move *= 10
                        stack.removeLast()
                    } else {
                        if !decoding {
                            break;
                        }
                        substr = top + substr
                        stack.removeLast()
                    }
                }
                
                if stack.isEmpty {
                    result += String(repeating: substr, count: time)
                } else {
                    stack.append(String(repeating: substr, count: time))
                }
            } else {
                if stack.isEmpty && c != "[" && !c.isNumber {
                    result += String(c)
                } else {
                    stack.append(String(c))
                }
            }
        }
        
        return result
    }
}

let solu = Solution()
let result = solu.decodeString("3[z]2[2[y]pq4[2[jk]e1[f]]]ef")
print(result)
