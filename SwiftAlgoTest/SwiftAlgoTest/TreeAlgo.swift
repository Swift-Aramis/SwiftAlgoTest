//
//  TreeAlgo.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/8/30.
//

import Foundation

class MyTreeNode {
    var data: Int?
    var left: MyTreeNode?
    var right: MyTreeNode?
    
    init(data: Int) {
        self.data = data
    }
}
//MARK: - 二叉查找树（BST）

class BinarySearchTree {
    private var tree: MyTreeNode?
    
    // 查找
    func find(data: Int) -> MyTreeNode? {
        var p = tree
        while p != nil {
            if data < p!.data! {
                p = p!.left
            } else if data > p!.data! {
                p = p!.right
            } else {
                return p
            }
        }
        
        return nil
    }
    
    func find2(data: Int) -> MyTreeNode? {
        var p = tree
        while p != nil, data != p!.data! {
            if data < p!.data! {
                p = p!.left
            } else if data > p!.data! {
                p = p!.right
            }
        }
        return p
    }
    
    func findMin() -> MyTreeNode? {
        if tree == nil {
            return nil
        }
        
        var p = tree
        while p!.left != nil {
            p = p!.left
        }
        return p
    }
    
    func findMax() -> MyTreeNode? {
        if tree == nil {
            return nil
        }
        
        var p = tree
        while p!.right != nil {
            p = p!.right
        }
        return p
    }
    
    // 插入
    func insert(data: Int) {
        let node = MyTreeNode(data: data)
        
        if tree == nil {
            tree = node
            return
        }
        
        var p = tree
        while p != nil {
            if data > p!.data! {
                if p!.right == nil {
                    p!.right = node
                    return
                }
                p = p!.right
            } else {
                if p!.left == nil {
                    p!.left = node
                    return
                }
                p = p!.left
            }
        }
    }
    
    // 删除(需要对要删除节点的子节点做处理)
    func delete(data: Int) {
        var cur = tree
        var pre: MyTreeNode?
        
        // 找节点
        while cur != nil, data != cur!.data! {
            pre = cur
            if data < cur!.data! {
                cur = cur!.left
            } else if data > cur!.data! {
                cur = cur!.right
            }
        }
        
        // 没找到节点
        if cur == nil {
            return
        }
        
        // 找到节点
        // 1、该节点有两个子节点
        if cur!.left != nil, cur!.right != nil {
            // 将右子树最小的节点替换到被删除节点位置
            var minR = cur!.right
            var preMinR: MyTreeNode?
            // 找到右子树最小节点
            while minR!.left != nil {
                preMinR = minR
                minR = minR!.left
            }
            
            // 替换
            cur!.data = minR!.data
            // 交换指针，准备删除（复用逻辑：该节点有 0 or 1 个子节点）
            cur = minR
            pre = preMinR
        }
        
        // 2、该节点有 0 or 1 个子节点
        // 确认子节点
        var child: MyTreeNode? = nil
        if cur!.left != nil {
            child = cur!.left
        } else if cur!.right != nil {
            child = cur!.right
        }
        
        // 连接到父节点
        if pre == nil {
            // 删除的是根节点
            tree = child
        } else if pre!.left === cur {
            pre!.left = child
        } else {
            pre!.right = child
        }
    }
    
}
