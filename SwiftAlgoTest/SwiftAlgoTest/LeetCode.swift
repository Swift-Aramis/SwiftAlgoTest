//
//  LeetCode.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/9/2.
//

import Foundation

/**
 Definition for singly-linked list.
 */
class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

/**
 * Definition for a binary tree node.
 */
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
    self.val = val
    self.left = left
    self.right = right
    }
}

//MARK: - LeetCode

class LeetCode {
    
    //MARK: - Test
    func testAlgo() {
        // 数字
//        testNumAlgo()
        
        // 串
        testStringAlgo()
        
        // 二叉树
//        testTreeAlgo()
        
        myAtoi("42")
    }
    
    //MARK: - Public
    
    // 循环创建链表
    public func generateLinkList(arr: [Int]) -> ListNode {
        let dummy = ListNode()
        var head: ListNode = dummy
        for v in arr {
            let node = ListNode(v)
            head.next = node
            head = head.next!
        }
        return dummy.next!
    }
    
    // 打印链表元素
    public func printLinkList(in head: ListNode) {
        var cur: ListNode? = head
        
        var values = [Int]()
        while cur != nil {
            values.append(cur!.val)
            cur = cur!.next
        }
        
        print(values)
    }
    
}
