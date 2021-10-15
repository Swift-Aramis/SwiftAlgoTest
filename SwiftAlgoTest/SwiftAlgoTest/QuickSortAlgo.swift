//
//  QuickSortAlgo.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/8/31.
//

import Foundation

/**
 快排的思想是这样的：如果要排序数组中下标从 p 到 r 之间的一组数据，我们选择 p 到 r 之间的任意一个数据作为 pivot（分区点）。
 快速排序的基本思想：通过一趟排序将待排记录分隔成独立的两部分，其中一部分记录的关键字均比另一部分的关键字小，则可分别对这两部分记录继续进行排序，以达到整个序列有序。
 */

/**
 快速排序使用分治法来把一个串（list）分为两个子串（sub-lists）。具体算法描述如下：

 1、从数列中挑出一个元素，称为 “基准”（pivot）；
 2、重新排序数列，所有元素比基准值小的摆放在基准前面，所有元素比基准值大的摆在基准的后面（相同的数可以到任一边）。在这个分区退出之后，该基准就处于数列的中间位置。这个称为分区（partition）操作；
 3、递归地（recursive）把小于基准值元素的子数列和大于基准值元素的子数列排序。
 */

class QuickSortAlgo {
    
    func quickSort<T: Comparable>(elements: [T]) -> [T] {
        guard elements.count > 1 else {
            return elements
        }
        
        var arr = elements
        quickSortInternally(arr: &arr, left: 0, right: arr.count - 1)
        return arr
    }
    
    // 快速排序递归函数
    func quickSortInternally<T: Comparable>(arr: inout [T], left: Int, right: Int) {
        // 递归终止条件
        if (left >= right) {
            return
        }
        
        // 获取分区点（pivot）
        let pivot = partition(arr: &arr, left: left, right: right)
        // 递归
        quickSortInternally(arr: &arr, left: left, right: pivot - 1)
        quickSortInternally(arr: &arr, left: pivot + 1, right: right)
    }
    
    func partition<T: Comparable>(arr: inout [T], left: Int, right: Int) -> Int {
        let pivot = arr[left]  // 设定初始基准值（pivot）
        var j = left // j用来记录pivot应该在的下标位置，起始点为left
        
        // 最终实现结果：arr[left+1 ... j] < v ; arr[j+1 ... right] > v
        // 遍历：范围为pivot之后的元素
        for i in left + 1..<right {
            // 若 cur > pivot，继续向后遍历，元素值本身就在pivot右侧，无需移动
            // 若 cur < pivot，将j标记位右移，元素值移动到pivot左侧，交互i与j位置元素
            let cur = arr[i]
            if cur < pivot {
                j += 1
                arr.swapAt(j, i)
            }
        }
        
        // j为最终povit位置，初始值在left位置，元素交换
        arr.swapAt(left, j)
        return j
        
        
        // 以下脑补一次遍历过程：
        /**
         1、i++
         2、遍历过程中，pivot位置一直不变，为left
         3、有比pivot小的值，j后移，交换元素
         4、遍历结束后，j左侧都小，j右侧都大，
         */

        // left           right
        
        // pivot
        
        // j  i
        // 6  11  3   9   8
        
        //    j   i
        // 6  11  3   9   8
        // 6  3  11   9   8
        
        //    j       i
        // 6  3  11   9   8
        
        //    j           i
        // 6  3  11   9   8
       
        // 遍历过程中，pivot位置一直没变，所以需要j与left交换，修正pivot位置
        //    j           i
        // 3  6  11   9   8
    }
    
    
    //MARK: - 快速排序：while循环查找partion
    
    func quickSortWhileCycle<T: Comparable>(arr: inout [T], left: Int, right: Int) {
        //MARK: - 关键逻辑：1、子数组长度为1时，终止递归；2、原则：pivot左侧均比它小，右侧均比它大。
        /**
         过程：while ( i < j) 持续循环，两端移动指针，交换不符合条件的 i,j
         */
        // 子数组长度为1时，终止递归
        if left >= right {
            return
        }
        
        // 初始化哨兵索引位置（以arr[l]作为基准数）
        var i = left, j = right
        // 循环交换，两哨兵相遇时跳出
        while i < j {
            // 从右向左 查找 首个小于基准数的元素
            while i < j, arr[j] >= arr[left] {
                j -= 1
            }
            // 从左向右 查找 首个大于基准数的元素
            while i < j, arr[i] <= arr[left] {
                i += 1
            }
            // arr[left ... i - 1] < v < arr[i+1 ... right]
            arr.swapAt(i, j)
        }
        // 交换基准数 arr[left] 和 arr[i]
        arr.swapAt(i, left)
        
        // 递归左（右）子数组执行哨兵划分
        quickSortWhileCycle(arr: &arr, left: left, right: i - 1)
        quickSortWhileCycle(arr: &arr, left: i + 1, right: right)
    }
}
