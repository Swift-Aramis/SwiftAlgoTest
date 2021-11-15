//
//  LeetCodeString.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/9/3.
//

import Foundation

extension LeetCode {
    
    func testStringAlgo() {
        // 无重复字符的最长子串
//        let count = lengthOfLongestSubstring("abcabcbb")
//        print(count)
        
//        let count2 = lengthOfLongestSubstring("bbbbb")
//        print(count2)
        
//        let count3 = lengthOfLongestSubstring("pwwkew")
//        print(count3)
        
//        let count4 = lengthOfLongestSubstring(" ")
//        print(count4)
        
//        let count5 = lengthOfLongestSubstring("au")
//        print(count5)
        
//        let count6 = lengthOfLongestSubstring("aau")
//        print(count6)
        
        //最长连续序列
//        let longest = longestConsecutive([100,4,200,1,3,2])
//        let longest = longestConsecutive([0,3,7,2,5,8,4,6,0,1])
//        let longest = longestConsecutive1([0,3,7,2,5,8,4,6,0,1])
//        print(longest)
        
        //  最长回文子串
        let longest = longestPalindrome("ababa")
        print(longest)
    }
    
    //MARK: - 128. 最长连续序列
    
    // 注意：未排序的数组
    /**
     哈希表方法
     1、set去重；
     2、判断是否set中存在cur +1的元素，存在就累计；
     3、终止条件：若存在cur -1的元素，说明该元素不是子序列起始元素，不能处理
     */
    
    /**
     O(n)时间复杂度分析：
     外层循环需要O(n)的时间复杂度，
     只有当一个数是连续序列的第一个数的情况下才会进入内层循环，然后在内层循环中匹配连续序列中的数，
     因此数组中的每个数只会进入内层循环一次
     */
    func longestConsecutive1(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        
        // 集合去重
        let sets = Set(nums)
        var ans = 0
        for num in sets {
            if !sets.contains(num - 1) { // 保证singleLen的累加起始于子序列初始
                var currentNum = num // 当前连续子序列初始值
                var currentStreak = 1 // 当前连续子序列初始长度
                
                // 持续循环，直到后续元素断开
                while sets.contains(currentNum + 1) {
                    currentNum += 1
                    currentStreak += 1
                }
                ans = max(ans, currentStreak)
            }
        }
        
        return ans
    }
    
    // 不符合O(n)时间复杂度要求
    func longestConsecutiveSorted(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        
        let sets = Set(nums)
        // 先排序
        let sortedNums = sets.sorted(by: { $0 < $1 })
        var left = 0
        var right = 0
        var maxLen = 1
        for i in 1..<sortedNums.count {
            let cur = sortedNums[i]
            let pre = sortedNums[i - 1]
            if cur == pre + 1 {
                right += 1
            } else {
                left = i
                right = i
            }
            maxLen = max(maxLen, right - left + 1)
        }
        
        return maxLen
    }
    
    //MARK: - 300. 最长递增子序列
    /**
     动态规划
     解析：默认每个元素作为子序列长度都是1，从前到后遍历每个元素，若该元素满足递增条件，取之前元素的递增子序列最大值加1即为截止到该元素所达到的最长递增子序列。
     状态转移方程：d[i] = max(d[j]) + 1
     例子：
     10 9 2 5 3 7 101
      1 1 1 1 1 1 1
      1 1 1 2 2 1 1
      1 1 1 2 2 3 4
     */
    func lengthOfLIS(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        
        var dp = Array(repeating: 1, count: nums.count)
        var ans = 0
        
        for i in 0..<nums.count {
            for j in 0..<i {
                if nums[j] < nums[i] {
                    dp[i] = max(dp[i], dp[j]+1)
                }
            }
            ans = max(ans, dp[i])
        }
        return ans
    }
    
    //MARK: - 5. 最长回文子串
    func longestPalindrome(_ s: String) -> String {
        var res = ""
        for i in 0..<s.count {
            let s1 = palindrome(s, i, i)
            let s2 = palindrome(s, i, i + 1)
            // res = longest(res, s1, s2)
            res = res.count > s1.count ? res : s1
            res = res.count > s2.count ? res : s2
        }
        return res
    }
    
    // 寻找回文串的问题核心思想是：从中间开始向两边扩散来判断回文串。
    // 回文特点：对称位置元素相等
    func palindrome(_ s: String, _ left: Int, _ right: Int) -> String {
        var l = left, r = right
        // 防止索引越界
        while l >= 0, r < s.count, s[l] == s[r] {
            // 向两边展开
            l -= 1
            r += 1
        }
        
        // 返回以s[l], s[r]为中心的回文子串
        let leftIndex = l + 1
        let rightIndex = r - 1
        if rightIndex < leftIndex {
            return ""
        }
        let startIndex = s.index(s.startIndex, offsetBy: leftIndex)
        let endIndex = s.index(s.startIndex, offsetBy: rightIndex)
        return String(s[startIndex...endIndex])
    }
    
    //MARK: - 剑指 Offer II 018. 有效的回文
    func isPalindrome(_ s: String) -> Bool {
        let validS = s.filter({ $0.isLetter || $0.isNumber })
        let lowS = validS.lowercased()

        var left = 0, right = lowS.count - 1
        while left <= right {
            if lowS[left] != lowS[right] {
                return false
            }
            left += 1
            right -= 1
        }

        return true
    }
    
    //MARK: - 剑指 Offer II 019. 最多删除一个字符得到回文
    func validPalindrome(_ s: String) -> Bool {
        let mid = s.count / 2
        let idx = checkPalindrome(s, 0, s.count - 1)
        if idx.l > mid {
            return true
        }
        
        // left跳过1
        let leftIdx = checkPalindrome(s, idx.l + 1, idx.r)
        
        // right跳过1
        let rightIdx = checkPalindrome(s, idx.l, idx.r - 1)
        
        let ans = leftIdx.l > mid || rightIdx.l == mid
        
        return ans
    }
    
    func checkPalindrome(_ s: String, _ left: Int, _ right: Int) -> (l: Int, r: Int) {
        var l = left
        var r = right
        while l <= r {
            if s[l] != s[r] {
                break
            } else {
                l += 1
                r -= 1
            }
        }
        return (l, r)
    }
    
    //MARK: - 剑指 Offer II 032. 有效的变位词
    func isAnagram(_ s: String, _ t: String) -> Bool {
        if s == t || s.count != t.count {
            return false
        }
        
        var map = [String: Int]()
        for c in s {
            let char = String(c)
            var count = map[char] ?? 0
            count += 1
            map[char] = count
        }
        
        for c in t {
            let char = String(c)
            var count = map[char] ?? 0
            if !map.keys.contains(char) || count == 0 {
                return false
            }
            count -= 1
            map[char] = count
        }
        
        return true
    }
    
    //MARK: - 3、无重复字符的最长子串
    /**
     给定一个字符串 s ，请你找出其中不含有重复字符的 最长子串 的长度。
     
     输入: s = "abcabcbb" => abc
     输出: 3
     解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。

     输入: s = "bbbbb" => b
     输出: 1
     
     输入: s = "pwwkew" => wke
     输出: 3
     
     输入: s = "" => nil
     输出: 0
     */
    
    /**
     题解：滑动窗口思想，从左到右滑动，滑动过程不断增加窗口大小
     */
    func lengthOfLongestSubstring(_ s: String) -> Int {
        guard s.count > 1 else {
            return s.count
        }
        
        // 记录每个字符是否出现过
        var map = [String: Int]()
        // 最大长度
        var maxLen = 0
        // 左指针
        var left = 0
        // 字符串下标位置
        var i = 0
        for char in s {
            let value = String(char)
            if map.keys.contains(value) {
                var lastIndex = map[value] ?? 0
                // 向后移动一位
                lastIndex += 1
                left = max(left, lastIndex)
            }
            map[value] = i
            maxLen = max(maxLen, i - left + 1)
            
            i += 1
        }
        
        return maxLen
    }

    //MARK: - 20. 有效的括号
    /**
     题目：给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串 s ，判断字符串是否有效。
     有效字符串需满足：
     左括号必须用相同类型的右括号闭合。
     左括号必须以正确的顺序闭合。
     
     示例：
     输入：s = "()"
     输出：true
     输入：s = "()[]{}"
     输出：true
     输入：s = "(]"
     输出：false
     输入：s = "([)]"
     输出：false
     输入：s = "{[]}"
     输出：true
     */
    func isValid(_ s: String) -> Bool {
        // s长度必须是偶数，才能保证括号对称
        if s.count % 2 != 0 {
            return false
        }
        
        let dict = [")": "(",
                    "]": "[",
                    "}": "{"]
        
        var stack = [String]()
        for c in s {
            let ch = String(c)
            if dict.keys.contains(ch) {
                if stack.isEmpty {
                    return false
                }
                if let top = stack.last, top != dict[ch] {
                    return false
                }
                _ = stack.popLast()
            } else {
                stack.append(ch)
            }
        }
        
        
        return stack.isEmpty
    }
    
    //MARK: - 581. 最短无序连续子数组
    // 双指针：left 右侧保证都比它大，right 左侧保证都比它小
    // numsA < numsB < numsC
    func findUnsortedSubarray1(_ nums: [Int]) -> Int {
        if nums.count < 2 {
            return 0
        }
        
        let n = nums.count
        
        var maxVal = Int.min, minVal = Int.max, left = -1, right = -1
        for i in 0..<n {
            if maxVal > nums[i] {
                right = i
            } else {
                maxVal = nums[i]
            }
            
            let reverseI = n - 1 - i
            if minVal < nums[reverseI] {
                left = reverseI
            } else {
                minVal = nums[reverseI]
            }
        }
        
        return right == -1 ? 0 : right - left + 1
    }
    
    // numsA < numsB < numsC
    // sortNums -> 与nums元素不同的位置即为numsB范围
    func findUnsortedSubarray(_ nums: [Int]) -> Int {
        if nums.count < 2 {
            return 0
        }
        
        let sortNums = nums.sorted()
        // 屏蔽本身就有序的nums，否则无法得到numsB
        if sortNums == nums {
            return 0
        }
        
        let n = nums.count - 1
        var left = 0, right = n
        
        while sortNums[left] == nums[left], left <= n {
            left += 1
        }
        
        while sortNums[right] == nums[right], right >= 0 {
            right -= 1
        }
       
        return right - left + 1
    }
    
    //MARK: - 剑指 Offer II 095. 最长公共子序列
    /**
     最长公共子序列（Longest Common Subsequence，简称 LCS）
     是一道非常经典的面试题目，因为它的解法是典型的二维动态规划。
     大部分比较困难的字符串问题都和这个问题一个套路，比如说编辑距离。
     
     第一步，一定要明确dp数组的含义。dp table （dp：Dynamic Programming）
     第二步，定义 base case。我们专门让索引为 0 的行和列表示空串，dp[0][..]和dp[..][0]都应该初始化为 0，这就是 base case。
     第三步，找状态转移方程。
     */
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        return 0
    }
    
    //MARK: - 14. 最长公共前缀
    /**
     题目：编写一个函数来查找字符串数组中的最长公共前缀。
     如果不存在公共前缀，返回空字符串 ""。

     示例：
     输入：strs = ["flower","flow","flight"]
     输出："fl"
     */
    
    /**
     题解：
     1、当字符串数组长度为 0 时则公共前缀为空，直接返回
     2、令最长公共前缀 ans 的值为第一个字符串，进行初始化
     3、遍历后面的字符串，依次将其与 ans 进行比较，两两找出公共前缀，最终结果即为最长公共前缀
     4、如果查找过程中出现了 ans 为空的情况，则公共前缀不存在直接返回
     5、时间复杂度：O(s)，s 为所有字符串的长度之和
     */
    func longestCommonPrefix(_ strs: [String]) -> String {
        if strs.count == 0 {
            return ""
        }
        
        var ans = strs.first!
        for i in 1..<strs.count {
            let str = strs[i]
            let len = min(ans.count, str.count)
            // 比较 ans 和 当前str
            var j = 0
            while j < len {
                if str[j] != ans[j] {
                    break
                }
                j += 1
            }
            ans = ans[0..<j]
            
            // 如果ans为空，说明已经遇到无公共前缀的字符串了，没必要继续遍历了
            if ans.count == 0 {
                return ""
            }
        }

        return ans
    }
    
    //MARK: - 8. 字符串转换整数 (atoi)
    //MARK: - 剑指 Offer 67. 把字符串转换成整数
    /**
     题目：写一个函数 StrToInt，实现把字符串转换成整数这个功能。不能使用 atoi 或者其他类似的库函数。

     首先，该函数会根据需要丢弃无用的开头空格字符，直到寻找到第一个非空格的字符为止。

     当我们寻找到的第一个非空字符为正或者负号时，则将该符号与之后面尽可能多的连续数字组合起来，作为该整数的正负号；
     假如第一个非空字符是数字，则直接将其与之后连续的数字字符组合起来，形成整数。

     该字符串除了有效的整数部分之后也可能会存在多余的字符，这些字符可以被忽略，它们对于函数不应该造成影响。

     注意：假如该字符串中的第一个非空格字符不是一个有效整数字符、字符串为空或字符串仅包含空白字符时，则你的函数不需要进行转换。

     在任何情况下，若函数不能进行有效的转换时，请返回 0。

     说明：
     假设我们的环境只能存储 32 位大小的有符号整数，那么其数值范围为 [−231,  231 − 1]。
     如果数值超过这个范围，请返回  INT_MAX (231 − 1) 或 INT_MIN (−231) 。
     */
    func strToInt(_ str: String) -> Int {
        // 特判
        guard str.count > 0 else {
            return 0
        }
        
        // 1、处理数据源：字符串 -> 数组
        var arr = [Character]()
        for c in str {
            // 去除空格
            if c != " " {
                arr.append(c)
            }
        }
        
        // 特判
        guard arr.count > 0 else {
            return 0
        }
        
        // 2、处理符号：首个元素
        var sign = 1
        let signElem = arr.first!
        if signElem == "+" {
            arr.removeFirst()
        } else if signElem == "-" {
            sign = -1
            arr.removeFirst()
        }
        
        // 3、处理元素
        var num = 0
        for ch in arr {
            // 数值范围判断
            if num > Int.max / 10 {
                num = Int.max
                break
            }
            
            let intCh = Int(String(ch)) ?? -1
            // 如果元素不是数字，结束循环
            if intCh < 0 || intCh > 9 {
                break
            }
            
            num = num * 10 + intCh
        }
        
        return sign * num
    }
    
}

class GenerateParenthesis {
    //MARK: - 22. 括号生成
    /**
     题目：数字 n 代表生成括号的对数，请你设计一个函数，用于能够生成所有可能的并且 有效的 括号组合。
     有效括号组合需满足：左括号必须以正确的顺序闭合。
     示例：
     输入：n = 3
     输出：["((()))","(()())","(())()","()(())","()()()"]
     输入：n = 1
     输出：["()"]
     */
    
    /**
     想破脑袋也想不出，算法都是有套路的。
     DFS： 深度优先遍历
    
     一、首先我们需要知道一个结论，一个合法的括号序列需要满足两个条件：
     1、左右括号数量相等
     2、任意前缀中左括号数量 >= 右括号数量 （也就是说每一个右括号总能找到相匹配的左括号）

     二、如何设计dfs搜索函数？
     最关键的问题在于搜索序列的当前位时，是选择填写左括号，还是选择填写右括号？
     1、因为我们已经知道一个合法的括号序列，任意前缀中 左括号数量一定 >= 右括号数量，因此，如果左括号数量不大于 n，我们就可以放一个左括号，来等待一个右括号来匹配。此时 + (
     2、如果右括号数量小于左括号的数量，我们就可以放一个右括号，来使一个右括号和一个左括号相匹配。此时 + )
     
     三、递归函数设计
     void dfs(int n ,int lc, int rc ,string str)
     n是括号对数，lc是左括号数量，rc是右括号数量，str是当前维护的合法括号序列。
     
     四、搜索过程如下：
     1、初始时定义序列的左括号数量lc和右括号数量rc都为0。
     2、如果 lc < n，左括号的个数小于n，则在当前序列str后拼接左括号。
     3、如果 rc < n && lc > rc , 右括号的个数小于左括号的个数，则在当前序列str后拼接右括号。
     4、当lc == n && rc == n 时，将当前合法序列str加入答案数组res中。
     */
    
    var res = [String]()
    
    func generateParenthesis(_ n: Int) -> [String] {
        dfs(n: n, lc: 0, rc: 0, str: "")
        return res
    }
    
    func dfs(n: Int, lc: Int, rc: Int, str: String) {
        // 递归边界
        if lc == n, rc == n {
            res.append(str)
            
        } else {
            // 拼接左括号
            if lc < n {
                dfs(n: n, lc: lc + 1, rc: rc, str: str + "(")
            }
            // 拼接右括号
            if rc < n, lc > rc {
                dfs(n: n, lc: lc, rc: rc + 1, str: str + ")")
            }
        }
    }
}
