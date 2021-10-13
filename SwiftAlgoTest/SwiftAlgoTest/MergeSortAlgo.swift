//
//  MergeSortAlgo.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/8/31.
//

import Foundation

/**
 归并排序是建立在归并操作上的一种有效的排序算法。
 该算法是采用分治法（Divide and Conquer）的一个非常典型的应用。
 将已有序的子序列合并，得到完全有序的序列；即先使每个子序列有序，再使子序列段间有序。
 若将两个有序表合并成一个有序表，称为2-路归并。
 */

/**
 1、分割序列得到子序列，直到无法分割
 2、子序列排序 & 子序列合并
 */

class MergeSortAlgo {
    
    func mergeSort<T: Comparable>(elements: [T]) -> [T] {
        let array = elements
        guard array.count > 1 else {
            return array
        }
        
        let middle = array.count / 2
        let left = Array(array[0..<middle])
        let right = Array(array[middle..<array.count])
        return merge(left: mergeSort(elements: left), right: mergeSort(elements: right))
    }
    
    func merge<T: Comparable>(left: [T], right: [T]) -> [T] {
        var result = [T]()
        var leftArray = left
        var rightArray = right
        
        while leftArray.count > 0, rightArray.count > 0 {
            if leftArray.first! > rightArray.first! {
                result.append(leftArray.first!)
                leftArray.removeFirst()
            } else {
                result.append(rightArray.first!)
                rightArray.removeFirst()
            }
        }
        
        while leftArray.count > 0 {
            result.append(leftArray.first!)
            leftArray.removeFirst()
        }
        
        while rightArray.count > 0 {
            result.append(rightArray.first!)
            rightArray.removeFirst()
        }
        
        return result
    }
}

