//
//  LeetCodeStack.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/9/13.
//

import Foundation

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
