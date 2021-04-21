//
//  main.swift
//  BinarySearch
//
//  Created by Владимир Гуль on 21.04.2021.
//

import Foundation

//binary search: input - value to search, array where searching
func BinarySearch(_ toFind: Int, _ arr: Array<Int>) -> Int{
    //boundaries
    var low_index = 0
    var high_index = arr.count
    var mid : Int = 0
    //changing low and hight depending on the arr[mid] > or < value we finding
    while low_index <= high_index{
        mid = (low_index + high_index) / 2
        //we find it
        if arr[mid] == toFind {return mid}
        //changing boundaries
        if arr[mid] < toFind{
            low_index = mid + 1
        } else {
            high_index = mid - 1
        }
    }
    print("Not found")
    return 0
}

print("Input array length")
let count_ = readLine()
print("Input number to find")
let number_ = readLine()

if let count = Int(count_!), let number = Int(number_!){
    let arr = Array(1...count)
    let startTime = CFAbsoluteTimeGetCurrent()
    print("Index of element - \(BinarySearch(number, arr))")
    print("Time spent \(CFAbsoluteTimeGetCurrent() - startTime)")
} else {
    print("Incorrect data")
}


