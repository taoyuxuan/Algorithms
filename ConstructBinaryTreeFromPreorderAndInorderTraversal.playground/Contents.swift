import UIKit


//105. 从前序与中序遍历序列构造二叉树
//根据一棵树的前序遍历与中序遍历构造二叉树。
//
//注意:
//你可以假设树中没有重复的元素。
//
//例如，给出
//
//前序遍历 preorder = [3,9,20,15,7]
//中序遍历 inorder = [9,3,15,20,7]
//返回如下的二叉树：
//
//    3
//   / \
//  9  20
//    /  \
//   15   7


public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
    
    static func showLayerNodes(_ node: TreeNode?) {
        guard let node = node else {
            print("nil")
            return
        }
        let val = node.val
        print("\(val)")
        showLayerNodes(node.left)
        showLayerNodes(node.right)
    }
}

// *********************************** 解法一 递归 ********************************* //
/// 第一想到用递归，因为树进行递归是很好用的
///
class Solution {
    
    var index: [Int: Int] = [:] // 刚开始没想到用hash表进行存储inOrder每个元素的index.确实妙
    
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        let count: Int = preorder.count
        // 遍历并存储index
        for (i,val) in inorder.enumerated() {
            index[val] = i
        }
        
        return createTree(preorder, 0, count-1, 0, count-1)
    }
    
    func createTree(_ preorder: [Int], _ preRootIndex: Int, _ preLastIndex: Int, _ inFirstIndex: Int, _ inLastIndex: Int) -> TreeNode? {
        if preRootIndex > preLastIndex {
            return nil
        }
        let rootVal: Int = preorder[preRootIndex]
        let node: TreeNode = TreeNode(rootVal)
        if preRootIndex == preLastIndex {
            return node
        }
        
        // 确定左右子树的位置
        if let midRootIdx: Int = index[rootVal] {
            // 找到根结点了
            var leftNode: TreeNode? = nil
            var rightNode: TreeNode? = nil
            if midRootIdx > inFirstIndex {
                // 有左子树
                let leftCount: Int = midRootIdx - inFirstIndex
                let leftLastIndex: Int = preRootIndex + leftCount
                leftNode = createTree(preorder, preRootIndex+1, leftLastIndex, inFirstIndex, midRootIdx-1)
                rightNode = createTree(preorder, leftLastIndex+1, preLastIndex, midRootIdx+1, inLastIndex)
            } else {
                // 只有右子树
                rightNode = createTree(preorder, preRootIndex+1, preLastIndex, inFirstIndex+1, inLastIndex)
            }
            node.left = leftNode
            node.right = rightNode
        }
        
        return node
    }
}

let solu = Solution()
let tree = solu.buildTree([1,2,3], [3,2,1])
TreeNode.showLayerNodes(tree)


// *********************************** 解法一 迭代 ********************************* //
/// 迭代的思路也很巧妙，利用了一个栈和一个辅助指针
///
class Solution2 {
    
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        let count = preorder.count
        if count <= 0 {
            return nil
        }
        let rootNode: TreeNode = TreeNode(preorder[0])
        var stack: [TreeNode] = [rootNode]
        var idx: Int = 0
        for (i,val) in preorder.enumerated() {
            if i == 0 {
                continue
            }
            if let topNode = stack.last {
                if topNode.val != inorder[idx] {
                    let node: TreeNode = TreeNode(val)
                    topNode.left = node
                    stack.append(node)
                } else {
                    // 如果相等，就吐出来，并且将index+1
                    var currentNode: TreeNode = topNode
                    while !stack.isEmpty && stack.last?.val == inorder[idx] {
                        // 栈顶的元素和指向的元素相等的话，就吐出来
                        currentNode = stack.removeLast()
                        idx += 1
                    }
                    let node: TreeNode = TreeNode(val)
                    currentNode.right = node
                    stack.append(node)
                }
            }
        }
        return rootNode
    }
}

print("======================分割线=========================")
let solu2 = Solution2()
let tree2 = solu2.buildTree([1,2,3], [3,2,1])
TreeNode.showLayerNodes(tree2)
