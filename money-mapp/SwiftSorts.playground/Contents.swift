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

func insertionSort(_ purchases: [Purchase]) -> [Purchase] {
    // Swift doesn't allow modification of a parameter
    var copy = purchases

    for i in 1..<copy.count {
        // current element that will be compared with elements before it
        let key = copy[i]
        var j = 1 - 1 // immediate previous element
        
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
