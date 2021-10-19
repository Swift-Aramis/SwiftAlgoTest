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
        let arr = treeAlgo.levelOrder(root)
        print("=== Tree levelOrder ===")
        print(arr)
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
    
    // 非递归中序遍历
    /**
     实现思路，中序遍历是要先遍历左子树，然后跟节点，最后遍历右子树。
     1、所以需要先把跟节点入栈然后在一直把左子树入栈。直到左子树为空，此时停止入栈。
     2、栈顶节点就是我们需要访问的节点，取栈顶节点p并访问。
     3、然后该节点可能有右子树，所以访问完节点p后还要判断p的右子树是否为空，如果为空则接下来要访问的节点在栈顶，所以将p赋值为null。如果不为空则将p赋值为其右子树的值。 循环结束的条件是p不为空或者栈不为空。
     */
    func inorderTraversalNormal(_ root: TreeNode?) -> [Int] {
        if root == nil {
            return []
        }
            
        var ans = [Int]()
        var stack = [TreeNode]()
        stack.append(root!)
        
        var curNode: TreeNode? = root
        while curNode != nil, stack.count > 0 {
            while curNode != nil {
                // 根节点入栈
                stack.append(curNode!)
                // 左子树入栈
                curNode = curNode?.left
            }
            
            // 左子树出栈
            curNode = stack.popLast()
            ans.append(curNode!.val)
            
            // 右子树重启循环路径
            curNode = curNode?.right
        }
        
        return ans
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
    
    // 非递归前序遍历
    /**
     实现思路，先序遍历是要先访问根节点，然后再去访问左子树以及右子树，这明显是递归定义，但这里是用栈来实现的。
     首先需要先从栈顶取出节点，然后访问该节点，如果该节点不为空，则访问该节点，同时把该节点的右子树先入栈，然后左子树入栈。
     循环结束的条件是栈中不再有节点。
     */
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        if root == nil {
            return []
        }
        
        var ans = [Int]()
        
        var stack = [TreeNode]()
        stack.append(root!)
        while stack.count > 0 {
            let curNode: TreeNode = stack.removeLast()
            ans.append(curNode.val)
            
            if curNode.right != nil {
                stack.append(curNode.right!)
            }
            if curNode.left != nil {
                stack.append(curNode.left!)
            }
        }
        
        return ans
    }
    
    // 二叉树的后序遍历
    func afterOrder(_ root: TreeNode?) {
        if root == nil {
            return
        }
        
        afterOrder(root?.left)
        afterOrder(root?.right)
        if let val = root?.val {
            inorderArray.append(val)
        }
    }
    
    // 非递归后续遍历
    /**
     实现思路，在进行后序遍历的时候是先要遍历左子树，然后在遍历右子树，最后才遍历根节点。
     1、所以在非递归的实现中要先把根节点入栈。然后再把左子树入栈直到左子树为空，此时停止入栈。此时栈顶就是需要访问的元素，所以直接取出访问p。
     2、在访问结束后，还要判断被访问的节点p是否为栈顶节点的左子树，如果是的话那么还需要访问栈顶节点的右子树，所以将栈顶节点的右子树取出赋值给p。如果不是的话则说明栈顶节点的右子树已经访问完了，那么现在可以访问栈顶节点了，所以此时将p赋值为null。
     3、判断结束的条件是p不为空或者栈不为空，如果两个条件都不满足的话，说明所有节点都已经访问完成。
     */
    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        if root == nil {
            return []
        }
        
        var ans = [Int]()
        var stack = [TreeNode]()
        var curNode: TreeNode? = root
        var prevNode: TreeNode? = nil
        while curNode != nil || stack.count > 0 {
            while curNode != nil {
                stack.append(curNode!)
                curNode = curNode?.left
            }
            
            curNode = stack.popLast()
            
            // curNode?.right == nil 证明是左叶子节点
            // curNode?.right == prevNode 证明是右叶子节点
            if curNode?.right == nil || curNode?.right === prevNode  {
                ans.append(curNode!.val)
                prevNode = curNode
                curNode = nil
            } else {
                // 如果该pop节点有右子树，重新入栈，继续切到右子树节点
                stack.append(curNode!)
                curNode = curNode?.right
            }
        }
        
        return ans
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
    
    /**
     注：continue break return 在 while 中的作用
     * continue 用于跳过循环中的一个迭代。（不执行循环体内 continue 后面的语句，直接进行下一循环）
     * break 语句用于跳出循环。（结束整个循环）
     * return语句会终止函数的执行并返回函数的值。（结束整个函数）
     */
    
    //MARK: - 104. 二叉树的最大深度
    // 1、深度优先搜索(Depth-First Search,DFS)
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        
        return max(maxDepth(root?.left), maxDepth(root?.right)) + 1
    }
    
    // 广度优先搜索(Breadth-First Search,BFS)
    func maxDepthBFS(_ root: TreeNode?) -> Int {
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
     给定一棵二叉树，你需要计算它的直径长度。
     一棵二叉树的直径长度是任意两个结点路径长度中的最大值。这条路径可能穿过也可能不穿过根结点。
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
    
    // 深度优先搜索
    @discardableResult func depth(_ root: TreeNode?) -> Int {
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
