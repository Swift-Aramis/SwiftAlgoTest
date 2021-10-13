//
//  Sort.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/8/31.
//

import Foundation

class SortAlgo {
    
}

//MARK: - 冒泡排序
extension SortAlgo {
    
    // 过程：后面都是最大的，不用再遍历
    func normalBubbleSort<T: Comparable>(elements: [T]) -> [T] {
        var array = elements
        guard array.count > 1 else {
            return array
        }
        
        for i in 0..<array.count {
            for j in 0..<array.count - i - 1 {
                if array[j] > array[j+1] {
                    array.swapAt(j + 1, j)
                }
            }
        }
        return array
    }
    
    /**
       * 向下冒泡。最小的往前移动
       *
       * 算法概要：
       * 从0开始，用这个元素去跟后面的所有元素比较，如果发现这个元素大于后面的某个元素，则交换。
       * 3 2 6 4 5 1
       * 第一趟是从 index=0 也就是 3， 开始跟index=1及其后面的数字比较
       *  3 大于 2，交换，变为 2 3 6 4 5 1，此时index=0的位置变为了2
       *    接下来将用2跟index=2比较
       *  2 不大于 6 不交换
       *  2 不大于 4 不交换
       *  2 不大于 5 不交换
       *  2 大于 1，交换，变为 1 3 6 4 5 2，第一趟排序完成。
     */
    // 过程：前面已排序的都是最小的，不用再处理
    func normalBubbleDownSort<T: Comparable>(elements: [T]) -> [T] {
        var array = elements
        guard array.count > 1 else {
            return array
        }
        
        for i in 0..<array.count {
            let border = i + 1
            for j in border..<array.count {
                if array[i] > array[j] {
                    array.swapAt(i, j)
                }
            }
        }
        return array
    }
    
    func bubbleSort<T: Comparable>(elements: [T]) -> [T] {
        var array = elements
        guard array.count > 1 else {
            return array
        }
        
        // 相邻的两个元素比较, 较大的元素往后移
        for i in 0..<array.count { // 依次循环(计数)
            for j in 0..<array.count - i - 1 { // 每次循环剩余遍历的数据
                // 优化：当某次冒泡操作已经没有数据交换时，说明已经达到完全有序，不用再继续执行后续的冒泡操作。
                // 比如：321456 经过2次冒泡变成 123456，第3次冒泡不会有数据交互了，无需再往后遍历了
                var flag = false // 提前退出标志位
                if array[j] > array[j+1] {
                    // 交换数据
                    array.swapAt(j + 1, j)
                    // 此次冒泡有数据交换
                    flag = true
                }
                
                // 没有数据交换，提前退出
                if !flag {
                    break
                }
            }
        }
        
        return array
    }
    
    /**
     * 冒泡排序改进:在每一轮排序后记录最后一次元素交换的位置,作为下次比较的边界,
     * 对于边界外的元素在下次循环中无需比较
     * 比如：321 456 经过1次冒泡 213 456 border变成位置2，接下来只需处理位置2之前的元素，证明位置2后面的元素是有序的
     */
    func borderBubbleSort<T: Comparable>(elements: [T]) -> [T] {
        var array = elements
        guard array.count > 1 else {
            return array
        }
        
        // 最后一次交换的位置
        var lastExchange = 0
        // 无序数据的边界,每次只需要比较到这里即可退出
        var sortBorder = array.count - 1
        
        for _ in 0..<array.count { // 依次循环(计数)
            for j in 0..<sortBorder {
                var flag = false
                if array[j] > array[j+1] {
                    array.swapAt(j + 1, j)
                    flag = true
                    lastExchange = j
                }
                // 定义两个参数方便理解
                sortBorder = lastExchange
                
                if !flag {
                    break
                }
            }
        }
        
        return array
    }
    
}


//MARK: - 插入排序
extension SortAlgo {
    /**
     插入算法的核心思想是取未排序区间中的元素，在已排序区间中找到合适的插入位置将其插入，并保证已排序区间数据一直有序。
     初始已排序区间：a[0]
     未排序区间：剩下元素
     核心：最小的往前插入
     */
    func insertionSort<T: Comparable>(elements: [T]) -> [T]{
        var array = elements
        guard array.count > 1 else {
            return array
        }
        
        for i in 1..<array.count { // 未排序区间
            let cur = array[i] // 当前要插入的值
            var j = i - 1 // 已排序区间，初始为 0
            // 在已排序区间内，查找插入位置
            for p in (0...j).reversed() {
                j = p
                if array[p] > cur {
                    array[p+1] = array[p]
                } else {
                    break
                }
            }
            
            // 已排序区间添加当前要插入元素
            array[j + 1] = cur
        }
        
        return array
    }
    
    // 这个比较好理解，使用while循环
    func insertionWhileSort<T: Comparable>(elements: [T]) -> [T] {
        var array = elements
        guard array.count > 1 else {
            return array
        }
        
        for i in 1..<array.count { // 未排序区间
            let cur = array[i] // 当前要插入的值
            var preIndex = i - 1
            
            // 循环遍历已排序区间，寻找比 元素cur 小的下标位置，遍历过程中，如果元素值大于cur，将元素后移，继续向前查找
            while preIndex >= 0, array[preIndex] > cur {
                array[preIndex + 1] = array[preIndex]
                preIndex -= 1
            }
            
            // 注意：preIndex会在循环里-1，然后循环终止，所以下面要使用preIndex+1，可以写一个数组理解下
            array[preIndex + 1] = cur
        }
        
        return array
    }
}

//MARK: - 希尔排序
extension SortAlgo {
    /**
     1959年Shell发明，第一个突破O(n2)的排序算法，是简单插入排序的改进版。
     它与插入排序的不同之处在于，它会优先比较距离较远的元素。希尔排序又叫缩小增量排序。
     先将整个待排序的记录序列分割成为若干子序列分别进行直接插入排序。
     */
    func shellSort<T: Comparable>(elements: [T]) -> [T] {
        var array = elements
        guard array.count > 1 else {
            return array
        }
        
        var step = array.count / 2
        while step >= 1 {
            // 替换正常插入排序的步长由1为step
            for i in step..<array.count {
                let cur = array[i]
                var preIndex = i - step
                
                while preIndex >= 0, array[preIndex] > cur {
                    array[preIndex + step] = array[preIndex]
                    preIndex -= step
                }
                
                array[preIndex + step] = cur
            }
            
            // 继续缩小步长
            step = step / 2
        }
        
        return array
    }
    
}


//MARK: - 选择排序
extension SortAlgo {
    /**
     选择排序每次会从未排序区间中找到最小的元素，将其放到已排序区间的末尾
     核心：最小的往前移动
     */
    func selectionSort<T: Comparable>(elements: [T]) -> [T] {
        var array = elements
        guard array.count > 1 else {
            return array
        }
        
        for i in 0..<array.count - 1 { // 依次循环(计数)
            var minIndex = i // 初始值为已排序区间最后一个元素（123 最大值3）
            for j in i+1..<array.count { // 未排序区间范围
                if array[j] < array[minIndex] { // 找出未排序区间最小值
                    minIndex = j
                }
            }
            // 交换
            let tmp = array[i]
            array[i] = array[minIndex]
            array[minIndex] = tmp
        }
        
        return array
    }
}

