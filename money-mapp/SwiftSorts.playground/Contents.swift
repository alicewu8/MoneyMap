import UIKit

struct Purchase {
    var name : String?
    var cost : Double
    var date : String?
    // multi-line string """ """
    var info : String?
    var id : Int!
}

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
    if !increasing_order {
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

extension Array where Element: Comparable {
    
    func insertionSort(by areInIncreasingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
        var data = self
        
        for i in 1..<data.count { // 1
            let key = data[i] // 2
            var j = i - 1
            
            while j >= 0 && areInIncreasingOrder(key, data[j]) { // 3
                data[j+1] = data[j] // 4
                
                j = j - 1
            }
            
            data[j + 1] = key // 5
        }
        
        return data
    }
}
