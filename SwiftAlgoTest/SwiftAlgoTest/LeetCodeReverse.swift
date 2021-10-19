//
//  LeetCodeReverse.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/10/15.
//

import Foundation

class LeetCodeReverse {
    
    //MARK: - 7. 整数反转
    /**
     题目：给你一个 32 位的有符号整数 x ，返回将 x 中的数字部分反转后的结果。
     条件：如果反转后整数超过 32 位的有符号整数的范围 [−231,  231 − 1] ，就返回 0。
     示例分析：
     1、用 % 10 取余，依次加入队列
     输入：x = 123
     输出：321
     
     2、负号保留（实际无需判断）
     输入：x = -123
     输出：-321
     
     3、原数字结尾为0，则忽略（步骤1中队列元素依次 * 10 累加）
     输入：x = 120
     输出：21
     */
    func reverse(_ x: Int) -> Int {
        // 1、32位整数限制
        var limitX: Int32 = Int32(x)
        
        // 2、保留符号
        var sign: Int32 = 1
        if limitX < 0 {
            sign = -1
        }
        
        // 3、倒序数字
        // 去除符号，取数字绝对值
        limitX = abs(limitX)
        var arr = [Int32]()
        while limitX > 0 {
            // 得到最后一位：321 -> 1
            let cur = limitX % 10
            // 去掉最后一位：321 -> 32
            limitX = limitX / 10
            arr.append(cur)
        }
        
        var ans: Int32 = 0
        for num in arr {
            // 前置判断条件
            if ans < Int32.min / 10 || ans > Int32.max / 10 {
                ans = 0
                break
            }
            
            ans = ans * 10 + num
        }
        
        // 恢复符号
        ans *= sign
        return Int(ans)
    }
    
    /**
     官方解答：
     1、无需判断正负号
     2、弹出 x 的末尾数字 digit
     3、将数字 digit 推入 rev 末尾
     */
    func reverseOfficial(_ x: Int) -> Int {
        // 32位整数限制
        var limitX: Int32 = Int32(x)
        
        var rev: Int32 = 0
        
        // 终止条件为 x = 0, 若x/10 = 0，说明已经没有更多数字
        while limitX != 0 {
            // 前置限制条件，防止crash：如果当前rev命中条件，说明下一次计算后一定会溢出
            if rev < Int32.min / 10 || rev > Int32.max / 10 {
                rev = 0
                break
            }
            
            // 得到最后一位：321 -> 1
            let digit = limitX % 10
            // 去掉最后一位：321 -> 32
            limitX = limitX / 10
            
            // 直接开始计算rev
            rev = rev * 10 + digit
        }

        return Int(rev)
    }

    //MARK: - 9. 回文数
    /**
     题目：给你一个整数 x ，如果 x 是一个回文整数，返回 true ；否则，返回 false 。
     回文数是指正序（从左向右）和倒序（从右向左）读都是一样的整数。例如，121 是回文，而 123 不是。
     示例：
     
     输入：x = 121
     输出：true
     
     (负数直接false)
     输入：x = -121
     输出：false
     */
    func isPalindrome(_ x: Int) -> Bool {
        if x < 0 {
            return false
        }
        
        // 数组 + 双指针
        var numX = x
        // 数字 -> 数组
        var nums = [Int]()
        while numX != 0 {
            let digit = numX % 10
            numX = numX / 10
            nums.append(digit)
        }
        
        // 双指针
        var l = 0, r = nums.count - 1
        while l <= r {
            if nums[l] != nums[r] {
                return false
            }
            l += 1
            r -= 1
        }
        
        return true
    }
    
    /**
     其他题解：
     1、反转数字，比较反转后数字 = 原数字
     2、取出后半段数字进行翻转（官方）
     */
    func isPalindromeReverseNum(_ x: Int) -> Bool {
        if x < 0 {
            return false
        }
        
        var numX = x
        var reverseNum = 0
        while numX > 0 {
            let digit = numX % 10
            numX /= 10
            reverseNum = reverseNum * 10 + digit
        }
        
        return reverseNum == numX
    }
    
    // 时间复杂度：O(logn)，空间复杂度：O(1)
    func isPalindromeReverseHalfNumOfficial(_ x: Int) -> Bool {
        // 负数false
        if x < 0 {
            return false
        }
        
        // 如果数字的最后一位是 0，为了使该数字为回文，则其第一位数字也应该是 0，只有 0 满足这一属性
        if x % 10 == 0, x != 0 {
            return false
        }
        
        var numX = x
        var reverseHalfNum = 0
        // 终止条件：131 -> 1 < 31 终止；1331 -> 13 < 31 终止
        while numX > reverseHalfNum {
            let digit = numX % 10
            numX /= 10
            reverseHalfNum = reverseHalfNum * 10 + digit
        }
        
        // 注意奇数偶数位数
        return numX == reverseHalfNum || numX == reverseHalfNum / 10
    }
    
    //MARK: - 8. 字符串转换整数 (atoi)
    /**
     示例分析：
     1、规范数据
     输入：s = "42"
     输出：42
     
     2、忽略空格，保留正负号
     输入：s = "   -42"
     输出：-42
     
     3、起始位置是数字，读取数字
     输入：s = "4193 with words"
     输出：4193
     
     4、起始位置是字母，不合法（结合3、4，需校验起始位置是否为数字）
     输入：s = "words and 987"
     输出：0
     
     5、题目条件：如果整数数超过 32 位有符号整数范围，需要截断这个整数，使其保持在这个范围内。返回Int32数字范围边界。
     输入：s = "-91283472332"
     输出：-2147483648
     */
    func myAtoi(_ s: String) -> Int {
        // 0、特殊情况处理
        if s.count == 0 {
            return 0
        }
        
        // 1、字符 -> 数组
        var sArr = [String]()
        for c in s {
            let char = String(c)
            // 去除空格字符
            if char != " " {
                sArr.append(char)
            }
        }
        
        // 特殊情况处理: 字符串全为空格
        if sArr.count == 0 {
            return 0
        }
        
        // 2、获取符号位，取首字符判断，同时移除符号位
        var sign = 1
        let signChar = sArr[0]
        if signChar == "-" {
            sign = -1
            sArr.removeFirst()
        } else if signChar == "+" {
            sArr.removeFirst()
        }
        
        // 3、遍历数组
        var ans: Int32 = 0
        for c in sArr {
            
            guard let intChar = Int32(c) else {
                break
            }
            
            // 判断是否为合法字符
            if intChar < 0 || intChar > 9 {
                break
            }
            
            // 前置判断是否越界（ans不包含符号，只需判断是否超出上边界）
            if ans > Int32.max / 10 {
                ans = Int32.max
                break
            }
            
            ans = ans * 10 + intChar
        }
        
        // 恢复正负号
        return Int(ans) * sign
    }
    
    //MARK: - 344. 反转字符串
    /**
     题目：编写一个函数，其作用是将输入的字符串反转过来。输入字符串以字符数组 s 的形式给出。
     要求：不要给另外的数组分配额外的空间，你必须原地修改输入数组、使用 O(1) 的额外空间解决这一问题。
     示例：
     输入：s = ["h","e","l","l","o"]
     输出：["o","l","l","e","h"]
     */
    func reverseString(_ s: inout [Character]) {
        // 无需反转
        if s.count < 2 {
            return
        }
        
        // 双指针
        var l = 0, r = s.count - 1
        while l <= r {
            s.swapAt(l, r)
            l += 1
            r -= 1
        }
    }
    
    //MARK: - 541. 反转字符串 II
    /**
     题目：给定一个字符串 s 和一个整数 k，从字符串开头算起，每计数至 2k 个字符，就反转这 2k 字符中的前 k 个字符。
     条件：
     1、如果剩余字符少于 k 个，则将剩余字符全部反转。
     2、如果剩余字符小于 2k 但大于或等于 k 个，则反转前 k 个字符，其余字符保持原样。
     
     示例：
     解析：k = 2 -> 2k = 4 -> 移动4位，abcd efg -> 反转前2个，bacd efg -> 剩余字符数量 3，满足条件2 -> 反转前2个，bacd feg
     输入：s = "abcdefg", k = 2
     输出："bacdfeg"
     
     解析：k = 2 -> 2k = 4 -> 移动4位，abcd -> 反转前2个，bacd -> 剩余字符数量 0，满足条件1 -> 剩余字符全部反转
     输入：s = "abcd", k = 2
     输出："bacd"
     */
    /**
     思路：双指针，标识左右边界
     1、确定好左右区间的索引下标。然后进行字符串的翻转。
     2、右区间要和字符串的长度做比较，取两者之间的小值。
     */
    func reverseStr(_ s: String, _ k: Int) -> String {
        var chars = [Character]()
        for c in s {
            chars.append(c)
        }
        
        var l = 0
        while l < chars.count {
            let r = l + k - 1
            reverseChars(&chars, left: l, right: min(r, chars.count - 1))
            l += 2*k
        }
        
        return String(chars)
    }
    
    func reverseChars(_ chars: inout [Character], left: Int, right: Int) {
        var l = left, r = right
        while l < r {
            chars.swapAt(l, r)
            l += 1
            r -= 1
        }
    }
    
}
