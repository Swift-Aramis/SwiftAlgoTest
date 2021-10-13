//
//  LeetCodeTree.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/9/3.
//

import Foundation

extension LeetCode {
    
    func testTreeAlgo() {
        
        // 102. 二叉树的层序遍历
        // [3,9,20,null,null,15,7]
        let treeAlgo = LeetCodeTree()
        let root = TreeNode(3, TreeNode(9), TreeNode(20, TreeNode(15), TreeNode(7)))
        treeAlgo.levelOrder(root)
    }
    
    //MARK: - 617. 合并二叉树
    /**
     1、左树空返右树
     2、右树空返左树
     3、左右不空，递归调用：
     a、由mergeTrees返回树的头结点
     b、头节点的左树由mergeTrees返回
     c、头节点的右树由mergeTrees返回
     */
    func mergeTrees(_ root1: TreeNode?, _ root2: TreeNode?) -> TreeNode? {
        if root1 == nil {
            return root2
        }
        if root2 == nil {
            return root1
        }
        let root: TreeNode = TreeNode(root1!.val + root2!.val)
        root.left = mergeTrees(root1?.left, root2?.left)
        root.right = mergeTrees(root1?.right, root2?.right)
        return root
    }
    
}

class LeetCodeTree {
    
    var queue = [TreeNode]()
    
    //MARK: - 94. 二叉树的中序遍历
    var inorderArray = [Int]()
    
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        if root == nil {
            return []
        }
        
        inorder(root)
        return inorderArray
    }
    
    func inorder(_ root: TreeNode?) {
        if root == nil {
            return
        }
        
        inorder(root?.left)
        if let val = root?.val {
            inorderArray.append(val)
        }
        inorder(root?.right)
    }
    
    // 二叉树的前序遍历
    func preOrder(_ root: TreeNode?) {
        if root == nil {
            return
        }
        
        if let val = root?.val {
            inorderArray.append(val)
        }
        preOrder(root?.left)
        preOrder(root?.right)
    }
    
    // 二叉树的后序遍历
    func afterOrder(_ root: TreeNode?) {
        if root == nil {
            return
        }
        
        preOrder(root?.left)
        preOrder(root?.right)
        if let val = root?.val {
            inorderArray.append(val)
        }
    }
    
    // 二叉树的广度优先级遍历
    /**
     BFS(breadth-first search)
     广度优先遍历是先搜索所有兄弟和堂兄弟结点，再搜索子孙结点
     1、队列：先进先出
     2、依次left、right
     */
    func bfOrder(_ root: TreeNode?) -> [Int] {
        if root == nil {
            return []
        }
        
        queue = [TreeNode]()
        appendSafe(root)
        while queue.count > 0 {
            let node = popSafeElement()
            if let val = node?.val {
                inorderArray.append(val)
            }
            if node?.left != nil {
                appendSafe(node?.left)
            }
            if node?.right != nil {
                appendSafe(node?.right)
            }
        }

        return inorderArray
    }
    
    //MARK: - 102. 二叉树的层序遍历
    
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        if root == nil {
            return []
        }
        
        var ans = [[Int]]()
        queue = [TreeNode]()
        appendSafe(root)
        while queue.count > 0 {
            var singleLevelArray = [Int]()
            // 单层处理
            let levelLen = queue.count
            for _ in 0..<levelLen {
                let node = popSafeElement()
                if let val = node?.val {
                    singleLevelArray.append(val)
                }
        
                if node?.left != nil {
                    appendSafe(node?.left)
                }
                if node?.right != nil {
                    appendSafe(node?.right)
                }
            }
            ans.append(singleLevelArray)
        }
        
        return ans
    }
    
    //MARK: - 98. 验证二叉搜索树
    /**
     给你一个二叉树的根节点 root ，判断其是否是一个有效的二叉搜索树。有效 二叉搜索树定义如下：
     节点的左子树只包含 小于 当前节点的数。
     节点的右子树只包含 大于 当前节点的数。
     所有左子树和右子树自身必须也是二叉搜索树。
     
     思路：
     中序遍历
     判断当前节点是否大于中序遍历的前一个节点，如果大于，说明满足 BST，继续遍历；否则直接返回 false。
     */
    var preVal = Int.min
    func isValidBST(_ root: TreeNode?) -> Bool {
        if root == nil {
            return true
        }
        
        // 左
        if !isValidBST(root?.left) {
            return false
        }
        
        // 中
        if root!.val <= preVal {
            return false
        }
        preVal = root!.val
        
        // 右
        return isValidBST(root?.right)
    }
    
    //MARK: - 100. 相同的树
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil, q == nil {
            return true
        }
        
        if p == nil || q == nil {
            return false
        }
        
        return p?.val == q?.val && isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
    }
    
    //MARK: - 101. 对称二叉树
    /**
     给定一个二叉树，检查它是否是镜像对称的。
     例如，二叉树 [1,2,2,3,4,4,3] 是对称的。
       1
       / \
      2   2
      / \   / \
     3  4 4  3
     
     1、递归
     a、它们的两个根结点具有相同的值
     b、每个树的右子树都与另一个树的左子树镜像对称
     我们可以实现这样一个递归函数，通过「同步移动」两个指针的方法来遍历这棵树
     */
    func isSymmetric(_ root: TreeNode?) -> Bool {
        return check(root, root)
    }
    
    // 递归
    func check(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil, q == nil {
            return true
        }
        
        // 说明左右叶子节点数量不相等
        if p == nil || q == nil {
            return false
        }
        
        // 对称节点位置值相等，依次递归遍历
        return p!.val == q!.val && check(p?.left, q?.right) && check(p?.right, q?.left)
    }
    
    // 迭代
    /**
     1、队列
     2、对称节点分别入队
     3、分别出队，比较元素是否相等，若不相等，结束
     */

    func isSymmetric2(_ root: TreeNode?) -> Bool {
        if root == nil {
            return true
        }
         
        queue = [TreeNode]()
        appendSafe(root?.left)
        appendSafe(root?.right)
        while queue.count > 0 {
            // 队列里有两个值，分别取出
            let p = popSafeElement()
            let q = popSafeElement()
            
            if p == nil, q == nil {
                continue
            }
            
            if p == nil || q == nil {
                return false
            }
            
            // 存在不相等的值，结束循环
            if p!.val != q!.val {
                return false
            }
            
            // 继续入队
            //将左节点的左孩子， 右节点的右孩子放入队列
            appendSafe(p?.left)
            appendSafe(q?.right)
            //将左节点的右孩子，右节点的左孩子放入队列
            appendSafe(p?.right)
            appendSafe(q?.left)
        }
        
        return false
    }
    
    //MARK: - 104. 二叉树的最大深度
    // 1、深度优先搜索
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        
        return max(maxDepth(root?.left), maxDepth(root?.right)) + 1
    }
    
    // 广度优先搜索
    func maxDepth1(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        queue = [TreeNode]()
        appendSafe(root)
        var ans = 0
        while queue.count > 0 {
            let levelLen = queue.count
            for _ in 0..<levelLen {
                let node = popSafeElement()
                
                if node?.left != nil {
                    appendSafe(node?.left)
                }
                if node?.right != nil {
                    appendSafe(node?.right)
                }
            }
            ans += 1
        }
        
        return ans
    }
    
    //MARK: - 543. 二叉树的直径
    /**
     给定一棵二叉树，你需要计算它的直径长度。一棵二叉树的直径长度是任意两个结点路径长度中的最大值。这条路径可能穿过也可能不穿过根结点。
     */
    var diameterAns = 0
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        
        // 节点数
        diameterAns = 1
        depth(root)
        return diameterAns - 1 // 节点数减一，即为节点之间的路径
    }
    
    @discardableResult func depth(_ root: TreeNode?) -> Int { // 深度优先搜索
        if root == nil {
            return 0
        }
        
        let left = depth(root?.left)
        let right = depth(root?.right)
        diameterAns = max(diameterAns, left + right + 1)
        
        // 返回该节点为根的子树的深度
        return max(left, right) + 1
    }
    
    //MARK: - 226. 翻转二叉树
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return root
        }
        
        let left = invertTree(root?.left)
        let right = invertTree(root?.right)
        root?.left = right
        root?.right = left
        return root
    }
    
    //MARK: - 114. 二叉树展开为链表
    var curTreeNode: TreeNode? = TreeNode()
    func flatten(_ root: TreeNode?) {
        if root == nil {
            return
        }
        
        // 暂存left、right
        let left = root?.left
        let right = root?.right
        
        // 串联链表
        curTreeNode?.right = root
        curTreeNode?.left = nil
        // 移动指针
        curTreeNode = root
       
        flatten(left)
        flatten(right)
    }
    
    //MARK: - 剑指 Offer II 052. 展平二叉搜索树
    var cur: TreeNode? = TreeNode()
    func increasingBST(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return root
        }
        
        let dummy: TreeNode? = TreeNode()
        cur = dummy
        dfs_increasingBST(root)
        return dummy?.right
    }
    
    func dfs_increasingBST(_ node: TreeNode?) {
        if node == nil {
            return
        }
        
        dfs_increasingBST(node?.left)
        
        // 在中序遍历的过程中修改节点指向
        cur?.right = node
        // 将节点的左边节点设置为 nil
        node?.left = nil
        cur = node
        
        dfs_increasingBST(node?.right)
    }
    
    
    //MARK: - 538. 把二叉搜索树转换为累加树
    var treeSum = 0
    func convertBST(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        
        // 右 中 左 - 递归: 只需要加上一个节点的值
        _ = convertBST(root?.right)
        treeSum += root?.val ?? 0
        root?.val = treeSum
        _ = convertBST(root?.left)
        return root
    }

}


extension LeetCodeTree {
    
    //MARK: - 队列
    func appendSafe(_ element: TreeNode?) {
        if let e = element {
            queue.append(e)
        }
    }
        
    func popSafeElement() -> TreeNode? {
        if queue.count != 0 {
            return queue.removeFirst()
        }
        return nil
    }

}
