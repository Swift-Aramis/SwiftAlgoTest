//
//  DailyPractice.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/10/20.
//

import Foundation

class DailyPractice {
    
    //MARK: - 40. 最小的k个数
    /**
     题目：给定一个长度为 n 的可能有重复值的数组，找出其中不去重的最小的 k 个数。例如数组元素是 4,5,1,6,2,7,3,8这8个数字，则最小的4个数字是1,2,3,4(任意顺序皆可)。
    
     要求：空间复杂度 O(n)，时间复杂度 O(nlogn)
     */
    
    /**
     解题思路：
     1、对数组排序；（快排）
     2、取出前k个元素
     
     核心考察点：快速排序
     */
    func GetLeastNumbers_Solution(_ input: [Int], _ k: Int) -> [Int] {
        // 0、特殊情况
        if input.count <= k {
            return input
        }
        
        // 1、对数组排序
        var sortedArray = input
//        quickSort(&sortedArray, k, left: 0, right: sortedArray.count - 1)
        quickSort(&sortedArray, left: 0, right: sortedArray.count - 1)

        // 2、取出前k个元素
        return Array(sortedArray.prefix(k))
    }
    
    // a、非完整快排
    func quickSort(_ array: inout [Int], _ k: Int, left: Int, right: Int) {
        let pivot = array[left]
        var l = left, r = right
        while l < r {
            // 注意：先移动右指针！！！
            while l < r, array[r] >= pivot {
                r -= 1
            }
            while l < r, array[l] <= pivot {
                l += 1
            }
           
            array.swapAt(l, r)
        }
        
        array.swapAt(left, l)
        
        // 左侧数据不足，需往后继续扩大排序范围
        if l < k {
            quickSort(&array, k, left: l + 1, right: right)
        }
        
        // 左侧数据超出，需往前缩小排序范围
        if l > k {
            quickSort(&array, k, left: left, right: l - 1)
        }
    }
    
    // b、完整快排
    func quickSort(_ array: inout [Int], left: Int, right: Int) {
        if left >= right {
            return
        }
        
        let pivot = array[left]
        var l = left, r = right
        while l < r {
            // 注意：先移动右指针！！！
            while l < r, array[r] >= pivot {
                r -= 1
            }
            while l < r, array[l] <= pivot {
                l += 1
            }
           
            array.swapAt(l, r)
        }
        
        array.swapAt(left, l)
        
        // 左侧递归
        quickSort(&array, left: left, right: l - 1)
        // 右侧递归
        quickSort(&array, left: l + 1, right: right)
    }
    
}

//MARK: - 146. LRU 缓存机制
/**
 题目：运用你所掌握的数据结构，设计和实现一个  LRU (最近最少使用) 缓存机制 。
 实现 LRUCache 类：
 LRUCache(int capacity) 以正整数作为容量 capacity 初始化 LRU 缓存
 int get(int key) 如果关键字 key 存在于缓存中，则返回关键字的值，否则返回 -1 。
 void put(int key, int value) 如果关键字已经存在，则变更其数据值；如果关键字不存在，则插入该组「关键字-值」。
 当缓存容量达到上限时，它应该在写入新数据之前删除最久未使用的数据值，从而为新的数据值留出空间。

 进阶：你是否可以在 O(1) 时间复杂度内完成这两种操作？
 */

/**
 分析：
 LRU 缓存淘汰算法就是一种常用策略。LRU 的全称是 Least Recently Used。
 也就是说我们认为最近使用过的数据应该是是「有用的」，
 很久都没用过的数据应该是无用的，内存满了就优先删那些很久没用过的数据。

 因为显然 cache 必须有顺序之分，以区分最近使用的和久未使用的数据；
 而且我们要在 cache 中查找键是否已存在；
 如果容量满了要删除最后一个数据；
 每次访问还要把数据插入到队头。
 
 哈希表查找快，但是数据无固定顺序；链表有顺序之分，插入删除快，但是查找慢。
 所以结合一下，形成一种新的数据结构：哈希链表。
 
 LRU 缓存算法的核心数据结构就是哈希链表，双向链表和哈希表的结合体。

 思想很简单，就是借助哈希表赋予了链表快速查找的特性嘛：
 可以快速查找某个 key 是否存在缓存（链表）中，同时可以快速删除、添加节点。
 
 “为什么必须要用双向链表”? 因为我们需要删除操作。
 删除一个节点不光要得到该节点本身的指针，也需要操作其前驱节点的指针，而双向链表才能支持直接查找前驱，保证操作的时间复杂度
 */

class DNode {
    var key: Int
    var value: Int
    var prev: DNode?
    var next: DNode?
   
    init(key: Int, value: Int) {
        self.key = key
        self.value = value
    }
}

protocol DoubleLinkProtocol {

    func addFirst(_ node: DNode)
    
    func remove(_ node: DNode)
    
    func removeLast() -> DNode?
    
    var size: Int  { get }
}

class DoubleLinkList: DoubleLinkProtocol {
   
    private var count: Int = 0
    private var head: DNode = DNode(key: 0, value: 0)
    private var tail: DNode = DNode(key: 0, value: 0)
    
    init() {
        head.next = tail
        tail.prev = head
    }
    
    // 头插
    func addFirst(_ node: DNode) {
        let headNext = head.next
        head.next = node
        headNext?.prev = node
        
        node.prev = head
        node.next = headNext
        
        count += 1
    }
    
    // 删除指定节点
    func remove(_ node: DNode) {
        node.prev?.next = node.next
        node.next?.prev = node.prev
        
        count -= 1
    }
    
    // 删除尾结点，并返回该节点
    func removeLast() -> DNode? {
        guard let last = tail.prev else {
            return nil
        }
        remove(last)
        return last
    }
    
    var size: Int {
        return count
    }
}

class LRUCache {
    
    private var capacity: Int = 0
    
    // key -> DNode(key, val)
    private var hashMap: [Int: DNode]
    // node(k1, v1) <-> Node(k2, v2)...
    private var cache: DoubleLinkList

    init(_ capacity: Int) {
        self.capacity = capacity
        self.hashMap = [Int: DNode]()
        self.cache = DoubleLinkList()
    }
    
    func get(_ key: Int) -> Int {
        if !hashMap.keys.contains(key) {
            return -1
        }
        
        guard let node = hashMap[key] else {
            return -1
        }
        put(key, node.value)
        return node.value
    }
    
    func put(_ key: Int, _ value: Int) {
        let node = DNode(key: key, value: value)
        if hashMap.keys.contains(key) {
            // 删除旧的节点
            if let oldNode = hashMap[key] {
                cache.remove(oldNode)
            }
            
        } else {
            // cache达到最大容量
            if cache.size == capacity {
                // 删除最后结点
                if let last = cache.removeLast() {
                    // 删除映射
                    hashMap.removeValue(forKey: last.key)
                }
            }
        }
        
        // 头插
        cache.addFirst(node)
        // 新建映射
        hashMap[key] = node
    }
    
}
