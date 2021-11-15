//
//  LeetCodeNum.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/9/3.
//

import Foundation

extension LeetCode {
    
    func testNumAlgo() {

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
    
    // 官方解法
    func addTwoNumbersOfficial(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
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
    
    //MARK: - 53、最大子序和 & 剑指 Offer 42. 连续子数组的最大和
    /**
     题目：给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。
     示例：
     输入：nums = [-2,1,-3,4,-1,2,1,-5,4]
     输出：6
     解释：连续子数组 [4,-1,2,1] 的和最大，为 6 。
     
     【动态规划的思路】：首先对数组进行遍历，当前最大连续子序列和为 sum，结果为 ans
     1、如果 sum > 0，则说明 sum 对结果有增益效果，则 sum 保留并加上当前遍历数字
     2、如果 sum <= 0，则说明 sum 对结果无增益效果，需要舍弃，则 sum 直接更新为当前遍历数字
     3、每次比较 sum 和 ans的大小，将最大值置为ans，遍历结束返回结果
     4、时间复杂度：O(n)
     */
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
    
    //MARK: - 1403. 非递增顺序的最小子序列
    /**
     题目：给你一个数组 nums，请你从中抽取一个子序列，满足该子序列的元素之和 严格 大于未包含在该子序列中的各元素之和。
     如果存在多个解决方案，只需返回 长度最小 的子序列。如果仍然有多个解决方案，则返回 元素之和最大 的子序列。
     与子数组不同的地方在于，「数组的子序列」不强调元素在原数组中的连续性，也就是说，它可以通过从数组中分离一些（也可能不分离）元素得到。
     注意，题目数据保证满足所有约束条件的解决方案是 唯一 的。同时，返回的答案应当按 非递增顺序 排列。
     
     示例：
     输入：nums = [4,3,10,9,8]
     输出：[10,9]
     解释：子序列 [10,9] 和 [10,8] 是最小的、满足元素之和大于其他各元素之和的子序列。但是 [10,9] 的元素之和最大。

     输入：nums = [4,4,7,6,7]
     输出：[7,7,6]
     解释：子序列 [7,7] 的和为 14 ，不严格大于剩下的其他元素之和（14 = 4 + 4 + 6）。因此，[7,6,7] 是满足题意的最小子序列。注意，元素按非递增顺序返回。

     输入：nums = [6]
     输出：[6]
     
     分析：
     1、记所有元素之和为total，子序列的元素之和为sum，则未包含在该子序列中的各元素之和为total-sum。
     2、题目要找符合sum > total-sum且长度最短的子序列，
     3、因此应该先对数组进行排序，再从最大值开始往下找（这样才能保证子序列最短），依次加入元素到ans数组，直到sum > total-sum
     4、因为是降序加入元素的，所以ans必定是非递增的，直接return即可
     */
    
    func minSubsequence(_ nums: [Int]) -> [Int] {
        // 元素总和
        var total = 0
        for i in nums {
            total += i
        }
        // 子序列满足条件：元素之和 sum > total - sum & 长度最短 & 数值最大
        var ans = [Int]()
        var sum = 0
        
        // 降序排序
        let sortedArr = nums.sorted(by: {$0 > $1})
        // 从最大值开始找，依次加入元素
        for i in sortedArr {
            sum += i
            ans.append(i)
            
            // 符合sum > total - sum，则说明要求的子序列已找到
            if sum > total - sum {
                break
            }
        }
        
        return ans
    }
    
    //MARK: - 136. 只出现一次的数字
    /**
     题目：给定一个非空整数数组，除了某个元素只出现一次以外，其余每个元素均出现两次。找出那个只出现了一次的元素。
     说明：你的算法应该具有线性时间复杂度。 你可以不使用额外空间来实现吗？

     分析：如果不考虑时间复杂度和空间复杂度的限制，这道题有很多种解法，可能的解法有如下几种。
     1、使用集合存储数字。遍历数组中的每个数字，如果集合中没有该数字，则将该数字加入集合，如果集合中已经有该数字，则将该数字从集合中删除，最后剩下的数字就是只出现一次的数字。
     2、使用哈希表存储每个数字和该数字出现的次数。遍历数组即可得到每个数字出现的次数，并更新哈希表，最后遍历哈希表，得到只出现一次的数字。
     3、使用集合存储数组中出现的所有数字，并计算数组中的元素之和。由于集合保证元素无重复，因此计算集合中的所有元素之和的两倍，即为每个元素出现两次的情况下的元素之和。由于数组中只有一个元素出现一次，其余元素都出现两次，因此用集合中的元素之和的两倍减去数组中的元素之和，剩下的数就是数组中只出现一次的数字。
     */

    /**
     解答：使用位运算
     异或运算有以下三个性质
     1、任何数和 0 做异或运算，结果仍然是原来的数
     2、任何数和其自身做异或运算，结果是 0
     3、异或运算满足交换律和结合律
     
     因此，数组中的全部元素的异或运算结果即为数组中只出现一次的数字。
     */
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
    // 双层for循环，依次累加， sum == k
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
    
    //MARK: - 215. 数组中的第K个最大元素
    /**
     题目：给定整数数组 nums 和整数 k，请返回数组中第 k 个最大的元素。
     请注意，你需要找的是数组排序后的第 k 个最大的元素，而不是第 k 个不同的元素。
     示例：
     
     输入: [3,2,1,5,6,4] 和 k = 2
     输出: 5
     1 2 3 4 (5) 6
     
     输入: [3,2,3,1,2,4,5,5,6] 和 k = 4
     输出: 4
     1 2 2 3 3 (4) 5 5 6
     
     题目分析：本题希望我们返回数组排序之后的倒数第 k 个位置。
     */
    
    // 1、完整快排
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        
        var sortedArr = nums

        findKthLargest_quickSort(&sortedArr, left: 0, right: sortedArr.count - 1)
        
        return sortedArr[sortedArr.count - k]
    }
    
    func findKthLargest_quickSort(_ array: inout [Int], left: Int, right: Int) {
        if left >= right {
            return
        }
        
        let pivot = array[left]
        var l = left, r = right
        while l < r {
            while l < r, array[r] >= pivot {
                r -= 1
            }
            while l < r, array[l] <= pivot {
                l += 1
            }
            
            array.swapAt(l, r)
        }
        
        array.swapAt(left, l)
        
        findKthLargest_quickSort(&array, left: left, right: l - 1)
        findKthLargest_quickSort(&array, left: l + 1, right: right)
    }
    
    // 2、利用快速排序的 partition 分区来寻找数组第k大的数字
    /**
     解题思路：
     1、在长度为n的排序数组中，第k大的数字的下标是n-k
     2、用快速排序的函数partition对数组分区，如果函数partition选取的中间值在分区之后的下标正好是n-k，
     分区后左边的的值都比中间值小，右边的值都比中间值大，即使整个数组不是排序的，中间值也肯定是第k大的数字
     3、如果函数partition选取的中间值在分区之后的下标大于n-k，
     那么第k大的数字一定位于中间值的左侧，于是再对中间值的左侧的子数组分区
     4、如果函数partition选择的中间值在分区之后的下标小于n-k，
     那么第k大的数字一定位于中间值的右侧，于是再对中间值的右侧的子数组分区
     */
    func findKthLargestOfficial(_ nums: [Int], _ k: Int) -> Int {
        let targetIndex = nums.count - k
        var left = 0, right = nums.count - 1
        var sortedArr = nums
        var index = partition(&sortedArr, left: left, right: right)
        while index != targetIndex {
            if index > targetIndex {
                right = index - 1
            }
            if index < targetIndex {
                left = index + 1
            }
            index = partition(&sortedArr, left: left, right: right)
        }
        
        return sortedArr[index]
    }
    
    func partition(_ array: inout [Int], left: Int, right: Int) -> Int {
        let pivot = array[left]
        var l = left, r = right
        while l < r {
            while l < r, array[r] >= pivot {
                r -= 1
            }
            while l < r, array[l] <= pivot {
                l += 1
            }
            
            array.swapAt(l, r)
        }
        
        array.swapAt(left, l)
        
        return l
    }
    
    //MARK: - 15. 三数之和
    /**
     题目：给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？
     请你找出所有和为 0 且不重复的三元组。
     注意：答案中不可以包含重复的三元组。
     
     示例：
     输入：nums = [-1,0,1,2,-1,-4]
     输出：[[-1,-1,2],[-1,0,1]]
     输入：nums = []
     输出：[]
     输入：nums = [0]
     输出：[]
     */
    
    /**
     a + b + c = 0
     个人分析：a、b、c 三个数一定有正负：两正一负，两负一正
     1、全为负的元素组成数组，两两相加判断全为正的数组里有没有满足情况；
     2、全为正的元素组成的数组类似1处理
     3、如果有元素 0，取出0，正负两个数组只要有绝对值相等的就可以
     */
    
    /**
     题解：排序 + 双指针
     本题的难点在于如何去除重复解。
     
     算法流程：
     1、特判（数组至少三个元素）
     2、对数组进行排序
     3、遍历排序后数组：
     当前元素 i，左指针 left = i+1 递增，右指针 right = n -1 递减
     构建出 i + left + right 对应 a + b + c
     
     a、如果 nums[i]大于 0，则三数之和必然无法等于 0，结束循环
     b、对于重复元素：跳过，避免出现重复解
     b1、当前元素 nums[i] = nums[i+1]，跳过该元素，循环 continue
     b2、左指针，当 sum = 0 时，nums[L] = nums[L+1]，跳过L++
     b2、右指针，当 sum = 0 时，nums[R] = nums[R-1]，跳过R--
     */
    func threeSum(_ nums: [Int]) -> [[Int]] {
        // 特判
        guard nums.count > 2 else {
            return []
        }
        
        var ans = [[Int]]()
        
        // 排序
        let sortedArr = nums.sorted()
        for i in 0..<sortedArr.count {
            // 如果当前数字大于0，则三数之和一定大于0，所以结束循环
            if sortedArr[i] > 0 {
                break
            }
            
            // 去重
            if i > 0, sortedArr[i] == sortedArr[i-1] {
                continue
            }
            
            // 双指针查找
            var l = i+1
            var r = sortedArr.count - 1
            while l < r {
                let sum = sortedArr[i] + sortedArr[l] + sortedArr[r]
                if sum == 0 {
                    // 添加元素
                    let tmp = [sortedArr[i], sortedArr[l], sortedArr[r]]
                    ans.append(tmp)
                    
                    // 去重
                    while l < r, sortedArr[l] == sortedArr[l+1]  {
                        l += 1
                    }
                    // 去重
                    while l < r, sortedArr[r] == sortedArr[r-1]  {
                        r -= 1
                    }
                    
                    // 继续查找
                    l += 1
                    r -= 1
                    
                } else if sum < 0 {
                    // 说明left偏小
                    l += 1
                } else if sum > 0 {
                    // 说明right偏大
                    r -= 1
                }
            }
        }
        
        return ans
    }
    
    //MARK: - 11. 盛最多水的容器
    /**
     题目：给你 n 个非负整数 a1，a2，...，an，每个数代表坐标中的一个点 (i, ai) 。在坐标内画 n 条垂直线，垂直线 i 的两个端点分别为 (i, ai) 和 (i, 0) 。找出其中的两条线，使得它们与 x 轴共同构成的容器可以容纳最多的水。
     
     示例：
     输入：[1,8,6,2,5,4,8,3,7]
     输出：49
     解释：图中垂直线代表输入数组 [1,8,6,2,5,4,8,3,7]。在此情况下，容器能够容纳水（表示为蓝色部分）的最大值为 49。

     个人分析：
     x * y 得到的结果最大
     x：0...n
     y:  a1，a2，...，an
     极端分析：下标相差越远越好，数值越大越好
     
     计算：min(v1,v2) * 下标差值
     */
    /**
     双指针思想：关键在于两端指针移动规则
     规则：移动value较小一侧的指针
     */
    func maxArea(_ height: [Int]) -> Int {
        // 特判：至少要两条线
        guard height.count > 1 else {
            return 0
        }
        
        var ans = 0
        var l = 0, r = height.count - 1
        
        while l < r {
            let len = r - l
            var minHeight = 0
            
            if height[l] < height[r] {
                minHeight = height[l]
                l += 1
            } else {
                minHeight = height[r]
                r -= 1
            }
            
            let area = len * minHeight
            ans = max(ans, area)
        }
        
        return ans
    }
    
    //MARK: - 31. 下一个排列
    /**
     题目：
     实现获取 下一个排列 的函数，算法需要将给定数字序列重新排列成字典序中下一个更大的排列（即，组合出下一个更大的整数）。
     如果不存在下一个更大的排列，则将数字重新排列成最小的排列（即升序排列）。
     必须 原地 修改，只允许使用额外常数空间。
     
     示例：
     输入：nums = [1,2,3]
     输出：[1,3,2]
     
     输入：nums = [3,2,1]
     输出：[1,2,3]
     312    132
     
     
     
     输入：nums = [1,1,5]
     输出：[1,5,1]
     
     输入：nums = [1]
     输出：[1]
     
     思考：
     1、特判：count = 1，return
     2、从右向左替换元素，得到第一个更大的即break
     3、若最终没有更大的，取最小的
     */
    
    func nextPermutation(_ nums: inout [Int]) {
        guard nums.count > 1 else {
            return
        }
        
        // 双指针，从后往前替换元素
        
        
    }
}
