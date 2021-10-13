//
//  LinkListAlgo.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/8/27.
//

import Foundation

class Node<T> {
    var value: T?
    var next: Node?
    
    init() {
        // 空结点
    }
    
    init(value: T) {
        self.value = value
    }
}

class LinkListAlgo {
    
    //MARK: - 单链表反转
    func reverse<Element>(_ head: Node<Element>) -> Node<Element>? {
        var curNode: Node<Element>? = head
        var pre: Node<Element>? = nil

        while curNode != nil {
            let next = curNode!.next
            curNode!.next = pre
            pre = curNode
            curNode = next;
        }
        
        return pre
    }
    
    func recursiveReverse<Element>(_ head: Node<Element>?) -> Node<Element>? {
        if head == nil || head?.next == nil {
            return head
        }
        
        let newHead = recursiveReverse(head!.next);
        head!.next!.next = head
        head!.next = nil
        
        return newHead
    }
    
    //MARK: - 2、检测环
    func checkCircle<Element>(in head: Node<Element>) -> Bool {
        var slow: Node<Element>? = head
        var fast: Node<Element>? = head

        while fast != nil, fast!.next != nil {
            fast = fast!.next!.next
            slow = slow!.next
            if fast === slow {
                return true
            }
        }
        
        return false
    }
    
    //MARK: - 3、有序链表合并
    func mergeSortedList<Element: Comparable>(headA: Node<Element>?, headB: Node<Element>?) -> Node<Element>? {
        // 哨兵结点 - hold初始位置
        let dummy = Node<Element>()
        
        var head: Node<Element>? = dummy
        var nodeA: Node<Element>? = headA
        var nodeB: Node<Element>? = headB

        while nodeA != nil, nodeB != nil {
            if nodeA!.value! < nodeB!.value! {
                head!.next = nodeA
                nodeA = nodeA!.next
            } else {
                head!.next = nodeB
                nodeB = nodeB!.next
            }
            head = head!.next
        }
        
        if nodeA != nil {
            head!.next = nodeA
        } else {
            head!.next = nodeB
        }
        
        return dummy.next
    }
    
    //MARK: - 4、删除倒数第n个结点
    func deleteNode<Element>(at lastNum: Int, in head: Node<Element>) -> Node<Element>? {
        var linkList: Node<Element>? = head

        var slow: Node<Element>? = linkList
        var fast: Node<Element>? = linkList
        var num = 1
        // 快指针先跑 count - lastNum 个节点，让慢指针停止时能够定位在要删除结点
        while fast != nil, num < lastNum {
            fast = fast!.next
            num += 1
        }
        
        if fast == nil {
            return linkList
        }

        var prevNode: Node<Element>?
        while fast!.next != nil {
            prevNode = slow
            fast = fast!.next
            slow = slow!.next
        }
        
        // slow为要删除结点
        if prevNode == nil {
            linkList = linkList!.next
        } else {
            prevNode!.next = slow!.next
        }
        
        return linkList
    }
    
    //MARK: - 5、求链表的中间结点
    func middleNode<Element>(in head: Node<Element>) -> Node<Element>? {
        var slow: Node<Element>? = head
        var fast: Node<Element>? = head
        
        while fast != nil, fast!.next != nil {
            fast = fast!.next!.next
            slow = slow!.next
        }
        
        return slow
    }
    
    //MARK: - 打印链表内容
    func printAllNodes<Element>(in head: Node<Element>?) {
        var cur: Node<Element>? = head
        
        var values = [Element]()
        while cur != nil {
            values.append(cur!.value!)
            cur = cur!.next
        }
        
        print(values)
    }
    
}


