//
//  SingleLinkedList.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/10/20.
//

import Foundation

class SNode {
    var val: Int = 0
    var next: SNode?
    
    init() {
        self.val = 0
    }
    
    init(val: Int) {
        self.val = val
    }
}

protocol SingleLinkedListProtocol {
    var size: Int { get }
    var isEmpty: Bool { get }
    
    // 查找
    func node(with value: Int) -> SNode?
    
    // 使用约定：链表的 index 从 1 开始
    func node(at index: Int) -> SNode?
    
    // 头插
    func insertToHead(value: Int)
    func insertToHead(node: SNode)
    
    // 尾插
    func insertToTrail(value: Int)
    func insertToTrail(node: SNode)
    
    // 后插
    func insert(after node: SNode, newValue: Int)
    func insert(after node: SNode, newNode: SNode)
    
    // 前插
    func insert(before node: SNode, newValue: Int)
    func insert(before node: SNode, newNode: SNode)
    
    // 删除
    func delete(value: Int)
    func delete(node: SNode)
}

class SingleLinkedList: SingleLinkedListProtocol {
    
    // 哨兵结点
    private var dummy: SNode = SNode()
    
    init(head: SNode) {
        dummy.next = head
    }
    
    var size: Int {
        var node = dummy.next
        var num = 0
        while node != nil {
            node = node?.next
            num += 1
        }
        
        return num
    }
    
    var isEmpty: Bool {
        return dummy.next == nil
    }
    
    func node(with value: Int) -> SNode? {
        var node = dummy.next
        while node != nil {
            if node!.val == value {
                return node
            }
            node = node?.next
        }
        
        return nil
    }
    
    func node(at index: Int) -> SNode? {
        var num = 1
        var node = dummy.next
        while node != nil {
            if num == index {
                return node
            }
            node = node?.next
            num += 1
        }
        
        return nil
    }
    
    func insertToHead(value: Int) {
        let n = SNode(val: value)
        insertToHead(node: n)
    }
    
    func insertToHead(node: SNode) {
        let head = dummy.next
        dummy.next = node
        node.next = head
    }
    
    func insertToTrail(value: Int) {
        let n = SNode(val: value)
        insertToTrail(node: n)
    }
    
    func insertToTrail(node: SNode) {
        var last = dummy.next
        while last != nil {
            last = last?.next
        }
        
        last?.next = node
    }
    
    func insert(after node: SNode, newValue: Int) {
        let n = SNode(val: newValue)
        insert(after: node, newNode: n)
    }
    
    func insert(after node: SNode, newNode: SNode) {
        let nodeNext = node.next
        node.next = newNode
        newNode.next = nodeNext
    }
    
    func insert(before node: SNode, newValue: Int) {
        let n = SNode(val: newValue)
        insert(before: node, newNode: n)
    }
    
    func insert(before node: SNode, newNode: SNode) {
        var prev = dummy
        var cur = dummy.next
        while cur != nil {
            if cur === node {
                break
            }
            prev = cur!
            cur = cur?.next
        }
        
        newNode.next = cur
        prev.next = newNode
    }
    
    func delete(value: Int) {
        var prev = dummy
        var cur = dummy.next
        while cur != nil {
            if cur!.val == value {
                break
            }
            prev = cur!
            cur = cur?.next
        }
        
        prev.next = cur?.next
    }
    
    func delete(node: SNode) {
        var prev = dummy
        var cur = dummy.next
        while cur != nil {
            if cur === node {
                break
            }
            prev = cur!
            cur = cur?.next
        }
        
        prev.next = cur?.next
    }
    
    
}
