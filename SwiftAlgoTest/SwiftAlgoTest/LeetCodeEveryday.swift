//
//  LeetCodeEveryday.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/10/26.
//

import Foundation

class LeetCodeEveryday {
    //MARK: - 496. 下一个更大元素 I
    /**
     难度：简单
     题目：给你两个 没有重复元素 的数组 nums1 和 nums2 ，其中nums1 是 nums2 的子集。
     请你找出 nums1 中每个元素在 nums2 中的下一个比其大的值。
     nums1 中数字 x 的下一个更大元素是指 x 在 nums2 中对应位置的右边的第一个比 x 大的元素。如果不存在，对应位置输出 -1 。

     示例：
     输入: nums1 = [4,1,2], nums2 = [1,3,4,2].
     输出: [-1,3,-1]
     解释:
         对于 num1 中的数字 4 ，你无法在第二个数组中找到下一个更大的数字，因此输出 -1 。
         对于 num1 中的数字 1 ，第二个数组中数字1右边的下一个较大数字是 3 。
         对于 num1 中的数字 2 ，第二个数组中没有下一个更大的数字，因此输出 -1 。
     */
    
    /**
     【思考&分析】
     条件：1、子集；2、找最近的一个更大的值
     起始位置：nums1对应的元素在nums2 的下标
     */
    func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        // ans.count == nums1.count
        var ans = [Int]()
        
        // key：元素值，value：下标
        var dic = [Int: Int]()
        for i in 0..<nums2.count {
            dic[nums2[i]] = i
        }
        
        // 先遍历短的
        for i in 0..<nums1.count {
            // 记录该次遍历是否查询到结果
            var hasElement = false
            let curVal = nums1[i]
            
            let startIndex = dic[curVal] ?? 0 + 1
            for j in startIndex..<nums2.count {
                if nums2[j] > curVal {
                    ans.append(nums2[j])
                    hasElement = true
                    break
                }
            }
            
            // 若未查询到，需补充-1
            if !hasElement {
                ans.append(-1)
            }
        }
        
        return ans
    }
}
