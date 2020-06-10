import UIKit

//面试题46. 把数字翻译成字符串
//给定一个数字，我们按照如下规则把它翻译为字符串：0 翻译成 “a” ，1 翻译成 “b”，……，11 翻译成 “l”，……，25 翻译成 “z”。一个数字可能有多个翻译。请编程实现一个函数，用来计算一个数字有多少种不同的翻译方法。
//
//示例 1:
//输入: 12258
//输出: 5
//解释: 12258有5种不同的翻译，分别是"bccfi", "bwfi", "bczi", "mcfi"和"mzi"
//
//提示：
//0 <= num < 231


// *************************** 解法一 *******************************//
/// 刚开始这道题也没思绪，后来想想，是不是这种组合问题 基本都是用回溯法呢？
/// 所以后来尝试用回溯法
/// 这里不要所有组合的字符串，而是要个数
class Solution {
    var totalCount: Int = 0
//    var ans: [String] = []
    var chars: [String] = Array.init(repeating: "", count: 26) // 字符翻译表
    func translateNum(_ num: Int) -> Int {
        // 1.初始化符号表
        for i in 0..<26 {
            if let scalar = Unicode.Scalar.init(97 + i) {
                chars[i] = String(Character.init(scalar))
            }
        }
        
        // 2.开始回溯个数
        trans(num, "")
        
        return totalCount
    }
    
    private func trans(_ num: Int, _ suffix: String) {
        if num == 0 {
            totalCount += 1
//            ans.append(suffix)
            return // 终止条件
        }
        
        // 1.最后一个字符
        let lastOne: Int = num%10
        trans(num/10, chars[lastOne]+suffix)
        
        // 2.最后两个字符 // 最后卡在这里了，因为有时候下面的计算可能和最后一个字符重复，所以需要判断
        let lastTwo: Int = num%100
        if lastTwo > 9 && lastTwo < 26 && lastTwo != lastOne {
            trans(num/100, chars[lastTwo]+suffix)
        }
    }
}
let solu = Solution()
let result = solu.translateNum(12312373)
print(result)


// ************************ 解法二 动态规划 ****************************//
/// 动态转移方程： f(i) = f(i-1) + f(i-2)  主要 f(i-2)如果要加的话 是有条件的，需要 当前一位和前一位是大于9且小于26
class Solution2 {
    var totalCount: Int = 0
    var chars: [String] = Array.init(repeating: "", count: 26) // 字符翻译表
    
    func translateNum(_ num: Int) -> Int {
        let srcStr: String = String(num)
        let srcArr: [Character] = srcStr.map { $0 }
        
        var f1 = 0
        var f2 = 0
        
        for (i, c) in srcArr.enumerated() {
            if i == 0 {
                f1 = 1
            } else {
                var twoValid: Bool = false
                let pre: String = String(srcArr[i-1])+String(c)
                if pre <= "25" && pre >= "10" {
                    twoValid = true
                }
                
                if i == 1 {
                    if twoValid {
                        f2 = 2
                    } else {
                        f2 = 1
                    }
                } else {
                    let fi = twoValid ? f2 + f1 : f2
                    f1 = f2
                    f2 = fi
                }
            }
        }
        
        return f2
    }
}
let solu2 = Solution2()
let result2 = solu2.translateNum(12312373)
print(result2)
