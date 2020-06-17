import UIKit

//433. 最小基因变化
//一条基因序列由一个带有8个字符的字符串表示，其中每个字符都属于 "A", "C", "G", "T"中的任意一个。
//
//假设我们要调查一个基因序列的变化。一次基因变化意味着这个基因序列中的一个字符发生了变化。
//
//例如，基因序列由"AACCGGTT" 变化至 "AACCGGTA" 即发生了一次基因变化。
//
//与此同时，每一次基因变化的结果，都需要是一个合法的基因串，即该结果属于一个基因库。
//
//现在给定3个参数 — start, end, bank，分别代表起始基因序列，目标基因序列及基因库，请找出能够使起始基因序列变化为目标基因序列所需的最少变化次数。如果无法实现目标变化，请返回 -1。
//注意:
//起始基因序列默认是合法的，但是它并不一定会出现在基因库中。
//所有的目标基因序列必须是合法的。
//假定起始基因序列与目标基因序列是不一样的。
//
//示例 1:
//start: "AACCGGTT"
//end:   "AACCGGTA"
//bank: ["AACCGGTA"]
//返回值: 1
//
//示例 2:
//start: "AACCGGTT"
//end:   "AAACGGTA"
//bank: ["AACCGGTA", "AACCGCTA", "AAACGGTA"]
//返回值: 2
//
//示例 3:
//start: "AAAAACCC"
//end:   "AACCCCCC"
//bank: ["AAAACCCC", "AAACCCCC", "AACCCCCC"]
//返回值: 3


// ********************************** 解法一 BFS *********************************//
class Solution {
    func minMutation(_ start: String, _ end: String, _ bank: [String]) -> Int {
        
        var hashmap: [String: Int] = [:]
        for (i,str) in bank.enumerated() {
            hashmap[str] = i
        }
        
        var queue: [(String, Int)] = [(start, 0)]
        
        while !queue.isEmpty {
            let (gene, step) = queue.removeFirst()

            if gene == end {
                return step
            }

            let genechars: [Character] = gene.map { $0 }
            for (i,c) in genechars.enumerated() {
                for nc in "ACGT" {
                    if c == nc { continue } // 如果一样，那么不操作
                    var ngene: [Character] = genechars
                    ngene[i] = nc
                    let ngenestr = String(ngene)
                    if let _ = hashmap[ngenestr] {// 如果存在，那么就添加到队列里
                        // 如果存在，就push
                        queue.append((ngenestr, step+1))
                        hashmap.removeValue(forKey: ngenestr) // 这里删除候选人的原因是：怕产生循环
                    }
                }
            }
        }
        
        return -1
    }
}
let solu = Solution()
let result = solu.minMutation("AACCGGTT", "AAACGGTA", ["AACCGGTA", "AACCGCTA", "AAACGGTA"])
print(result)
