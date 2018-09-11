/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)
 
 September 2018
 
 # Multiples of 3 and 5
 
 If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
 
 Find the sum of all the multiples of 3 or 5 below 1000.
 
 Complexity: O(n)
 
 */
import Foundation

func sumOfMultiplesOf3and5(below number: Int) -> Int {
    var sum = 0
    
    for i in 0..<number {
        sum += i % 3 == 0 || i % 5 == 0 ? i : 0
    }
    
    return sum
}

sumOfMultiplesOf3and5(below: 1000)

/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)
 */
