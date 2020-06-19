import UIKit

//1028. 从先序遍历还原二叉树
//我们从二叉树的根节点 root 开始进行深度优先搜索。
//在遍历中的每个节点处，我们输出 D 条短划线（其中 D 是该节点的深度），然后输出该节点的值。（如果节点的深度为 D，则其直接子节点的深度为 D + 1。根节点的深度为 0）。
//如果节点只有一个子节点，那么保证该子节点为左子节点。
//给出遍历输出 S，还原树并返回其根节点 root。
//
//示例 1：
//输入："1-2--3--4-5--6--7"
//输出：[1,2,5,3,4,6,7]
//
//示例 2：
//输入："1-2--3---4-5--6---7"
//输出：[1,2,5,3,null,6,null,4,null,7]

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

// ****************************** 解法一 ****************************//
class Solution {
    func recoverFromPreorder(_ S: String) -> TreeNode? {
        if S == "" { return nil }
        var src: String = S+"-"
        
        var stack: [TreeNode] = []
        var root: TreeNode? = nil
        var curStr: String = ""
        var preIsNum: Bool = false
        var level: Int = 0

        // var treeLevel: Int = 0
        var curNode: TreeNode? = nil
        for (i,c) in src.enumerated() {
            if c == "-" && preIsNum {
                // 当前是 -  并且上一个是数字；处理数字逻辑
                if let num = Int(curStr) {
                    let tmpNode: TreeNode = TreeNode(num)
                    if root == nil {
                        root = tmpNode
                    }
                    if curNode != nil {
                        if curNode?.left == nil {
                            curNode?.left = tmpNode
                        } else {
                            curNode?.right = tmpNode
                        }
                    }
                    stack.append(tmpNode)
                    curNode = tmpNode
                }
                curStr = ""
                preIsNum = false
            } else if c != "-" && !preIsNum {
                // 当前是数字，并且上一个不是数字，处理深度
                let nextLevel: Int = curStr.count
                if nextLevel > level { // 如果下一个比当前的深度大，那说明需要设置左孩子
                } else if nextLevel < level {
                    var j = level
                    while j >= nextLevel && !stack.isEmpty {
                        stack.removeLast()
                        j -= 1
                    }
                    curNode = stack.last
                } else if nextLevel == level { // 如果下一个和当前的level相等
                    if stack.count >= 2 {
                        stack.removeLast()
                        curNode = stack.last
                    }
                }
                level = nextLevel
                curStr = ""
                preIsNum = true
            }

            curStr += String(c) // 连接当前字符
        }

        return root
    }
}
