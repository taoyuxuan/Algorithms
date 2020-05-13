import UIKit

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.left = nil
 *         self.right = nil
 *     }
 * }
 */

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
    
    public func createTree(_ arr: [Int?]) {
        let count = arr.count
        if count <= 0 {
            return
        }
        
        var queue: [TreeNode] = [self]
        
        var i: Int = 0
        while !queue.isEmpty {
            let first = queue.removeFirst()
            let lIdx = 2 * (i + 1) - 1
            let rIdx = 2 * (i + 1)
            if lIdx < count {
                if let ln = arr[lIdx] {
                    let leftNode = TreeNode(ln)
                    queue.append(leftNode)
                    first.left = leftNode
                }
            }
            
            if rIdx < count {
                if let rn = arr[rIdx] {
                    let rightNode = TreeNode(rn)
                    queue.append(rightNode)
                    first.right = rightNode
                }
            }
            
            i += 1
        }
    }
}

class Solution {
    // ********************** 自己想出来的解决方案 *******************************/
    // 利用缓存栈进行层遍历，然后利用一个数组 currentQueue 进行缓存每一层的数据；缓存栈每一层完成之后将currentQueue的数据装进去，再次进行遍历。
    // 但是速度方面很慢；而且缓存利用也比较多。
    // 时间复杂度：O(n) ; 空间复杂度：O(n)
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else {
            return []
        }

        var result: [[Int]] = []
        var currentLevel: [Int] = []
        var queue: [TreeNode] = [root]
        var currentQueue: [TreeNode] = []
        
        while !queue.isEmpty {
            let first = queue.removeFirst()
            currentLevel.append(first.val)
            if let left = first.left {
                currentQueue.append(left)
            }
            if let right = first.right {
                currentQueue.append(right)
            }

            if queue.isEmpty && !currentQueue.isEmpty {
                queue.append(contentsOf: currentQueue)
                currentQueue.removeAll()
                result.append(currentLevel)
                currentLevel = Array()
            }
        }

        result.append(currentLevel)
        currentLevel.removeAll()

        return result
    }
    
    // ********************** 官方题解方案 *******************************/
    // 每次取出时，将所有的元素都取出，然后进行遍历，这样就免去了缓存；
    // 但是时间复杂度也是O(n);空间复杂度也是O(n)
    func officalLevelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else {
            return []
        }

        var result: [[Int]] = []
        var queue: [TreeNode] = [root]
        
        while !queue.isEmpty {
            let count: Int = queue.count
            var currentLevel: [Int] = []
            
            for _ in 0..<count {
                let first = queue.removeFirst()
                currentLevel.append(first.val)
                if let left = first.left {
                    queue.append(left)
                }
                if let right = first.right {
                    queue.append(right)
                }
            }
            result.append(currentLevel)
        }
        
        return result
    }
}

//[3,9,20,null,null,15,7]
let rootNode = TreeNode(3)
rootNode.createTree([3, 9, 20, nil, nil, 15, 7])
let solu = Solution()
//let arr = solu.levelOrder(rootNode)
let arr = solu.officalLevelOrder(rootNode)
print(arr)

