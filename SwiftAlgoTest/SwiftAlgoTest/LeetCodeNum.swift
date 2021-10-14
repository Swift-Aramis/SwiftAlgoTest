//
//  LeetCodeNum.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/9/3.
//

import Foundation

extension LeetCode {
    
    func testNumAlgo() {
        // 1、两数之和
//        let nums = [2,7,11,15]
//        let target = 9 // nums[0] + nums[1] == 9
//        let result = twoSum(nums, target)
//        print(result)
        
        // 2、两数相加
//        输入：l1 = [2,4,3], l2 = [5,6,4]
//        输出：[7,0,8]
//        解释：342 + 465 = 807
        let l1 = generateLinkList(arr: [0,1])
        let l2 = generateLinkList(arr: [0,9,9])
//        let result = addTwoNumbers(l1, l2)
//        printLinkList(in: result!)
        
        let result2 = addTwoNumbers2(l1, l2)
        printLinkList(in: result2!)

    }
    
    //MARK: - 1、两数之和
    func twoSum2(_ nums: [Int], _ target: Int) -> [Int] {
        for i in 0..<(nums.count-1) {
            for j in (i+1)..<nums.count {
                let v = nums[i] + nums[j]
                if v == target {
                    return [nums[i], nums[j]]
                }
            }
        }
        
        return []
    }
    
    //MARK: - 剑指 Offer II 006. 排序数组中两个数字之和
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        for i in 0..<numbers.count - 1 {
            for j in i+1..<numbers.count {
                if numbers[i] + numbers[j] == target {
                    return [i, j]
                }
            }
        }
        
        return []
    }
    
    //MARK: - 剑指 Offer II 012. 左右两边子数组的和相等
    /**
     total - sum = sum - curVal 即  0...i-1 、i  、i+1...n
     */
    func pivotIndex(_ nums: [Int]) -> Int {
        var total = 0
        for num in nums {
            total += num
        }
        
        var sum = 0
        for i in 0..<nums.count {
            sum += nums[i]
            if total - sum == sum - nums[i] {
                return i
            }
        }
        
        return -1
    }
    
    
    //MARK: - 2、两数相加
    /**
     输入：l1 = [2,4,3], l2 = [5,6,4]
     输出：[7,0,8]
     解释：342 + 465 = 807
     
     分析：
     依次遍历相加；
     较长的链表为准；
     临时变量存储进一
     */
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var head1: ListNode? = l1
        var head2: ListNode? = l2
        
        let dummy = ListNode()
        var head: ListNode? = dummy
        
        // 依次遍历相加
        var ten = 0
        while head1 != nil, head2 != nil {
            let v1 = head1!.val
            let v2 = head2!.val
            let sum = v1 + v2 + ten
            ten = sum / 10
            let curV = sum % 10
            head1!.val = curV
            head!.next = head1
            
            head1 = head1!.next
            head2 = head2!.next
            head = head!.next
        }
        
        while head1 != nil {
            let v1 = head1!.val
            let sum = v1 + ten
            ten = sum / 10
            let curV = sum % 10
            head1!.val = curV
            head!.next = head1
            
            head1 = head1!.next
            head = head!.next
        }
        
        while head2 != nil {
            let v2 = head2!.val
            let sum = v2 + ten
            ten = sum / 10
            let curV = sum % 10
            head2!.val = curV
            head!.next = head2
            
            head2 = head2!.next
            head = head!.next
        }
        
        // 最后一位
        if ten == 1 {
            head!.next = ListNode(ten)
        }
        
        return dummy.next
    }
    
    func addTwoNumbers2(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var head1: ListNode? = l1
        var head2: ListNode? = l2
        let dummy = ListNode()
        var head: ListNode? = dummy
        
        var ten = 0
        while head1 != nil || head2 != nil {
            let v1 = head1?.val ?? 0
            let v2 = head2?.val ?? 0
            let sum = v1 + v2 + ten
            ten = sum / 10
            
            let curV = sum % 10
            head!.next = ListNode(curV)
            head = head!.next
            
            if head1 != nil {
                head1 = head1!.next
            }
            if head2 != nil {
                head2 = head2!.next
            }
        }
        
        if ten == 1 {
            head!.next = ListNode(ten)
        }
        
        return dummy.next
    }
    
    //MARK: - 53、最大子序和
    func maxSubArray(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        
        var ans = nums[0]
        var sum = 0
        for i in nums {
            if sum > 0 {
                sum += i
            } else {
                sum = i
            }
            ans = max(ans, sum)
        }

        return ans
    }
    
    func minSubArray(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        
        var ans = nums[0]
        var sum = 0
        for i in nums {
            if sum < 0 {
                sum += i
            } else {
                sum = i
            }
            ans = min(ans, sum)
        }

        return ans
    }
    
    /**
     最小子序列和：
     给定整数序列(有正有负) ，计算子序列的最小和，要求时间复杂度为o(n)
     
     算法分析：
     1、举例 [1, -1, 2, -4, 5] 的子序列
     
     1
     1，-1
     1，-1，2
     1，-1，2，-4
     1，-1，2，-4，5
     
     -1
     -1，2
     -1，2，-4
     -1，2，-4，5
     
     2
     2，-4
     2，-4，5
     
     -4
     -4，5
     
     5
     
     思考：
     子序列的累加应该是连续的元素相加，使用循环遍历依次向后
     
     框架：
     1、确认累加初始值
     2、遍历累加，累加过程中，更新最小和
     3、因为序列有负数，最小值一定为负，涉及到与0的比较
     */
    func minSubSequenceSub(_ arr: [Int]) -> Int {
        var currentSum = 0
        // 注意minSum不能初始化为0
        var minSum = arr.first!
        
        // 连续累加
        for i in 0..<arr.count {
            currentSum = minSum + arr[i]
            if currentSum < minSum {
                // 如果累加渐小，更新最小值，说明可以连续累加，子序列能够连续推进
                minSum = currentSum
            } else if currentSum > 0 {
                // 最小值一定为负，计算结果为正的情况，直接重置累加值
                currentSum = 0
            }
        }
        
        return minSum
    }
    
    //MARK: - 136. 只出现一次的数字
    func singleNumber(_ nums: [Int]) -> Int {
        var single = 0
        for num in nums {
            single ^= num
        }
        return single
    }
    
    //MARK: - 169. 多数元素
    // Boyer-Moore 投票算法
    func majorityElement(_ nums: [Int]) -> Int {
        var candidate = 0 // 候选人
        var count = 0 // 众数计数
        for num in nums {
            // 重新开启计数时，众数重新赋值
            if count == 0 {
                candidate = num
            }
            count += (candidate == num) ? 1 : -1
        }
        
        return candidate
    }
    
    //MARK: - 283. 移动零
    /**
     问题：给定一个数组 nums，编写一个函数将所有 0 移动到数组的末尾，同时保持非零元素的相对顺序。
     输入: [0,1,0,3,12]
     输出: [1,3,12,0,0]
     */
    
    /**
     使用双指针，左指针指向当前已经处理好的序列的尾部，右指针指向待处理序列的头部。
     右指针不断向右移动，每次右指针指向非零数，则将左右指针对应的数交换，同时左指针右移。
     
     注意到以下性质：
     1、左指针左边均为非零数；
     2、右指针左边直到左指针处均为零。
     因此每次交换，都是将左指针的零与右指针的非零数交换，且非零数的相对顺序并未改变。
     */
    func moveZeroes(_ nums: inout [Int]) {
        var left = 0, right = 0
        for i in 0..<nums.count {
            let val = nums[i]
            if val != 0 {
                // 将右侧不为零的数向前移动
                nums.swapAt(left, right)
                left += 1
            }
            right += 1
        }
    }
    
    //MARK: - 338. 比特位计数
    
    //MARK: - 448. 找到所有数组中消失的数字
    /**
     题目：给你一个含 n 个整数的数组 nums ，其中 nums[i] 在区间 [1, n] 内。请你找出所有在 [1, n] 范围内但没有出现在 nums 中的数字，并以数组的形式返回结果。
     输入：nums = [4,3,2,7,8,2,3,1]
     输出：[5,6]
     */
    /**
     第一步：遍历nums，每遇到一个数 x，就让 nums[x−1] 增加 n。=> 数字：1...n，下标：0...n-1
     由于 nums 中所有数均在 [1，n] 中，增加以后，这些数必然大于 n。
   
     第二步：再次遍历 nums，若nums[i] <= n，说明第一步中没有遇到过数字 i+1。这样我们就找到了缺失的数字。
     
     注意，当我们遍历到某个位置时，其中的数可能已经被增加过，因此需要对 n 取模来还原出它本来的值。
     */
    func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
        var array = nums
        let n = array.count
        /**
         举例思考：n = 5
         5   4   3   3   1
         10   0   13   8   6
         */
        for num in array {
            // 注意，当我们遍历到某个位置时，其中的数可能已经被增加过，因此需要对 n 取模来还原出它本来的值。
            // 因为数组中可能存在两个相等的值
            let x = (num - 1) % n
            array[x] += n
        }
        
        var ret = [Int]()
        for i in 0..<n {
            if array[i] <= n {
                ret.append(i+1)
            }
        }
       
        return ret
    }
    
    //MARK: - 349. 两个数组的交集
    /**
     输入：nums1 = [1,2,2,1], nums2 = [2,2]
     输出：[2]
     1、输出结果中的每个元素一定是唯一的
     2、我们可以不考虑输出结果的顺序
     */
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        // 优先遍历小的
        if nums1.count > nums2.count {
            return intersection(nums2, nums1)
        }
        
        let set1 = Set(nums1) // 2
        let set2 = Set(nums2) // 121
        var ans = [Int]()
        for i in set1 {
            if set2.contains(i) {
                ans.append(i)
            }
        }
     
        return ans
    }
    
    //MARK: - 350. 两个数组的交集 II
    /**
     输入：nums1 = [1,2,2,1], nums2 = [2,2]
     输出：[2,2]
     1、输出结果中每个元素出现的次数，应与元素在两个数组中出现次数的最小值一致。
     2、我们可以不考虑输出结果的顺序。
     */
    
    // 方法一：哈希表
    func intersectHash(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        // 优先遍历小的
        if nums1.count > nums2.count {
            return intersectHash(nums2, nums1)
        }
        var ans = [Int]()
        var dic = [Int: Int]()
        for num in nums1 {
            var count = dic[num] ?? 0
            count += 1
            dic[num] = count
        }
        
        for num in nums2 {
            var count = dic[num] ?? 0
            if count > 0 {
                count -= 1
                ans.append(num)
                if count > 0 {
                    dic[num] = count
                } else {
                    dic.removeValue(forKey: num)
                }
            }
        }
        
        return ans
    }
    
    // 方法二：排序 + 双指针
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        let numsA = nums1.sorted()
        let numsB = nums2.sorted()
        var ans = [Int]()
        var c1 = 0, c2 = 0
        while c1 < numsA.count, c2 < numsB.count {
            if numsA[c1] < numsB[c2] {
                c1 += 1
            } else if numsA[c1] > numsB[c2] {
                c2 += 1
            } else {
                ans.append(numsA[c1])
                c1 += 1
                c2 += 1
            }
        }
        
        return ans
    }
    
    //MARK: - 560. 和为 K 的子数组
    // 依次累加
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        if nums.count == 0 {
            return 0
        }
        
        var ans = 0
        for i in 0..<nums.count {
            var sum = 0
            for j in i..<nums.count {
                sum += nums[j]
                if sum == k {
                    ans += 1
                }
            }
        }
        
        return ans
    }
    
}
