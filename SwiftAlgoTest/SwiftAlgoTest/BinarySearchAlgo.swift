//
//  BinarySearchAlgo.swift
//  SwiftAlgoTest
//
//  Created by jiajue on 2021/9/7.
//

import Foundation

//MARK: - 二分查找：限定条件 -> 有序数组

class BinarySearchAlgo {
    
    // 二分查找 value 所在位置
    func bsearch(arr: [Int], value: Int) -> Int {
        // 0、1场景补充
        let indexNotFound = -1
        if arr.count == 0 {
            return indexNotFound
        }
        
        if arr.count == 1 {
            if arr.first == value {
                return 0
            } else {
                return indexNotFound
            }
        }
        
        var low = 0
        var high = arr.count - 1
        // 注意1: low<=high
        while low <= high {
            // 注意2: mid = low + (high - low) >> 1 等价于 low+(high-low)/2
            let mid = low + (high - low) >> 1
            if arr[mid] == value {
                // 得到结果
                return mid
            } else if arr[mid] < value {
                // 注意3: 如果直接写成 low=mid 或者 high=mid，就可能会发生死循环
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
        
        return indexNotFound
    }
    
    // 递归写法
    func recursiveBsearch(arr: [Int], value: Int) -> Int {
        return recursiveBsearchInternally(arr: arr, low: 0, high: arr.count - 1, value: value)
    }
    
    func recursiveBsearchInternally(arr: [Int], low: Int, high: Int, value: Int) -> Int {
        let indexNotFound = -1
        if low > high {
            return indexNotFound
        }
        
        let mid = low + (high - low) >> 1
        if arr[mid] == value {
            return mid
        } else if arr[mid] < value {
            return recursiveBsearchInternally(arr: arr, low: mid + 1, high: high, value: value)
        } else {
            return recursiveBsearchInternally(arr: arr, low: low, high: mid - 1, value: value)
        }
    }
    
    // 二分查找的变形问题
    // 1、查找第一个值等于给定值的元素
    func bsearch1(arr: [Int], value: Int) -> Int {
        var low = 0
        var high = arr.count - 1
        while low <= high {
            let mid = low + (high - low) >> 1
            if arr[mid] >= value { // 注意 >=
                high = mid - 1
            } else {
                low = mid + 1
            }
        }
        
        if low < arr.count && arr[low] == value {
            return low
        }
        
        return -1
    }
    
    func bsearch1_1(arr: [Int], value: Int) -> Int {
        var low = 0
        var high = arr.count - 1
        while low <= high {
            let mid = low + (high - low) >> 1
            if arr[mid] > value {
                high = mid - 1
            } else if arr[mid] < value {
                low = mid + 1
            } else {
                // arr[mid] == value 情况处理
                // mid == 0 表示数组第一个元素，再往前没有了，肯定是要找的值
                // arr[mid - 1] != value 表示该元素之前的元素不等于value，那么该元素即为要找的值 6888 a[mid - 1] = 6
                /**
                 前提：有序数组 => 即使存在重复数据，也一定是连续的重复数据
                 arr[mid] == value 情况处理
                 1、mid == 0 表示数组第一个元素，再往前没有了，肯定是要找的值，如：88899，第一个8
                 2、arr[mid - 1] != value 表示该元素之前的元素不等于value，那么该元素即为要找的值
                 如：568889 其中 a[mid - 1] = 6
                 
                 不满足上述情况，说明找到的不是最左边元素，继续 high = mid - 1，向左查找
                 */
                if mid == 0 || arr[mid - 1] != value {
                    return mid
                } else {
                    high = mid - 1
                }
            }
        }
      
        return -1
    }
    
    // 2、查找最后一个值等于给定值的元素
    func bsearch2(arr: [Int], value: Int) -> Int {
        var low = 0
        var high = arr.count - 1
        while low <= high {
            let mid = low + (high - low) >> 1
            if arr[mid] > value {
                high = mid - 1
            } else if arr[mid] < value {
                low = mid + 1
            } else {
                if mid == arr.count - 1 || arr[mid + 1] != value {
                    return mid
                } else {
                    low = mid + 1
                }
            }
        }
        
        return -1
    }
    
    // 3、查找第一个大于等于给定值的元素
    func bsearch3(arr: [Int], value: Int) -> Int {
        var low = 0
        var high = arr.count - 1
        while low <= high {
            let mid = low + (high - low) >> 1
            if arr[mid] >= value {
                if mid == 0 || arr[mid - 1] < value {
                    return mid
                } else {
                    high = mid - 1
                }
            } else {
                low = mid + 1
            }
        }
        
        return -1
    }
    
    // 4、查找最后一个小于等于给定值的元素
    func bsearch4(arr: [Int], value: Int) -> Int {
        var low = 0
        var high = arr.count - 1
        while low <= high {
            let mid = low + (high - low) >> 1
            if arr[mid] <= value {
                if mid == arr.count - 1 || arr[mid + 1] > value {
                    return mid
                } else {
                    low = mid + 1
                }
            } else {
                high = mid - 1
            }
        }
        
        return -1
    }
}
