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

// Returns a sorted vector in either increasing or decreasing order
func insertionSort(_ unsorted_values: [Purchase], _ increasing_order: Bool) -> [Purchase] {
    // Swift doesn't allow modification of a parameter
    var copy = unsorted_values
    
    /* To sort values in decreasing order, assume the last element to be sorted
     * and start checking at the second to last. For each iteration, check that
     * elements to the right are smaller than the key. If not, move greater elements
     * one over to the left
     */
    if !increasing_order && copy.count > 1 {
        for i in (0...copy.count - 2).reversed() {
            let key = copy[i]
            var j = i + 1
            
            while j < copy.count && decreasingOrder(copy[j].cost, key.cost) {
                copy[j - 1] = copy[j]
                j += 1
            }
            copy[j - 1] = key
        }
    }
        
        /* To sort values in increasing order, assume the element at index 0 to be sorted
         * and begin checking at index 1. At each index until the last element, check
         * that values to the left of that item are smaller than it. Greater elements
         * will be shifted to the right by one position.
         */
    else {
        for i in 1..<copy.count {
            // current element that will be compared with elements before it
            let key = copy[i]
            var j = i - 1 // immediate previous element
            
            while  j >= 0 && !decreasingOrder(key.cost, copy[j].cost) {
                // shift all elements greater than the key one over to the right
                copy[j + 1] = copy[j]
                // check the next neigbor over
                j -= 1
            }
            
            // The loop breaks once a value to the left is smaller than the key
            // or when the iteration reaches the first element
            copy[j + 1] = key
        }
    }
    
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
 
