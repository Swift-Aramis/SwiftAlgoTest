//
//  SwordOfferAlgo.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/9/14.
//

import Foundation

class SwordOfferAlgo {
    
    //MARK: - 剑指 Offer 48. 最长不含重复字符的子字符串
    /**
     难度：中等
     题目：请从字符串中找出一个最长的不包含重复字符的子字符串，计算该最长子字符串的长度。
     
     示例：
     输入: "abcabcbb"
     输出: 3
     解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
     
     输入: "bbbbb"
     输出: 1
     解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。
     
     输入: "pwwkew"
     输出: 3
     解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
     
     请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。
     */
    func lengthOfLongestSubstring(_ s: String) -> Int {
        // 校验
        guard s.count > 1 else {
            return s.count
        }
        
        /**
         解决思路：双指针 + 哈希表
         最大长度：maxLen
         边界指针：left
         下标位置：i
         是否重复校验及记录重复元素下标：dic[c] = index
         */
        var maxLen = 0
        var left = 0, i = 0
        var dic: [Character: Int] = [Character: Int]()
        for c in s {
            if dic.keys.contains(c) {
                // 剔除子序列最前面的重复元素
                var lastIndex = dic[c] ?? 0
                lastIndex += 1
                // 重置left指针指向
                left = max(left, lastIndex)
            }
            
            // 存储元素对应下标位置
            dic[c] = i
            maxLen = max(maxLen, i - left + 1)
            
            i += 1
        }
        
        return maxLen
    }
    
    //MARK: - 剑指 Offer 10- I. 斐波那契数列
    // 使用「滚动数组思想」把空间复杂度优化成 O(1)
    func fib(_ n: Int) -> Int {
        if n < 2 {
            return n
        }
        
        let mod = 1000000007
        
        var p = 0
        var q = 0
        var r = 1
        for _ in 2...n {
            p = q
            q = r
            r = (p + q) % mod
        }
        
        return r
    }
    
    // 超时
    func fib1(_ n: Int) -> Int {
        if n < 2 {
            return n
        }
        
        return fib(n - 1) + fib(n - 2)
    }
    
    //MARK: - 剑指 Offer 10- II. 青蛙跳台阶问题
    /**
     斐波那契数列：f0 = 0，f1 = 1，f2 = 2
     青蛙跳台阶问题： f0 = 1，f1 = 1，f2 = 2
     */
    func numWays(_ n: Int) -> Int {
        let mod = 1000000007
        var p = 0
        var q = 0
        var r = 1
        for _ in 2...n {
            p = q
            q = r
            r = (p + q) % mod
        }
        
        return r
    }
    
    //MARK: - 剑指 Offer 11. 旋转数组的最小数字
    /**
     把一个数组最开始的若干个元素搬到数组的末尾，我们称之为数组的旋转。
     输入一个递增排序的数组的一个旋转，输出旋转数组的最小元素。
     例如，数组 [3,4,5,1,2] 为 [1,2,3,4,5] 的一个旋转，该数组的最小值为1。
     
     分析：我们考虑数组中的最后一个元素 2，
     在最小值1 右侧的元素，它们的值一定都小于等于 2：[1，2]；
     而在最小值1 左侧的元素，它们的值一定都大于等于2：[3，4，5]。
     因此，我们可以根据这一条性质，通过二分查找的方法找出最小值。
     */
    // 1、二分查找法
    func minArray(_ numbers: [Int]) -> Int {
        if numbers.count == 0 {
            return 0
        }
        
        // 左边界 low，右边界 high
        var low = 0
        var high = numbers.count - 1
        while low < high {
            // 中点 mid
            let mid = low + (high - low) >> 1
            
            if numbers[mid] < numbers[high] {
                // mid值 < high值，说明当前mid在最小值右边，如 [5,1,2,3,4] => mid = 2，而min = 1
                // 缩小右边界high位置到mid
                high = mid
                
            } else if numbers[mid] > numbers[high] {
                // mid值 > high值，说明当前mid在最小值左边
                // 缩小左边界low位置到mid+1
                low = mid + 1
            } else {
                // numbers[mid] == numbers[high] 有重复元素的存在，忽略右侧的值
                high -= 1
            }
        }
        
        return numbers[low]
    }
    
    // 2、暴力法
    func minArrayNormal(_ numbers: [Int]) -> Int {
        if numbers.count == 0 {
            return 0
        }
        
        // 存储最小的值
        var minVal = numbers.first!
        for val in numbers {
            if val < minVal {
                minVal = min(minVal, val)
            }
        }
        
        return minVal
    }
    
    //MARK: - 剑指 Offer 21. 调整数组顺序使奇数位于偶数前面
    // 双指针前后遍历，交换不符合条件的元素
    func exchange(_ nums: [Int]) -> [Int] {
        var arr = nums
        var left = 0
        var right = arr.count - 1
        while left < right {
            // left - 奇数 - 后移
            if left < right, arr[left] % 2 == 1 {
                left += 1
            }
            // right - 偶数 - 前移
            if left < right, arr[right] % 2 == 0 {
                right -= 1
            }
            // 交换前面的偶数和后面的奇数
            let tmp = arr[left]
            arr[left] = arr[right]
            arr[right] = tmp
        }
        
        return arr
    }
    
    //MARK: - 剑指 Offer 29. 顺时针打印矩阵
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        var res = [Int]()
        if matrix.count == 0 {
            return res
        }
        
        // 矩阵 左、右、上、下 四个边界 l , r , t , b
        var l = 0, r = matrix[0].count - 1, t = 0, b = matrix.count - 1
        
        // 循环打印： “从左向右、从上向下、从右向左、从下向上” 四个方向循环
        while true {
            // left to right
            for i in l...r {
                res.append(matrix[t][i])
            }
            t += 1
            if t > b {
                break
            }
            
            // top to bottom
            for i in t...b {
                res.append(matrix[i][r])
            }
            r -= 1
            if r < l {
                break
            }
            
            // right to left
            for i in (l...r).reversed() {
                res.append(matrix[b][i])
            }
            b -= 1
            if b < t {
                break
            }
            
            // bottom to top
            for i in (t...b).reversed() {
                res.append(matrix[i][l])
            }
            l += 1
            if l > r {
                break
            }
        }
        
        return res
    }
    
    //MARK: - 剑指 Offer 17. 打印从1到最大的n位数
    /**
     输入数字 n，按顺序打印出从 1 到最大的 n 位十进制数。比如输入 3，则打印出 1、2、3 一直到最大的 3 位数 999。
     n = 1 -> 1...9 -> 10^1
     n = 2 -> 1...99 -> 10^2
     */
    func printNumbers(_ n: Int) -> [Int] {
        var arr = [Int]()
        if n == 0 {
            return arr
        }
        
        let maxVal = pow(10 , n)
        let result = NSDecimalNumber(decimal: maxVal)
        
        for i in 1..<result.intValue {
            arr.append(i)
        }
        return arr
    }
    
    //MARK: - 剑指 Offer 03. 数组中重复的数字
    // 原地交换
    // 索引 和 值 一对多 1...n-1
    func findRepeatNumber(_ nums: [Int]) -> Int {
        var i = 0
        var arr = nums
        
        while i < arr.count {
            let val = arr[i] // 当前元素值
            if val == i {
                i += 1
                continue
            }
            
            if arr[val] == val { // 当前元素值还有其他索引位置
                return val
            }
            
            // 索引 值 一一对应
            arr[i] = arr[val]
            arr[val] = val
        }
        
        return -1
    }
    
    func findRepeatNumberOverTime(_ nums: [Int]) -> Int {
        var tmpArr = [Int]()
        for item in nums {
            if tmpArr.contains(item) {
                return item
            }
            tmpArr.append(item)
        }
        
        return -1
    }
    
    //MARK: - 剑指 Offer 06. 从尾到头打印链表
    func reversePrint(_ head: ListNode?) -> [Int] {
        var arr = [Int]()
        if head == nil {
            return arr
        }
        
        var node = head
        while node != nil  {
            arr.insert(node!.val, at: 0)
            node = node?.next
        }

        return arr
    }
    
    //MARK: - 剑指 Offer 05. 替换空格
    func replaceSpace(_ s: String) -> String {
        var ans = ""
        for c in s {
            let char = String(c)
            let val = (char == " ") ? "%20" : char
            ans.append(val)
        }
        return ans
    }
    
    //MARK: - 剑指 Offer 40. 最小的k个数
    /**
     基于快速排序的数组划分
     排序过程中，比较 k 与 基准值下标i 的大小
     */
    func getLeastNumbers(_ arr: [Int], _ k: Int) -> [Int] {
        if k >= arr.count {
            return arr
        }
        
        var res = arr
        quickSort(&res, k, 0, arr.count - 1)
        return Array(res.prefix(k))
    }
    
    func quickSort(_ arr: inout [Int], _ k: Int, _ l: Int, _ r: Int) {
        // 初始指针位置 l, r
        // pivot参考值 arr[l]
        // 快排核心逻辑：与pivot比较大小，小的放在左边，大的放在右边，最后将pivot从最左边移到序列中对应位置
        var i = l, j = r
        while i < j {
            while i < j, arr[j] >= arr[l] {
                j -= 1
            }
            while i < j, arr[i] <= arr[l] {
                i += 1
            }
            arr.swapAt(i, j)
        }
        arr.swapAt(l, i)
        
        // 左侧数组数据过多，需要继续向左找
        if i > k {
            quickSort(&arr, k, l, i - 1)
        }
        // 左侧数组数据不够，需要继续向右找
        if i < k {
            quickSort(&arr, k, i + 1, r)
        }
    }
    
    //MARK: - 剑指 Offer 39. 数组中出现次数超过一半的数字
    /**
     求数组中的众数
     投票算法：相等 +1，不相等 -1，直到为0，取当前元素重新计数
     */
    func majorityElement(_ nums: [Int]) -> Int {
        var candidate = 0 // 候选人
        var count = 0 // 投票计数
        for cur in nums {
            if count == 0 {
                candidate = cur
            }
            count += (candidate == cur) ? 1 : -1
        }
        
        return candidate
    }
    
    //MARK: - 剑指 Offer 25. 合并两个排序的链表
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let dummy = ListNode()
        var head: ListNode? = dummy
        var head1 = l1
        var head2 = l2
        while head1 != nil, head2 != nil {
            if head1!.val < head2!.val {
                head?.next = head1
                head1 = head1?.next
            } else {
                head?.next = head2
                head2 = head2?.next
            }
            
            head = head?.next
        }
        
        if head1 != nil {
            head?.next = head1
        } else {
            head?.next = head2
        }
        
        return dummy.next
    }
    
    //MARK: - 剑指 Offer 24. 反转链表
    func reverseList(_ head: ListNode?) -> ListNode? {
        
        var pre: ListNode? = nil
        var cur: ListNode? = head
        
        while cur != nil {
            let next = cur?.next
            cur?.next = pre
            pre = cur
            cur = next
        }
        
        return pre
    }
    
    //MARK: - 剑指 Offer 27. 二叉树的镜像
    func mirrorTree(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return root
        }
        
        let left = mirrorTree(root?.left)
        let right = mirrorTree(root?.right)
        root?.left = right
        root?.right = left
        
        return root
    }
    
    //MARK: - 剑指 Offer 28. 对称的二叉树
    func isSymmetric(_ root: TreeNode?) -> Bool {
        return checkSymmetric(root?.left, root?.right)
    }
    
    // 双指针递归
    func checkSymmetric(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil, q == nil {
            return true
        }
        
        if p == nil || q == nil {
            return false
        }
                
        return p!.val == q!.val &&
            checkSymmetric(p?.left, q?.right) &&
            checkSymmetric(p?.right, q?.left)
    }
    
    //MARK: - 剑指 Offer 22. 链表中倒数第k个节点
    func getKthFromEnd(_ head: ListNode?, _ k: Int) -> ListNode? {
        var fast = head
        var num = 0
        while fast != nil, num < k {
            fast = fast?.next
            num += 1
        }
        
        var slow = head
        while fast != nil {
            fast = fast?.next
            slow = slow?.next
        }
        
        return slow
    }
    
    //MARK: - 剑指 Offer 18. 删除链表的节点
    func deleteNode(_ head: ListNode?, _ val: Int) -> ListNode? {
        
        let dummy = ListNode(0, head)
        var pre: ListNode? = dummy
        var cur = head
        
        while cur != nil {
            if cur!.val == val {
                pre?.next = cur?.next
                break
            }
            pre = cur
            cur = cur?.next
        }
        
        return dummy.next
    }
    
    //MARK: - 剑指 Offer 32 - II. 从上到下打印二叉树 II
    /**
     广度优先级遍历二叉树
     */
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var ans = [[Int]]()
        if root == nil {
            return ans
        }
        
        // 初始插入根节点
        var queue = [TreeNode]()
        queue.append(root!)
        
        while queue.count > 0 {
            // 该层的所有结点
            var levelNodes = [Int]()
            // 暂存该层的长度，后续 queue.count 会发送改变
            var levelLen = queue.count
            
            while levelLen > 0 {
                levelLen -= 1
                
                // 队列：先进先出，当前层的队列元素依次出队
                let node = queue.first
                levelNodes.append(node!.val)
                queue.removeFirst()
                       
                // 下一层的队列元素依次入队
                if let left = node!.left {
                    queue.append(left)
                }
                
                if let right = node!.right {
                    queue.append(right)
                }
            }
            
            ans.append(levelNodes)
        }
        
        return ans
    }
    
    //MARK: - 剑指 Offer 50. 第一个只出现一次的字符
    /**
     题目：在字符串 s 中找出第一个只出现一次的字符。如果没有，返回一个单空格。 s 只包含小写字母。
     输入：s = "abaccdeff"
     输出：'b"
     
     分析：
     1、首次遍历数组，字典存储元素出现次数；
     2、再次遍历数组，取出第一个 val == 1 的元素
     */
    func firstUniqChar(_ s: String) -> Character {
        let defaultVal: Character = " "
        if s.count == 0 {
            return defaultVal
        }
        
        // 1、字典存储元素出现次数
        var dic = [Character: Int]()
        for ch in s {
            var count = dic[ch] ?? 0
            count += 1
            dic[ch] = count
        }
        
        // 2、取出第一个 val == 1 的元素
        for ch in s {
            let count = dic[ch] ?? 0
            if count == 1 {
                return ch
            }
        }
        
        return defaultVal
    }
    
    //MARK: - 剑指 Offer 55 - I. 二叉树的深度
    /**
     深度优先级遍历：left，right 分别递归，取最大值 + 1
     */
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        
        return max(maxDepth(root?.left), maxDepth(root?.right)) + 1
    }
    
    //MARK: - 剑指 Offer 57. 和为s的两个数字
    // 1、暴力法：超时
    func overTime_twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        if nums.count == 0 {
            return []
        }
        
        for i in 0..<(nums.count - 1) {
            for j in (i + 1)..<nums.count {
                let val = nums[i] + nums[j]
                if val == target {
                    return [nums[i], nums[j]]
                }
            }
        }
        
        return []
    }
    
    // 2、（本题的 nums 是 排序数组）双指针，左右查找
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        if nums.count == 0 {
            return []
        }
        
        var l = 0, r = nums.count - 1
        while l < r {
            let sum = nums[l] + nums[r]
            if sum > target {
                // 说明右侧值大了，右指针向左移动
                r -= 1
            } else if sum < target {
                // 说明左侧值小了，左指针向右移动
                l += 1
            } else {
                return [nums[l], nums[r]]
            }
        }
        
        return []
    }
    
    //MARK: - 剑指 Offer 57 - II. 和为s的连续正数序列
    /**
     题目：输入一个正整数 target ，输出所有和为 target 的连续正整数序列（至少含有两个数）。
     序列内的数字由小到大排列，不同序列按照首个数字从小到大排列。
     输入：target = 9
     输出：[[2,3,4],[4,5]]
     
     分析：滑动窗口思想
     1、左边界最大值限制 limit = target / 2 比如：9 = 4 + 5，其中 左指针l 最大 = 4
     2、调整左右边界，获取有效序列
     3、得到一次有效结果后，调整左边界，继续下一次查询
     */
    func findContinuousSequence(_ target: Int) -> [[Int]] {
        var ans = [[Int]]()
        
        var l = 1, r = 1, sum = 0, limit = target / 2
        while l <= limit {
            if sum < target {
                // 右边界向右移动（窗口右边界向右滑动）
                sum += r
                r += 1
            } else if sum > target {
                // 左边界向右移动, 减去左边界的值（窗口左边界向右滑动）
                sum -= l
                l += 1
            } else {
                // sum == target, 此时边界位置 [l,r）
                var seq = [Int]()
                for i in l..<r {
                    seq.append(i)
                }
                // 得到一个符合条件的序列
                ans.append(seq)
                
                // 左边界向右移动，继续使用新的左边界起始的新窗口去查询另一个序列
                sum -= l
                l += 1
            }
        }
        
        return ans
    }
    
    //MARK: - 剑指 Offer 52. 两个链表的第一个公共节点
    // LeetCode原题不支持Swift输入
    /**
     双指针思想：两个链表分别向后遍历，若nodeA较短，nodeA结束了就指向nodeB头结点，如果两个链表有相交，nodeB结束之前，nodeA一定会赶上nodeB
     */
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        if headA == nil || headB == nil {
            return nil
        }
        
        var nodeA = headA
        var nodeB = headB
        while nodeA !== nodeB {
            nodeA = (nodeA == nil) ? nodeB : nodeA?.next
            nodeB = (nodeB == nil) ? nodeA : nodeB?.next
        }
        
        return nodeA
    }
    
    //MARK: - 剑指 Offer 68 - II. 二叉树的最近公共祖先
    //MARK: - 236. 二叉树的最近公共祖先
    /**
     题目：给定一个二叉树, 找到该树中两个指定节点的最近公共祖先。
     百度百科中最近公共祖先的定义为：“对于有根树 T 的两个节点 p、q，最近公共祖先表示为一个节点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（一个节点也可以是它自己的祖先）。”
     */
    // 递归遍历: 左 or 右 or 本身 （不好理解）
    func lowestCommonAncestorOfficial(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        if root == nil || root === p || root === q {
            return root
        }
        
        let left = lowestCommonAncestor(root?.left, p, q)
        let right = lowestCommonAncestor(root?.right, p, q)
        if left != nil, right != nil {
            return root
        }
        
        if left != nil {
            return left
        } else {
            return right
        }
    }
    
    // DFS思想
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        // root为空
        if root == nil {
            return nil
        }
        
        // 如果该节点就是左右节点中的一个，那么显然该节点就是答案
        if root === p || root === q {
            return root
        }
        
        // 【整个过程为后续遍历过程】
        // 【左】
        // 1、分解为左子树的子问题
        let left = lowestCommonAncestor(root?.left, p, q)
        
        // 【右】
        // 2、分解为右子树的子问题
        let right = lowestCommonAncestor(root?.right, p, q)
        
        // 【中】
        // 3、如果左子树和右子树都得到结果，那么该节点即为公共祖先
        if left != nil, right != nil {
            return root
        }
        
        if left != nil {
            // 4、如果只有左子树有结果，那么证明左子树得到的节点即为公共祖先（p、q均在左子树）
            return left
        } else {
            // 5、反之为右子树得到的结果
            return right
        }
    }
    
    //MARK: - 剑指 Offer 68 - I. 二叉搜索树的最近公共祖先
    /**
     二叉搜索树特性：左子树比根节点小，右子树比根节点大。
     一次遍历法：利用BST性质，根据节点val的大小判断左右子树
     
     分析：
     1、q < cur, p < cur。说明p、q 应该在当前节点的左子树，因此将当前节点移动到它的左子节点。
     2、q > cur,  p < cur。说明p、q 应该在当前节点的右子树，因此将当前节点移动到它的左子节点。
     3、如果当前节点的值不满足上述两条要求，那么说明当前节点就是「分岔点」。此时，p、q 要么在当前节点的左右不同子树中，要么其中一个就是当前节点。
     4、递归得到最终分岔点。
     */
    func lowestCommonAncestorBST(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        var ancestor = root
        while true {
            if p!.val < ancestor!.val, q!.val < ancestor!.val  {
                // 说明p、q 应该在当前节点的左子树，因此将当前节点移动到它的左子节点
                ancestor = ancestor?.left
            } else if p!.val > ancestor!.val, q!.val > ancestor!.val {
                // 说明p、q 应该在当前节点的右子树，因此将当前节点移动到它的左子节点
                ancestor = ancestor?.right
            } else {
                // 如果当前节点的值不满足上述两条要求，那么说明当前节点就是「分岔点」。此时，p、q 要么在当前节点的左右不同子树中，要么其中一个就是当前节点。
                break;
            }
        }
        return ancestor
    }
    
    //MARK: - 剑指 Offer 54. 二叉搜索树的第k大节点
    /**
     二叉搜索树特点：右子树 > root > 左子树
     1、从大到小排序，然后取第k个元素
     2、对二叉搜索树 中序遍历 左-中-右，再从后取值
     */
    var bstArr = [Int]()
    
    func kthLargest1(_ root: TreeNode?, _ k: Int) -> Int {
        if root == nil {
            return 0
        }
        
        inOrder1(root)
        return bstArr[bstArr.count - k]
    }
    
    func inOrder1(_ root: TreeNode?) {
        if root == nil {
            return
        }
        
        inOrder1(root?.left)
        bstArr.append(root!.val)
        inOrder1(root?.right)
    }
    
    /**
     二叉搜索树特点：右子树 > root > 左子树
     1、从大到小排序，然后取第k个元素
     2、对二叉搜索树 中序遍历倒序 右-中-左，获取k的位置，取值
     */
    var dfsIndex = 0
    var largest = 0
    
    func kthLargest(_ root: TreeNode?, _ k: Int) -> Int {
        if root == nil {
            return 0
        }
        
        dfs(root, k)
        return largest
    }
    
    func dfs(_ root: TreeNode?, _ k: Int) {
        if root == nil {
            return
        }
        
        dfs(root?.right, k)
        dfsIndex += 1
        if dfsIndex == k {
            largest = root!.val
            return
        }
        dfs(root?.left, k)
    }
    
    //MARK: - 剑指 Offer 55 - II. 平衡二叉树
    /**
     平衡二叉树的定义是：二叉树的每个节点的左右子树的高度差的绝对值不超过 1，则二叉树是平衡二叉树。
     1、首先计算左右子树的高度，判断左右子树的高度差是否不超过 1
     2、再分别递归遍历左右子节点，并判断左子树和右子树是否平衡
     */
    func isBalanced(_ root: TreeNode?) -> Bool {
        if root == nil {
            return true
        }
        
        return abs(height(root?.left) - height(root?.right)) < 2 && isBalanced(root?.left) && isBalanced(root?.right)
    }
    
    func height(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        return max(height(root?.left), height(root?.right)) + 1
    }
    
    //MARK: - 剑指 Offer 58 - I. 翻转单词顺序
    // 双指针: 连续子序列的情况 - 要么动态窗口，要么双指针
    func reverseWords(_ s: String) -> String {
        if s.count == 0 {
            return s
        }
        
        var ans = String()
        // 删除首尾空格
        let ss = s.trimmingCharacters(in: [" "])
        
        // l指向单词开头，起始位置为字符串右侧
        var l = ss.count - 1
        // r指向单词结尾
        var r = ss.count - 1
        
        // 倒序遍历
        while(l >= 0) {
            // 向前查找第一个空格
            while l >= 0, ss[l] != " " {
                l -= 1
            }
            
            // 添加单词
            let word = ss[l+1..<r+1] + " "
            ans.append(word)
            
            // 跳过单词间空格
            while l >= 0, ss[l] == " " {
                l -= 1
            }
            
            // r 指向下个单词的尾字符
            r = l;
        }
        
        return ans
    }
    
    //MARK: - 剑指 Offer 53 - I. 在排序数组中查找数字 I
    /**
     题目：统计一个数字在排序数组中出现的次数。
     输入: nums = [5,7,7,8,8,10], target = 8
     输出: 2
     */
    
    /**
     解决方法：
     way1、找到目标值「首次」出现的分割点，并「往后」进行统计
     way2、经过两次「二分」找到左右边界，计算总长度
     */
    func search(_ nums: [Int], _ target: Int) -> Int {
        var l = 0, r = nums.count - 1
        // 找到目标值「首次」出现的分割点
        while l <= r {
            let mid = l + (r - l) >> 1
            if nums[mid] >= target {
                r = mid - 1
            } else {
                l = mid + 1
            }
        }
        
        //「往后」进行统计
        var ans = 0
        for i in l..<nums.count {
            if nums[i] == target {
                ans += 1
            }
        }
        
        return ans
    }
    
    //MARK: - 剑指 Offer 53 - II. 0～n-1中缺失的数字
    /**
     题目：一个长度为n-1的递增排序数组中的所有数字都是唯一的，并且每个数字都在范围0～n-1之内。在范围0～n-1内的n个数字中有且只有一个数字不在该数组中，请找出这个数字。
     输入: [0,1,3]
     输出: 2
     */
    /**
     一、【二分法】解析：
     1、排序数组中的搜索问题，首先想到 【二分法】 解决
     2、左子数组：nums[i] = i
     3、右子数组：nums[i] != i
     思路：左侧 < 缺失的数字 < 右侧
     缺失的数字等于 “右子数组的首位元素” 对应的索引；因此考虑使用二分法查找 “右子数组的首位元素” 。
     */
    // 时间复杂度：O(logn)
    func missingNumberBS(_ nums: [Int]) -> Int {
        var l = 0, r = nums.count - 1
        while l <= r {
            let mid = l + (r - l) >> 1
            if nums[mid] == mid {
                // mid左侧都顺序，归为左子数组
                l = mid + 1
            } else {
                // mid已经处在右子树组了，向左缩小边界范围
                r = mid - 1
            }
        }
    
        return l
    }
    
    /**
     二、暴力法：只要比较数组下标和该下标对应的值即可，再排除 缺失0 和 缺失最后一项 两个特殊情况。
     */
    // 时间复杂度：O(n)
    func missingNumber(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        
        if nums[0] == 1 {
            return 0
        }
        
        for i in 0..<nums.count {
            if nums[i] != i {
                return i
            }
        }
    
        return nums.count
    }
    
    //MARK: - 剑指 Offer 58 - II. 左旋转字符串
    /**
     字符串的左旋转操作是把字符串前面的若干个字符转移到字符串的尾部。
     请定义一个函数实现字符串左旋转操作的功能。比如，输入字符串"abcdefg"和数字2，该函数将返回左旋转两位得到的结果"cdefgab"。
     */
    // 字符串切片
    func reverseLeftWords1(_ s: String, _ n: Int) -> String {
        return s[n..<s.count] + s[0..<n]
    }
    
    //MARK: - 剑指 Offer 62. 圆圈中最后剩下的数字
    /**
     题目：0 到 n-1这n个数字排成一个圆圈，从数字0开始，每次从这个圆圈里删除第m个数字（删除后从下一个数字开始计数）。
     求出这个圆圈里剩下的最后一个数字。
     例如，0、1、2、3、4这5个数字组成一个圆圈，从数字0开始每次删除第3个数字，则删除的前4个数字依次是2、0、4、1，因此最后剩下的数字是3。
     输入: n = 5, m = 3
     输出: 3
     
     【约瑟夫环问题】
     实际画图递推分析一下总结规律
     */
    func lastRemaining(_ n: Int, _ m: Int) -> Int {
        var ans = 0
        // 最后一轮剩下2个人，所以从2开始反推
        for i in 2...n {
            ans = (ans + m) % i
        }
        return ans
    }
    
    //MARK: - 剑指 Offer 61. 扑克牌中的顺子
    /**
     题目：从若干副扑克牌中随机抽 5 张牌，判断是不是一个顺子，即这5张牌是不是连续的。2～10为数字本身，A为1，J为11，Q为12，K为13，而大、小王为 0 ，可以看成任意数字。A 不能视为 14。

     分析：（顺子特性）
     1、大王、小王 可当任意的牌，直接跳过以下逻辑处理
     2、不能有重复的牌
     3、最大牌 - 最小牌 < 5 则可构成顺子
     */
    func isStraight(_ nums: [Int]) -> Bool {
        var repeatSet = Set<Int>()
        var minVal = 14, maxVal = 0
        
        for num in nums {
            // 跳过大小王
            if num == 0 {
                continue
            }
            maxVal = max(maxVal, num) // 最大牌
            minVal = min(minVal, num) // 最小牌
            
            // 若有重复，提前返回 false
            if repeatSet.contains(num) {
                return false
            }
            repeatSet.insert(num)
        }
        
        // 最大牌 - 最小牌 < 5 则可构成顺子
        return (maxVal - minVal) < 5
    }
        
}

extension String {
    /// String使用下标截取字符串
    /// string[index] 例如："abcdefg"[3] // c
    subscript (i:Int)->String{
        let startIndex = self.index(self.startIndex, offsetBy: i)
        let endIndex = self.index(startIndex, offsetBy: 1)
        return String(self[startIndex..<endIndex])
    }
    
    /// String使用下标截取字符串
    /// string[index..<index] 例如："abcdefg"[3..<4] // d
    subscript (range: Range<Int>) -> String {
        get {
            // 越界
            if range.lowerBound < 0 || range.upperBound > self.count {
                return ""
            }
            // 上限 < 下限
            if  range.upperBound < range.lowerBound {
                return ""
            }
            let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: range.upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
}
