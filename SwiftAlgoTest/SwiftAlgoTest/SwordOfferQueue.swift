//
//  SwordOfferQueue.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/9/14.
//

import Foundation

class CQueue {
    
    var inArray = [Int]()
    
    var outArray = [Int]()
    
    let defaultVal = -1

    init() {
        inArray = [Int]()
        outArray = [Int]()
    }
    
    func appendTail(_ value: Int) {
        inArray.append(value)
    }
    
    func deleteHead() -> Int {
        if outArray.isEmpty {
            outArray = inArray.reversed()
            inArray.removeAll()
        }

        return outArray.popLast() ?? defaultVal
    }
}
