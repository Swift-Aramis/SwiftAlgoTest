//
//  ViewController.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/8/27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // LeetCode test
        LeetCode().testAlgo()
        
        
        
        let convert10To26 = MeetAlgo()
        convert10To26.convert10To26SeqNRecursion(60)
        print("convert10To26.seqN === \(convert10To26.seqN)")
        
        let seqN = convert10To26.convert10To26SeqN(60)
        print("seqN === \(seqN)")
        
        let seqN2 = convert10To26.caculate(at: 60)
        print("seqN2 === \(seqN2)")

        // 链表
        // LinkListTest()
        
//        let reverseStr = LeetCodeReverse().reverseStr("abcdefg", 2)
//        print("reverseStr === \(reverseStr)")
        
//        let kArray = DailyPractice().GetLeastNumbers_Solution([4,5,1,6,2,7,3,8], 4)
//        print("kArray === \(kArray)")
        
       
        
    }

}

extension ViewController {

    func LinkListTest() {
        
        let algo = LinkListAlgo()

        //MARK: - 创建链表
        var curNode = Node(value: 9)
        for i in (1..<5).reversed() {
            let tmpNode = Node(value: i)
            tmpNode.next = curNode
            curNode = tmpNode
        }
        algo.printAllNodes(in: curNode)
        
        var curNode2 = Node(value: 8)
        for i in (1..<3).reversed() {
            let tmpNode = Node(value: i)
            tmpNode.next = curNode2
            curNode2 = tmpNode
        }
        algo.printAllNodes(in: curNode2)
        
        //MARK: - 有序链表合并
        print("有序链表合并")
        let mergedList = algo.mergeSortedList(headA: curNode, headB: curNode2)
        algo.printAllNodes(in: mergedList)
        
        //MARK: - 求链表的中间结点
        print("求链表的中间结点")
        let middleNode = algo.middleNode(in: curNode)
        print(middleNode?.value ?? 0)
        
        //MARK: - 删除倒数第n个结点
        let lastIndex = 2
        print("删除倒数第\(lastIndex)个结点")
        _ = algo.deleteNode(at: lastIndex, in: curNode)
        algo.printAllNodes(in: curNode)
    }
    
}

