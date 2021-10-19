//
//  LeetCodeStack.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/9/13.
//

import Foundation

//MARK: - 155. 最小栈
/**
 设计一个支持 push ，pop ，top 操作，并能在常数时间内检索到最小元素的栈。

 push(x) —— 将元素 x 推入栈中。
 pop() —— 删除栈顶的元素。
 top() —— 获取栈顶元素。
 getMin() —— 检索栈中的最小元素。
 */

/**
 items
 -1 -2 0 3
 
 minItems
 Int.max -1 -2 -2 -2
 */
class MinStack {
    
    var items = [Int]()
    var minItems = [Int]()
    var defaultMinVal = Int.max
    
    init() {
        minItems.append(defaultMinVal)
    }
    
    func push(_ val: Int) {
        items.append(val)
        let curMin = minItems.last ?? defaultMinVal
        let minVal = (val < curMin) ? val : curMin
        minItems.append(minVal)
    }
    
    func pop() {
        _ = items.popLast()
        _ = minItems.popLast()
    }
    
    func top() -> Int {
        return items.last ?? 0
    }
    
    func min() -> Int {
        return minItems.last ?? 0
    }
}
