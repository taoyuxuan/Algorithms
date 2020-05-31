import UIKit

//101. 对称二叉树
//给定一个二叉树，检查它是否是镜像对称的。
//
//例如，二叉树 [1,2,2,3,4,4,3] 是对称的。
//    1
//   / \
//  2   2
// / \ / \
//3  4 4  3
//
//
//但是下面这个 [1,2,2,null,3,null,3] 则不是镜像对称的:
//    1
//   / \
//  2   2
//   \   \
//   3    3

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


// ********************* 解法一 递归 ************************ //
class Solution {
    func isSymmetric(_ root: TreeNode?) -> Bool {
        guard let root = root else {
            return true
        }
        if root.left == nil && root.right == nil {
            return true
        }
        guard let l = root.left, let r = root.right, l.val == r.val else {
            return false
        }
        
        return check(l, r)
    }
    
    func check(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil && q == nil {
            return true
        }
        guard let p = p, let q = q, p.val == q.val else {
            return false
        }
        
        return check(p.left, q.right) && check(p.right, q.left)
    }
}


// ********************* 解法二 迭代 ************************ //
class Solution2 {
    func isSymmetric(_ root: TreeNode?) -> Bool {
        guard let root = root else {
            return true
        }
        if root.left == nil && root.right == nil {
            return true
        }
        guard let l = root.left, let r = root.right, l.val == r.val else {
            return false
        }
        
        var queue: [TreeNode?] = [l,r]
        while !queue.isEmpty {
            let p = queue.removeFirst()
            let q = queue.removeFirst()
            if p == nil, q == nil {
                continue
            }
            guard let tp = p, let tq = q, tp.val == tq.val else {
                return false
            }
            
            queue.append(tp.left)
            queue.append(tq.right)
            queue.append(tp.right)
            queue.append(tq.left)
        }
        
        return true
    }
}
