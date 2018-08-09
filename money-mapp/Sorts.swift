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

func insertionSort(_ purchases: [Purchase]) -> [Purchase] {
    // Swift doesn't allow modification of a parameter
    var copy = purchases
    
    for i in 1..<copy.count {
        // current element that will be compared with elements before it
        let key = copy[i]
        var j = i - 1 // immediate previous element
        
        // iterate backwards to confirm sorted order
        while j >= 0 && increasingOrder(key.cost, copy[j].cost) {
            // if an element's left neighbor is greater, swap their positions
            copy[j + 1] = copy[j]
            
            // check the next neigbor over
            j -= 1
        }
        
        // place the key in its correct location
        copy[j + 1] = key
    }
    print(copy)
    return copy
}
 
