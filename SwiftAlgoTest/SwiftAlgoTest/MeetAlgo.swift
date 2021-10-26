//
//  MeetAlgo.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/10/20.
//

import Foundation

class MeetAlgo {
    
    class LinkedNode {
        var val: Int = 0
        var next: LinkedNode?
        
        init() {
            self.val = 0
        }
        
        init(val: Int) {
            self.val = val
        }
        
    }
    /**
     编码题1：
     给出两个非空的单向链表来表示两个非负的整数。
     其中它们各自的位数是按照逆序的方式存储的，并且它们的每个节点只能存储一位数字 如果，我们将两个数相加，则会返回一个新的链表来表示它们的和 这两个数都不会以0开头 示例： 输入：（2->4->3）+ (2->6->4) 输出： 4->0->8 原因：342+462=804
     */
    func addTwoNums(head1: LinkedNode, head2: LinkedNode) -> LinkedNode? {
        var node1: LinkedNode? = head1
        var node2: LinkedNode? = head2
        let dummy: LinkedNode = LinkedNode()
        
        var ten = 0
        while node1 != nil || node2 != nil {
            let v1 = node1?.val ?? 0
            let v2 = node2?.val ?? 0
            let sum = v1 + v2 + ten
            
            // 是否进一
            ten = sum / 10
            // 个位数字
            let val = sum % 10
            
            // 新链表
            let node = LinkedNode(val: val)
            dummy.next = node
            
            // 遍历链表
            if node1 != nil {
                node1 = node1?.next
            }
            
            if node2 != nil {
                node2 = node2?.next
            }
        }
        
        // 最后是否进一
        if ten == 1 {
            dummy.next = LinkedNode(val: ten)
        }
        
        return dummy.next
    }
    
    /**
     题目：求序列{A, B, C, ... , Z, AA, AB, AC, ... , AZ, BA, BB, ... , AAA, AAB, ...} 的第N项
     
     0-25
     ABCDEFGHIJKLMNOPQRSTUVWXYZ
     
     AA、AB、... 、AZ
     BA、BB、... 、BZ
     CA、CB、... 、CZ
     ...
     AAA、AAB、... 、AAZ
     ABA、ABB、... 、AAZ
     
     归纳：ABC = A * 10^2 + B * 10^1 + C
     算法思想：分别求每一位的字符，从后向前求
     */
    
    let seq: [Character] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    // 方法1：迭代
    func convert10To26SeqN(_ n: Int) -> String {
        if n <= 0 {
            return ""
        }
        
        var ans = ""
        var curVal = n
        
        while curVal > 0 {
            curVal -= 1
            let index = curVal % 26
            curVal = curVal / 26
            ans.insert(seq[index], at: ans.startIndex)
        }
        
        return ans
    }
    
    // 方法2：递归
    var seqN: String = ""
    func convert10To26SeqNRecursion(_ n: Int) {
        if n <= 0 {
            return
        }
        
        var curVal = n - 1
        let index = curVal % 26
        seqN.insert(seq[index], at: seqN.startIndex)
        
        curVal = curVal / 26
        convert10To26SeqNRecursion(curVal)
    }
    
}
