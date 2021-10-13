//
//  LeetCodeLinkedList.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/9/3.
//

import Foundation

extension LeetCode {
    
    //MARK: - 234. 回文链表
    // 1 2 3 | 3 2 1
    /**
     fast - nil
     slow - mid
     
     mid = slow.next 从后到前（翻转）
     head 从前到后
     */
    func isPalindrome2(_ head: ListNode?) -> Bool {
        if (head == nil) {
            return true;
        }
        
        // 找到前半部分链表的尾节点并反转后半部分链表
        let firstHalfEnd: ListNode? = endOfFirstHalf(head)
        let secondHalfStart: ListNode? = reverseHalfList(firstHalfEnd?.next)
        
        // 判断是否回文
        var headA: ListNode? = head
        var headB: ListNode? = secondHalfStart
        var result = true
        /**
         奇数链表：1 0 1
         A: 1 0
         B: 1
         后半部分链表比较短
         */
        while result, headB != nil {
            if headA?.val != headB?.val {
                result = false
            }
            headA = headA?.next
            headB = headB?.next
        }
        
        // 还原链表并返回结果
        firstHalfEnd?.next = reverseHalfList(secondHalfStart)
        return result
    }
    
    func reverseHalfList(_ head: ListNode?) -> ListNode? {
        var pre: ListNode? = nil
        var cur: ListNode? = head
        
        while cur != nil {
            let next = cur?.next
            cur?.next = pre
            pre = cur
            cur = next
        }
        
        return pre
    }
    
    func endOfFirstHalf(_ head: ListNode?) -> ListNode? {
        var fast: ListNode? = head
        var slow: ListNode? = head
        // 如果有两个中间结点，则返回第-个中间结点。
        while fast?.next != nil, fast?.next?.next != nil {
            fast = fast?.next?.next
            slow = slow?.next
        }
        
        return slow
    }
    
    func isPalindrome(_ head: ListNode?) -> Bool {
        // 将链表的值复制到数组中
        var cur: ListNode? = head
        var vals = [Int]()
        while cur != nil {
            vals.append(cur!.val)
            cur = cur?.next
        }
        
        // 双指针判断是否回文
        var front = 0
        var back = vals.count - 1
        while front < back {
            if vals[front] != vals[back] {
                return false
            }
            front += 1
            back -= 1
        }
 
        return true
    }
    
    //MARK: - 876. 链表的中间结点
    func middleNode(_ head: ListNode?) -> ListNode? {
        var fast: ListNode? = head
        var slow: ListNode? = head
        // 如果有两个中间结点，则返回第二个中间结点。
        while fast != nil, fast?.next != nil {
            fast = fast?.next?.next
            slow = slow?.next
        }
        
        return slow
    }
    
    //MARK: - 206. 反转链表
    func reverseList(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        
        let newHead = reverseList(head!.next)
        head?.next?.next = head
        head?.next = nil
        return newHead
    }
    
    func reverseList1(_ head: ListNode?) -> ListNode? {
        
        var pre: ListNode? = nil
        var curNode: ListNode? = head
        while curNode != nil {
            let next = curNode?.next
            curNode?.next = pre
            pre = curNode
            curNode = next
        }
        
        return pre
    }
    
    //MARK: - 21. 合并两个有序链表
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let dummy = ListNode()
        var head: ListNode? = dummy
        var head1: ListNode? = l1
        var head2: ListNode? = l2
        while head1 != nil, head2 != nil {
            if head1!.val < head2!.val {
                head!.next = head1
                head1 = head1!.next
            } else {
                head!.next = head2
                head2 = head2!.next
            }
            head = head!.next
        }
        
        if head1 != nil {
            head!.next = head1
        } else {
            head!.next = head2
        }
        
        return dummy.next
    }
    
    //MARK: - 141. 环形链表
    func hasCycle(_ head: ListNode?) -> Bool {
        var fast: ListNode? = head?.next
        var slow: ListNode? = head
        while fast != nil, fast?.next != nil {
            fast = fast?.next?.next
            slow = slow?.next
            if fast === slow {
                return true
            }
            
        }
        
        return false
    }
    
    //MARK: - 19、删除链表的倒数第 N 个结点
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        let dummy = ListNode(0, head)
        var fast: ListNode? = head
        var slow: ListNode? = dummy

        var num = 0
        while num < n, fast != nil {
            fast = fast?.next
            num += 1
        }
        
        while fast != nil {
            fast = fast?.next
            slow = slow?.next
        }
        
        slow?.next = slow?.next?.next
        return dummy.next
    }
    
    //MARK: - 160. 相交链表
    // 双指针
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        if headA == nil || headB == nil {
            return nil
        }
        var nodeA: ListNode? = headA
        var nodeB: ListNode? = headB
        while nodeA !== nodeB {
            nodeA = nodeA == nil ? headB : nodeA?.next
            nodeB = nodeB == nil ? headA : nodeB?.next
        }
        
        return nodeA
    }
    
}
