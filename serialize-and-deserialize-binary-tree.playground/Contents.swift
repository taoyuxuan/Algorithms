import UIKit

//297. 二叉树的序列化与反序列化
//序列化是将一个数据结构或者对象转换为连续的比特位的操作，进而可以将转换后的数据存储在一个文件或者内存中，同时也可以通过网络传输到另一个计算机环境，采取相反方式重构得到原数据。
//
//请设计一个算法来实现二叉树的序列化与反序列化。这里不限定你的序列 / 反序列化算法执行逻辑，你只需要保证一个二叉树可以被序列化为一个字符串并且将这个字符串反序列化为原始的树结构。
//
//示例:
//
//你可以将以下二叉树：
//
//    1
//   / \
//  2   3
//     / \
//    4   5
//
//序列化为 "[1,2,3,null,null,4,5]"
//提示: 这与 LeetCode 目前使用的方式一致，详情请参阅 LeetCode 序列化二叉树的格式。你并非必须采取这种方式，你也可以采用其他的方法解决这个问题。
//
//说明: 不要使用类的成员 / 全局 / 静态变量来存储状态，你的序列化和反序列化算法应该是无状态的。

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

// ************************* 解法一 DFS ***************************** //
/// 先序遍历
class Codec {
    func serialize(_ root: TreeNode?) -> String {
        guard let root = root else {
            return "[]"
        }
        
        var stack: [TreeNode?] = [root]
        var ans: String = "["
        while !stack.isEmpty {
            let node = stack.removeLast()
            if let curnode = node {
                ans += String(curnode.val)
                ans += ","
                
                stack.append(curnode.right)
                stack.append(curnode.left)
            } else {
                ans += "null,"
            }
        }
        ans.removeLast()
        ans += "]"
        
        return ans
    }
    
    // 栈+当前指针
    func deserialize(_ data: String) -> TreeNode? {
        let srcdata: String = data.trimmingCharacters(in: CharacterSet.init(["[","]"]))
        var dataArr = srcdata.split(separator: ",")
        if dataArr.count <= 0 {
            return nil
        }
        
        let firstVal = dataArr.removeFirst()
        guard let rootval = Int(firstVal) else {
            return nil
        }
        let root: TreeNode = TreeNode(rootval)
        var stack: [TreeNode] = [root]
        var curnode: TreeNode? = root
        
        while !dataArr.isEmpty {
            let valstr = dataArr.removeFirst()
            var tmpNode: TreeNode? = nil
            if let tmpval = Int(valstr) {
                tmpNode = TreeNode(tmpval)
            }
            
            // curnode为空 说明左孩子已经完了，开始右孩子了
            // 不为空 说明还是要添加进右孩子
            if curnode == nil && !stack.isEmpty {
                curnode = stack.removeLast()
                curnode?.right = tmpNode
            } else {
                curnode?.left = tmpNode
            }
            curnode = tmpNode
            if let node = tmpNode {
                stack.append(node)
            }
            
        }
        return root
    }
}
