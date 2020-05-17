import UIKit

//210. 课程表 II
//现在你总共有 n 门课需要选，记为 0 到 n-1。
//在选修某些课程之前需要一些先修课程。 例如，想要学习课程 0 ，你需要先完成课程 1 ，我们用一个匹配来表示他们: [0,1]
//给定课程总量以及它们的先决条件，返回你为了学完所有课程所安排的学习顺序。
//可能会有多个正确的顺序，你只要返回一种就可以了。如果不可能完成所有课程，返回一个空数组。
//
//示例 1:
//输入: 2, [[1,0]]
//输出: [0,1]
//解释: 总共有 2 门课程。要学习课程 1，你需要先完成课程 0。因此，正确的课程顺序为 [0,1] 。
//
//示例 2:
//输入: 4, [[1,0],[2,0],[3,1],[3,2]]
//输出: [0,1,2,3] or [0,2,1,3]
//解释: 总共有 4 门课程。要学习课程 3，你应该先完成课程 1 和课程 2。并且课程 1 和课程 2 都应该排在课程 0 之后。
//     因此，一个正确的课程顺序是 [0,1,2,3] 。另一个正确的排序是 [0,2,1,3] 。
//
//说明:
//输入的先决条件是由边缘列表表示的图形，而不是邻接矩阵。详情请参见图的表示法。
//你可以假定输入的先决条件中没有重复的边。
//
//提示:
//这个问题相当于查找一个循环是否存在于有向图中。如果存在循环，则不存在拓扑排序，因此不可能选取所有课程进行学习。
//通过 DFS 进行拓扑排序 - 一个关于Coursera的精彩视频教程（21分钟），介绍拓扑排序的基本概念。
//拓扑排序也可以通过 BFS 完成。


// *************************** 解法一 广度优先搜索 ***************************//
/// 广度优先算法 是从模拟一个队列，然后从队列中依次寻找入度为0的结点，依次从入度为0的先决课程中对应的后继课程依次减去该先决课程的入度
/// 如果结点的入度也为0，就加入到队列，依次进行此操作
class Solution {
    func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
        var edges: [[Int]] = Array.init(repeating: [], count: numCourses)
        var angle: [Int] = Array.init(repeating: 0, count: numCourses)
        
        prerequisites.forEach { item in
            edges[item[1]].append(item[0])
            angle[item[0]] = angle[item[0]] + 1
        }
        
        var queue: [Int] = []
        // 找到入度为0的结点，怎么找入度为0的结点，然后入栈
        angle.forEach { item in
            if item == 0 {
                queue.append(item)
            }
        }
        
        var result: [Int] = []
        while !queue.isEmpty {
            let first = queue.removeFirst()
            result.append(first)
            
            for item in edges[first] {
                angle[item] -= 1
                if angle[item] == 0 {
                    queue.append(item)
                }
            }
        }
        
        if result.count != numCourses {
            return []
        }
        
        return result
    }
}

let solu = Solution()
let result = solu.findOrder(4, [[1,0],[2,0],[3,1],[3,2]])
print(result)



// *************************** 解法二 深度优先搜索 ***************************//
/// 深度优先搜索 通过遍历每个结点，每个结点都有未访问、访问中和访问完成的状态，然后递归访问每个结点的后继课程结点，修改访问状态，每完成一个结点的后继课程结点
/// 就将该先决课程结点置为访问完成，访问完成后推入到一个暂存栈；
/// 没有后继课程的结点 肯定先访问完成，也就是最后才能学的课程结点会优先入栈，所以这个栈内的数据顺序是一个逆序，最后的结果反过来即可
///
class Solution2 {
    var edges: [[Int]] = []
    var visited: [Int] = []
    var isValid: Bool = true
    var doneStack: [Int] = []
    
    func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
        edges = Array.init(repeating: [], count: numCourses)
        visited = Array.init(repeating: 0, count: numCourses)
        
        prerequisites.forEach { item in
            edges[item[1]].append(item[0])
        }
        
        for node in 0..<numCourses {
            if visited[node] == 0 {
                dfs(node)
            }
            if !isValid {
                break
            }
        }
        
        if !isValid {
            return []
        }
        
        return doneStack.reversed()
    }
    
    private func dfs(_ node: Int) {
        visited[node] = 1
        
        for item in edges[node] {
            if visited[item] == 0 {
                dfs(item)
                if !isValid {
                    return
                }
            } else if visited[item] == 1 {
                isValid = false //说明出现了环
                return
            }
        }
        
        visited[node] = 2
        
        doneStack.append(node)
    }
}

let solu2 = Solution2()
let result2 = solu2.findOrder(4, [[1,0],[2,0],[3,1],[3,2]])
print(result2)
