import UIKit

//990. 等式方程的可满足性
//给定一个由表示变量之间关系的字符串方程组成的数组，每个字符串方程 equations[i] 的长度为 4，并采用两种不同的形式之一："a==b" 或 "a!=b"。在这里，a 和 b 是小写字母（不一定不同），表示单字母变量名。
//
//只有当可以将整数分配给变量名，以便满足所有给定的方程时才返回 true，否则返回 false。
//
//示例 1：
//输入：["a==b","b!=a"]
//输出：false
//解释：如果我们指定，a = 1 且 b = 1，那么可以满足第一个方程，但无法满足第二个方程。没有办法分配变量同时满足这两个方程。
//
//示例 2：
//输出：["b==a","a==b"]
//输入：true
//解释：我们可以指定 a = 1 且 b = 1 以满足满足这两个方程。
//
//示例 3：
//输入：["a==b","b==c","a==c"]
//输出：true
//
//示例 4：
//输入：["a==b","b!=c","c==a"]
//输出：false
//
//示例 5：
//输入：["c==c","b==d","x!=z"]
//输出：true
//
//提示：
//1 <= equations.length <= 500
//equations[i].length == 4
//equations[i][0] 和 equations[i][3] 是小写字母
//equations[i][1] 要么是 '='，要么是 '!'
//equations[i][2] 是 '='

// ************************ 解法一 ************************** //
/// 并查集是一个树形结构，严格说可能有多棵树
/// parent里的每个元素，指向和它相连的一个结点，该结点可能有下一个结点，也可能指向它自己，指向自己的结点是根结点，有几个元素可能指向同一个根结点，这便是一棵树。先通过方程式构造一遍树形结构，然后再通过不等式进行搜索，是否符合条件。
class Solution {
    // 并查集
    var parent: [Int] = Array(repeating: 0, count: 26)
    func equationsPossible(_ equations: [String]) -> Bool {
        
        //1.初始化
        for i in 0..<26 {
            parent[i] = i
        }
        
        //2.遍历方程组，构造并查集
        for str in equations {
            let chars: [Character] = str.map { $0 }
            if chars[1] == Character("=") {
                // 等式
                if let startIdx = Character("a").asciiValue, let idx1 = chars[0].asciiValue, let idx2 = chars[3].asciiValue {
                    unite(Int(idx1-startIdx), Int(idx2-startIdx))
                }
            }
        }
        
        //3.遍历方程组，查找非矛盾方程
        for str in equations {
            let chars: [Character] = str.map { $0 }
            if chars[1] == Character("!") {
                // 不等式
                if let startIdx = Character("a").asciiValue, let idx1 = chars[0].asciiValue, let idx2 = chars[3].asciiValue {
                    let parent1 = find(Int(idx1 - startIdx))
                    let parent2 = find(Int(idx2 - startIdx))
                    if parent1 == parent2 {
                        return false
                    }
                }
            }
        }
        
        return true
    }
    
    func find(_ index: Int) -> Int {
        if index == parent[index] {
            return index
        }
        
        parent[index] = find(parent[index])
        return parent[index]
    }
    
    func unite(_ index1: Int, _ index2: Int) {
        let findIdx1: Int = find(index1)
        let findIdx2: Int = find(index2)
        parent[findIdx1] = findIdx2
    }
}
let solu = Solution()
let result = solu.equationsPossible(["a==b","b==d","d==f","b==g","a==h","d==i","c==e","e==j","c==k","b==e","a==c"])
print(result)
