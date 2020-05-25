import UIKit

//146. LRU缓存机制
//运用你所掌握的数据结构，设计和实现一个  LRU (最近最少使用) 缓存机制。它应该支持以下操作： 获取数据 get 和 写入数据 put 。
//获取数据 get(key) - 如果密钥 (key) 存在于缓存中，则获取密钥的值（总是正数），否则返回 -1。
//写入数据 put(key, value) - 如果密钥已经存在，则变更其数据值；如果密钥不存在，则插入该组「密钥/数据值」。当缓存容量达到上限时，它应该在写入新数据之前删除最久未使用的数据值，从而为新的数据值留出空间。
//
//进阶:
//你是否可以在 O(1) 时间复杂度内完成这两种操作？
//
//示例:
//LRUCache cache = new LRUCache( 2 /* 缓存容量 */ );
//cache.put(1, 1);
//cache.put(2, 2);
//cache.get(1);       // 返回  1
//cache.put(3, 3);    // 该操作会使得密钥 2 作废
//cache.get(2);       // 返回 -1 (未找到)
//cache.put(4, 4);    // 该操作会使得密钥 1 作废
//cache.get(1);       // 返回 -1 (未找到)
//cache.get(3);       // 返回  3
//cache.get(4);       // 返回  4

// ****************************** 解法一 hash+双向链表 *************************** //
///为保证在插入的时候，也是时间复杂度O(1); 而且存储是按照从访问的先后顺序进行排列；插入删除时间复杂度为O(1)的话，链表比较合适

class LRUCache {
    
    class Node {
        var key: Int = -1
        var value: Int = -1
        var pre: Node? = nil
        var next: Node? = nil
        
        init(_ key: Int, _ value: Int) {
            self.key = key
            self.value = value
        }
    }
    
    var element: [Int: Node] = [:]
    var capacity: Int = 0
    var head: Node = Node(-1, -1)
    var tail: Node = Node(-1, -1)
    var currentCount: Int = 0

    init(_ capacity: Int) {
        element = Dictionary.init(minimumCapacity: capacity)
        self.capacity = capacity
        self.head.next = self.tail
        self.tail.pre = self.head
        currentCount = 0
    }
    
    func get(_ key: Int) -> Int {
        if let node = element[key] {
            node.pre?.next = node.next
            node.next?.pre = node.pre
            
            node.next = self.head.next
            node.pre = self.head
            self.head.next?.pre = node
            self.head.next = node
            
            return node.value
        }
        
        return -1
    }
    
    func put(_ key: Int, _ value: Int) {
        if capacity == 0 {
            return
        }
        if let node = element[key] {
            // 已经存在，直接修改值，然后移动位置
            node.value = value
            
            node.pre?.next = node.next
            node.next?.pre = node.pre
            
            node.pre = self.head
            node.next = self.head.next
            node.next?.pre = node
            self.head.next = node
        } else {
            // 如果没有就需要新建
            if currentCount == capacity {
                // 删除最旧的结点
                let deleteNode = self.tail.pre
                self.tail.pre = self.tail.pre?.pre
                self.tail.pre?.next = self.tail
                if let node = deleteNode {
                    element.removeValue(forKey: node.key)
                }
                currentCount -= 1
            }
            // 添加新结点
            let node = Node(key, value)
            node.pre = self.head
            node.next = self.head.next
            node.next?.pre = node
            self.head.next = node
            element[key] = node
            currentCount += 1
        }
    }
}
let obj = LRUCache(2)
obj.put(1, 1)
obj.put(2, 2)
let ret_3: Int = obj.get(1)
obj.put(3, 3)
let ret_5: Int = obj.get(2)
obj.put(4, 4)
let ret_7: Int = obj.get(1)
let ret_8: Int = obj.get(3)
let ret_9: Int = obj.get(4)
print("result:ret_3:\(ret_3);ret_5:\(ret_5);ret_7:\(ret_7);ret_8:\(ret_8);ret_9:\(ret_9)")

