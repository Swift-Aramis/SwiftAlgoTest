//
//  QueueAlgo.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/8/30.
//

import Foundation

//MARK: - 队列方法声明
protocol Queue {
    // 持有的数据类型
    associatedtype Element
    // 是否为空
    var isEmpty: Bool { get }
    // 队列大小
    var size: Int { get }
    // 返回队列头部元素
    var peek: Element? { get }
    
    // 入队
    mutating func enqueue(newElement: Element) -> Bool
    // 出队
    mutating func dequeue() -> Element?
}

//MARK: - 基于一个数组实现的队列
struct ArrayQueue<Element>: Queue {
    // 数组
    private var items: [Element] = [Element]()
    // 数组容量
    private var capacity: Int = 0
    // 队首下标
    private var head: Int = 0
    // 队尾下标
    private var tail: Int = 0
    
    /// 构造方法
    /// - parameter defaultElement: 默认元素
    /// - parameter capacity: 数组长度
    init(defaultElement: Element, capacity: Int) {
        self.capacity = capacity
        items = [Element](repeating: defaultElement, count: capacity)
    }
    
    var isEmpty: Bool {
        return head == tail
    }
    
    var size: Int {
        return tail - head
    }
    
    var peek: Element? {
        return isEmpty ? nil : items[head]
    }
    
    mutating func enqueue(newElement: Element) -> Bool {
        // tail == capacity 表示队列末尾没有空间了
        if tail == capacity {
            // tail == capacity & head == 0 表示队列被占满了
            if head == 0 {
                return false
            }
            
            // tail == capacity & head != 0 表示队列头部还有空间
            // todo：将所有元素往前挪
            for i in head..<tail {
                items[i - head] = items[i]
            }
            // 更新 head tail
            tail -= head
            head = 0
        }
        
        items[tail] = newElement
        tail += 1
        return true
    }
    
    mutating func dequeue() -> Element? {
        if isEmpty {
            return nil
        }
        
        let item = items[head]
        head += 1
        return item
        
    }
    
}

//MARK: - 基于两个数组实现的队列
struct DoubleArrayQueue<Element>: Queue {
    // 输入数组，负责入队
    private var inArray: [Element] = [Element]()
    // 输出数组，负责出队
    private var outArray: [Element] = [Element]()
    
    var isEmpty: Bool {
        return inArray.isEmpty && outArray.isEmpty
    }
    
    var size: Int {
        return inArray.count + outArray.count
    }
    
    // 当 outArray 为空时，返回 inArray 首个元素，否则返回 outArray 末尾元素
    var peek: Element? {
        return outArray.isEmpty ? inArray.first : outArray.last
    }
    
    mutating func enqueue(newElement: Element) -> Bool {
        inArray.append(newElement)
        return true
    }
    
    mutating func dequeue() -> Element? {
        if outArray.isEmpty {
            // 将 inArray 倒序存入 outArray 中
            outArray = inArray.reversed()
            // 清空 inArray
            inArray.removeAll()
        }
        
        // 弹出 outArray 最后一个元素
        return outArray.popLast()
    }
    
}

//MARK: - 基于链表实现的队列

struct QueueBasedOnLinkedList<Element>: Queue {
    // 队首
    private var head: Node<Element>?
    // 队尾
    private var tail: Node<Element>?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var size: Int {
        if isEmpty {
            return 0
        }
        
        var count = 1 // head 本身算一个
        var cur = head?.next
        while cur != nil {
            cur = cur?.next
            count += 1
        }
        return count
    }
    
    var peek: Element? {
        return head?.value
    }
    
    mutating func enqueue(newElement: Element) -> Bool {
        let node = Node(value: newElement)
        if isEmpty {
            head = node
            tail = node
        } else {
            tail?.next = node
            tail = tail?.next
        }
        return true
    }
    
    mutating func dequeue() -> Element? {
        if isEmpty {
            return nil
        }
        
        let value = head?.value
        head = head?.next
        if head == nil {
            tail = nil
        }
        return value
    }
    
}


//MARK: - 循环队列
struct CircleQueue<Element>: Queue {
    // 数组
    private var items: [Element] = [Element]()
    // 数组容量
    private var capacity: Int = 0
    // 队首下标
    private var head: Int = 0
    // 队尾下标
    private var tail: Int = 0
    
    /// 构造方法
    /// - parameter defaultElement: 默认元素
    /// - parameter capacity: 数组长度
    init(defaultElement: Element, capacity: Int) {
        self.capacity = capacity
        items = [Element](repeating: defaultElement, count: capacity)
    }
    
    var isEmpty: Bool {
        return head == tail
    }
    
    var size: Int {
        if tail > head {
            return tail - head
        } else {
            return (tail + 1) + (capacity - head)
        }
    }
    
    var peek: Element? {
        return isEmpty ? nil : items[head]
    }
    
    mutating func enqueue(newElement: Element) -> Bool {
        // 表示队列被占满了
        if (tail + 1) % capacity == head {
            return false
        }
        
        items[tail] = newElement
        tail = (tail + 1) % capacity
        return true
    }
    
    mutating func dequeue() -> Element? {
        if isEmpty {
            return nil
        }
        
        let item = items[head]
        head = (head + 1) % capacity
        return item
    }
    
}

