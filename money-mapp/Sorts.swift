//
//  Sorts.swift
//  money-mapp
//
//  Created by Alice Wu on 8/9/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import Foundation

// comparator that determines whether object are sorted in increasing order
func increasingOrder(_ price_a : Double, _ price_b : Double) -> Bool {
    return price_a < price_b
}

func decreasingOrder(_ price_a : Double, _ price_b : Double) -> Bool {
    return price_a > price_b
}

// increasing bool determines whether to run increasing order or decreasing order
func insertionSort(_ purchases: [Purchase], _ increasing: Bool) -> [Purchase] {
    // Swift doesn't allow modification of a parameter
    var copy = purchases
    
    for i in 1..<copy.count {
        // current element that will be compared with elements before it
        let key = copy[i]
        var j = i - 1 // immediate previous element
        
        if increasing {
            // iterate backwards to confirm sorted order
            while j >= 0 && increasingOrder(key.cost, copy[j].cost) {
                // if an element's left neighbor is greater, swap their positions
                copy[j + 1] = copy[j]
                // check the next neigbor over
                j -= 1
            }
            // places key in correct location
            copy[j + 1] = key
        } else {
            // iterate forwards to confirm sorted order
            while j < copy.count && decreasingOrder(key.cost, copy[j].cost) {
                copy[j - 1] = copy[j]
                j += 1
            }
            // place the key in its correct location
            copy[j - 1] = key
        }
    }
    print(copy)
    return copy
}

func reverseArray(_ purchases: [Purchase]) -> [Purchase] {
    var copy = purchases
    
    var i = 0
    var temp : Purchase
    var num_swaps = 0
    var end = copy.count - 1
    
    // number of iterations will equal the number of elements in the array / 2,
    // regardless of odd/even number of elements
    while num_swaps <= copy.count / 2 {
        temp = copy[i]
        copy[i] = copy[end]
        copy[end] = temp
        
        i += 1
        end -= 1
        num_swaps += 1
    }
    // if odd number of elements: check if the middle element needs to be swapped with its right neighbor
    if increasingOrder(copy[copy.count / 2 - 1].cost, copy[copy.count / 2].cost) {
        temp = copy[copy.count / 2]
        copy[copy.count / 2] = copy[copy.count / 2 - 1]
        copy[copy.count / 2 - 1] = temp 
    }
    
    return copy
}
 
