//
//  StackAlgo.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/8/30.
//

import Foundation

//MARK: - 浏览器页面存储

struct Page {
    private var forwardPages = [String]()
    private var backPages = [String]()

    var currentURL: String? {
        return forwardPages.last
    }
    
    init(url: String) {
        forwardPages.append(url)
    }
    
    mutating func goForward(url: String) {
        forwardPages.append(url)
    }
    
    mutating func goBack() {
        guard let last = forwardPages.popLast() else {
            return
        }
        
        backPages.append(last)
    }
}


//MARK: - 基于链表实现的栈

protocol Stack {
    // 持有的数据类型
    associatedtype Element
    // 是否为空
    var isEmpty: Bool { get }
    // 队列大小
    var size: Int { get }
    // 返回队列头部元素
    var peek: Element? { get }
    
    // 入栈
    mutating func push(newElement: Element) -> Bool
    // 出栈
    mutating func pop() -> Element?
}

struct StackBasedOnLinkedList<Element>: Stack {
    
    private var head: Node<Element> = Node<Element>() // 哨兵结点，不存储内容

    var isEmpty: Bool {
        return head.next == nil
    }
    
    var size: Int {
        var count = 0
        var cur = head.next
        while cur != nil {
            cur = cur?.next
            count += 1
        }
        return count
    }
    
    var peek: Element? {
        return head.next?.value
    }
    
    func push(newElement: Element) -> Bool {
        let node = Node(value: newElement)
        node.next = head.next
        head.next = node
        return true
    }
    
    func pop() -> Element? {
        let node = head.next
        head.next = node?.next
        return node?.value
    }
}
