//: [Previous](@previous)

import Foundation
/*:
 # MergeSort
 #### Objective
 Implement MergeSort using swift
 
 #### Description
 - MergeSort is O(nlg(n))
 - It is more efficient for larger n, but constant factors make it less efficient for small n. So don't use MergeSort when you know that n is going to always be small.
 */

func mergeSort(array: inout Array<Int>) {

    func _mergeSort(array: inout Array<Int>, start: Int, end: Int) {
        if start < end {
            let mid: Int = ((start + end) / 2)

            _mergeSort(array: &array, start: start, end: mid)
            _mergeSort(array: &array, start: mid + 1, end: end)
            merge(array: &array, start: start, mid: mid, end: end)
        }
    }
    
    func merge(array: inout Array<Int>, start: Int, mid: Int, end: Int) {
        // create temporary arrays and fill them with the left and right partitions.
        var lhs: Array<Int> = Array(array[start...mid])
        var rhs: Array<Int> = Array(array[(mid+1) ... end])
        
        lhs.append(Int.max) // append maxint to each so that the arrays never run out.
        rhs.append(Int.max)
        var leftIndex = 0
        var rightIndex = 0
        
        for arrayIndex in start...end {
            if lhs[leftIndex] > rhs[rightIndex] {
                array[arrayIndex] = rhs[rightIndex]
                rightIndex += 1
            } else {
                array[arrayIndex] = lhs[leftIndex]
                leftIndex += 1
            }
        }
    }
    
    _mergeSort(array: &array, start: 0, end: array.count-1)
}

//: #### Usage:
var array = [1,2,0,4,99,33]
print("Sorting: \t\(array)")
mergeSort(array: &array)
print("Sorted:\t\t\(array)\n")

array = [5]
print("Sorting: \t\(array)")
mergeSort(array: &array)
print("Sorted:\t\t\(array)\n")

array = [9,8,7,6,5,4]
print("Sorting: \t\(array)")
mergeSort(array: &array)
print("Sorted:\t\t\(array)\n")

array = [1,2,3]
print("Sorting: \t\(array)")
mergeSort(array: &array)
print("Sorted:\t\t\(array)\n")
//: #### Output
/*
 Sorting:     [1, 2, 0, 4, 99, 33]
 Sorted:        [0, 1, 2, 4, 33, 99]
 
 Sorting:     [5]
 Sorted:        [5]
 
 Sorting:     [9, 8, 7, 6, 5, 4]
 Sorted:        [4, 5, 6, 7, 8, 9]
 
 Sorting:     [1, 2, 3]
 Sorted:        [1, 2, 3]
 */

//: [Next](@next)
