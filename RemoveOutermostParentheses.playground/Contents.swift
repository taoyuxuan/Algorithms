import UIKit
//
//1021. 删除最外层的括号
//有效括号字符串为空 ("")、"(" + A + ")" 或 A + B，其中 A 和 B 都是有效的括号字符串，+ 代表字符串的连接。例如，""，"()"，"(())()" 和 "(()(()))" 都是有效的括号字符串。
//如果有效字符串 S 非空，且不存在将其拆分为 S = A+B 的方法，我们称其为原语（primitive），其中 A 和 B 都是非空有效括号字符串。
//给出一个非空有效字符串 S，考虑将其进行原语化分解，使得：S = P_1 + P_2 + ... + P_k，其中 P_i 是有效括号字符串原语。
//对 S 进行原语化分解，删除分解中每个原语字符串的最外层括号，返回 S 。
//
//示例 1：
//输入："(()())(())"
//输出："()()()"
//解释：
//输入字符串为 "(()())(())"，原语化分解得到 "(()())" + "(())"，
//删除每个部分中的最外层括号后得到 "()()" + "()" = "()()()"。
//
//示例 2：
//输入："(()())(())(()(()))"
//输出："()()()()(())"
//解释：
//输入字符串为 "(()())(())(()(()))"，原语化分解得到 "(()())" + "(())" + "(()(()))"，
//删除每个部分中的最外层括号后得到 "()()" + "()" + "()(())" = "()()()()(())"。
//
//示例 3：
//输入："()()"
//输出：""
//解释：
//输入字符串为 "()()"，原语化分解得到 "()" + "()"，
//删除每个部分中的最外层括号后得到 "" + "" = ""。
//提示：
//S.length <= 10000
//S[i] 为 "(" 或 ")"
//S 是一个有效括号字符串


// *************************** 解法一 自己的栈方法 **************************** //
/// 哎，这个题是简单的，我又花了一下午的时间，就想按自己的逻辑写出来！！！
/// 我傻！
/// 本题最关键的是要读清题干！！！！ 我刚开始就是没读懂题干，就开始瞎写了！！
/// 这个题，只要求你删除最外层的括号，其余的内部有多少括号 不用管，但是如何判断！不要陷入误区！！
/// 主要的逻辑就是遇到右括号进行处理：如果stack只剩一个左括号的时候，直接推出，如果不是，那就用一个循环去判断左右括号的数量是否对等，如果对等，就退出来，截取子串，如果不对等，那就添加元素

class Solution {
    func removeOuterParentheses(_ S: String) -> String {
        var strs: String = ""
        var stack: [Character] = []
        
        for c in S {
            if c == ")" {
                if stack.count == 1 && stack[0] == "(" {
                    stack.removeLast()
                } else {
                    var j: Int = stack.count - 1
                    var leftCnt: Int = 0
                    var rightCnt: Int = 1
                    var currentStr: String = ")"
                    while j > 0 {
                        if stack[j] == "(" {
                            leftCnt += 1
                        } else if stack[j] == ")" {
                            rightCnt += 1
                        }
                        currentStr = String(stack[j]) + currentStr
                        j -= 1
                    }
                    
                    if leftCnt == rightCnt {
                        strs += currentStr
                        stack.removeLast(stack.count-1)
                    } else {
                        stack.append(c)
                    }
                }
            } else {
                stack.append(c)
            }
        }
        return strs
    }
}
let solu = Solution()
let result = solu.removeOuterParentheses("(()())(())(()(()))")
print(result)


// *************************** 解法二 法一的优化，去掉栈的使用 **************************** //
/// 方法一的优化  不用栈，而是用一个循环记录合格的字符串
class Solution2 {
    func removeOuterParentheses(_ S: String) -> String {
        var strs: String = ""
        var currentStr: String = ""
        var leftCnt: Int = 0
        var rightCnt: Int = 0
        for c in S {
            if c == "(" {
                if leftCnt > 0 {
                    currentStr += String(c)
                }
                leftCnt += 1
            } else if c == ")" {
                rightCnt += 1
                currentStr += String(c)
                
                if leftCnt == rightCnt {
                    currentStr = ""
                    leftCnt = 0
                    rightCnt = 0
                } else if leftCnt - rightCnt == 1 {
                    // 子串结束了
                    strs += currentStr
                    currentStr = ""
                    leftCnt = 1
                    rightCnt = 0
                }
            } else {
                currentStr += String(c)
            }
        }
        return strs
    }
}
let solu2 = Solution2()
let result2 = solu2.removeOuterParentheses("(()())(())(()(()))")
print(result2)

// *************************** 解法三 **************************** //
/// 借鉴别人的代码
/// 使用层级判断，如果层级为0，说明是最外层，如果不是最外层，那么就留下当前字符，也是遍历O(n)的时间
/// 人家的这个办法很巧妙！！
class Solution3 {
    func removeOuterParentheses(_ S: String) -> String {
        var strs: String = ""
        var level: Int = 0
        for c in S {
            if c == ")" {
                level -= 1
            }
            if level > 0 {
                // 说明已经有最外层了，需要用留下当前字符串
                strs += String(c)
            }
            if c == "(" {
                level += 1
            }
        }
        return strs
    }
}
let solu3 = Solution3()
let result3 = solu3.removeOuterParentheses("(()())(())(()(()))")
print(result3)
