//
//  LeetCodeLogic.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/9/13.
//

import Foundation

extension LeetCode {
    
    //MARK: - 70. 爬楼梯
    func climbStairsNO(_ n: Int) -> Int {
        if n <= 2 {
            return n
        }
    
        return climbStairs(n - 1) + climbStairs(n - 2)
    }
    
    // 递推公式 f(x)=f(x−1)+f(x−2)
    // 滚动数组思想
    func climbStairs(_ n: Int) -> Int {
        var p = 0
        var q = 0
        var r = 1
        
        for _ in 0..<n {
            p = q
            q = r
            r = p + q
        }
        
        return r
    }
    
    //MARK: - 121. 买卖股票的最佳时机
    /**
     数组中元素，后面B比前面A差值最大的元素 -> B
     1、B - A > 0
     2、B - A  max
     */
    // 超出时间限制
    func maxProfitNO(_ prices: [Int]) -> Int {
        var maxProfit = 0 // 最大收益
        
        for i in 0 ..< prices.count - 1 {
            for j in i + 1 ..< prices.count {
                let diff = prices[j] - prices[i]
                if diff < 0 {
                    break
                }
                maxProfit = max(maxProfit, diff)
            }
        }
        
        return maxProfit
    }
    
    // 遍历价格数组一遍，记录历史最低点
    func maxProfit(_ prices: [Int]) -> Int {
        var minPrice = prices[0] // 最低价格
        var maxProfit = 0 // 最大收益

        for i in 1 ..< prices.count {
            let val = prices[i]
            minPrice = min(minPrice, val)
            let profit = val - minPrice
            maxProfit = max(maxProfit, profit)
        }
        
        return maxProfit
    }
   
}
