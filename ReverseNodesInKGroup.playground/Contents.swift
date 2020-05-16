import UIKit

//25. K 个一组翻转链表
//给你一个链表，每 k 个节点一组进行翻转，请你返回翻转后的链表。
//k 是一个正整数，它的值小于或等于链表的长度。
//如果节点总数不是 k 的整数倍，那么请将最后剩余的节点保持原有顺序。
//
//示例：
//给你这个链表：1->2->3->4->5
//当 k = 2 时，应当返回: 2->1->4->3->5
//当 k = 3 时，应当返回: 3->2->1->4->5
//
//说明：
//你的算法只能使用常数的额外空间。
//你不能只是单纯的改变节点内部的值，而是需要实际进行节点交换。

public class ListNode: CustomStringConvertible {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    public func createList(_ nodes: [Int]) {
        var p: ListNode? = self
        for (i, val) in nodes.enumerated() {
            if i != 0 {
                let tmpNode = ListNode(val)
                p?.next = tmpNode
                p = p?.next
            }
        }
    }
    public var description: String {
        var result: String = "["
        var p: ListNode? = self
        while p != nil {
            if let tmpVal = p?.val{
                result += "\(tmpVal)"
            }
            p = p?.next
        }
        result += "]"
        return result
    }
    
}

// ************************** 解法一 自己想到的方法 *************************//
/// 看了下官方题解，也是这个方法
/// 说下思路：先用一个指针进行移动探测，剩余的结点是否大于等于k个，如果是，那么我们再进行交换，而链表的交换是依次将后面的一个结点往前移动，直至把该分组的全部移动完毕；如果剩余数组小于k个，那么不进行移动，直接退出即可。
/// 首先说一下，刚开始运行不过的问题，受思维限制，就是在链表结点交换的时候到底是交换了几次？？是k次吗？ 那从0到多少是k次？刚开始这里比较懵，以为是0到k，运行的时候发现答案一堆乱七八糟，跟想象的差太多，直到调试才发现问题，我真正交换的次数不是0到k，也不是k次，而是k-1次，为什么，我们从 1 2 3 4 5，k=2这个例子来看；每个分组应该是 1 2， 3 4， 5； 1和2交换，其实交换了1次，k=3的时候 1 2 3，4 5；我们只需要把2和3提到前面就行，交换次数是2，所以真正交换的次数是k-1
/// 时间复杂度：O(n);空间复杂度: O(1)

class Solution {
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard let head = head else {
            return nil
        }
        
        var p: ListNode? = ListNode(0) // 虚拟结点
        p?.next = head
        var q: ListNode? = head
        let resultHead: ListNode? = p
        while p?.next != nil {
            var remain: Int = k
            while remain > 0 && q != nil {
                q = q?.next
                remain -= 1
            }

            if remain == 0 {
                // 如果剩余为0个，说明能凑够k个值，那么就进行翻转
                let tmpLast: ListNode? = p?.next
                while remain < k-1 {
                    let moveNode: ListNode? = tmpLast?.next
                    tmpLast?.next = moveNode?.next
                    moveNode?.next = p?.next
                    p?.next = moveNode

                    remain += 1
                }
                p = tmpLast
            } else if q == nil {
                // 说明剩下的元素不够k个，那么不用翻转，直接退出
                break
            }
        }

        return resultHead?.next
    }
}
let head: ListNode = ListNode.init(1)
head.createList([1,2,3,4,5,6,0])
let solu = Solution()
let result = solu.reverseKGroup(head, 3)
print(result ?? "")


// ************************** 解法二 递归 *************************//

