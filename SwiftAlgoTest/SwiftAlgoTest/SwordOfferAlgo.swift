//
//  SwordOfferAlgo.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/9/14.
//

import Foundation

class SwordOfferAlgo {
    
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
    // 二分查找
    func minArray(_ numbers: [Int]) -> Int {
        if numbers.count == 0 {
            return 0
        }
        
        var low = 0
        var high = numbers.count - 1
        while low < high {
            let mid = low + (high - low) >> 1
            if numbers[mid] < numbers[high] {
                high = mid
            } else if numbers[mid] > numbers[high] {
                low = mid + 1
            } else {
                // numbers[mid] == numbers[high]
                high -= 1
            }
        }
        
        return numbers[low]
    }
    
    
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
    // 双指针交互元素
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
    // 超时
    func findRepeatNumber1(_ nums: [Int]) -> Int {
        var tmpArr = [Int]()
        for item in nums {
            if tmpArr.contains(item) {
                return item
            }
            tmpArr.append(item)
        }
        
        return -1
    }
    
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
        
        var queue = [TreeNode]()
        queue.append(root!)
        while queue.count > 0 {
            
            var lines = [Int]()
            var lineLen = queue.count
            while lineLen > 0 {
                lineLen -= 1

                let node = queue.first
                lines.append(node!.val)
                queue.removeFirst()
                                
                if let left = node!.left {
                    queue.append(left)
                }
                
                if let right = node!.right {
                    queue.append(right)
                }
            }
            
            ans.append(lines)
        }
        
        return ans
    }
    
    //MARK: - 剑指 Offer 50. 第一个只出现一次的字符
    /**
     首次遍历数组，字典存储元素出现次数；再次遍历数组，取出第一个 val == 1 的元素
     */
    func firstUniqChar(_ s: String) -> Character {
        let defaultVal: Character = " "
        if s.count == 0 {
            return defaultVal
        }
        
        var dic = [Character: Int]()
        for ch in s {
            var count = dic[ch] ?? 0
            count += 1
            dic[ch] = count
        }
        
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
     深度优先级遍历
     left，right 分别递归，取最大值 + 1
     */
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        
        return max(maxDepth(root?.left), maxDepth(root?.right)) + 1
    }
    
    //MARK: - 剑指 Offer 57. 和为s的两个数字
    // 超时
    func twoSumNO(_ nums: [Int], _ target: Int) -> [Int] {
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
    
    // （本题的 nums 是 排序数组）双指针，左右查找
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        if nums.count == 0 {
            return []
        }
        
        var l = 0, r = nums.count - 1
        while l < r {
            let sum = nums[l] + nums[r]
            if sum > target {
                r -= 1
            } else if sum < target {
                l += 1
            } else {
                return [nums[l], nums[r]]
            }
        }
        
        return []
    }
    
    //MARK: - 剑指 Offer 57 - II. 和为s的连续正数序列
    // 滑动窗口思想
    func findContinuousSequence(_ target: Int) -> [[Int]] {
        var ans = [[Int]]()
        
        var l = 1, r = 1, sum = 0, limit = target / 2
        while l <= limit {
            if sum < target {
                // 右边界向右移动
                sum += r
                r += 1
            } else if sum > target {
                // 左边界向右移动, 减去左边界的值
                sum -= l
                l += 1
            } else {
                // sum == target, 此时边界位置 [l,r）
                var seq = [Int]()
                for i in l..<r {
                    seq.append(i)
                }
                
                ans.append(seq)
                
                // 左边界向右移动
                sum -= l
                l += 1
            }
        }
        
        return ans
    }
    
    //MARK: - 剑指 Offer 52. 两个链表的第一个公共节点
    // 原题不支持swift
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
    // 递归遍历: 左 or 右 or 本身
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
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
    
    //MARK: - 剑指 Offer 68 - I. 二叉搜索树的最近公共祖先
    func lowestCommonAncestorBST(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        var ancestor = root
        while true {
            if p!.val < ancestor!.val, q!.val < ancestor!.val  {
                ancestor = ancestor?.left
            } else if p!.val > ancestor!.val, q!.val > ancestor!.val {
                ancestor = ancestor?.right
            } else {
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
     1、首先计算左右子树的高度，如果左右子树的高度差是否不超过 1
     2、再分别递归地遍历左右子节点，并判断左子树和右子树是否平衡
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
     排序数组中的搜索问题，首先想到 二分法 解决
     左侧 < 缺失的数字 < 右侧
     */
    func missingNumber(_ nums: [Int]) -> Int {
        var l = 0, r = nums.count - 1
        while l <= r {
            let mid = l + (r - l) >> 1
            if nums[mid] == mid {
                l = mid + 1
            } else {
                r = mid - 1
            }
        }
    
        return l
    }
    
    //MARK: - 剑指 Offer 58 - II. 左旋转字符串
    func reverseLeftWords(_ s: String, _ n: Int) -> String {
        return s[n..<s.count] + s[0..<n]
    }
    
    //MARK: - 剑指 Offer 62. 圆圈中最后剩下的数字
    func lastRemaining(_ n: Int, _ m: Int) -> Int {
        var ans = 0
        for i in 2...n {
            ans = (ans + m) % i
        }
        return ans
    }
    
    //MARK: - 剑指 Offer 61. 扑克牌中的顺子
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
