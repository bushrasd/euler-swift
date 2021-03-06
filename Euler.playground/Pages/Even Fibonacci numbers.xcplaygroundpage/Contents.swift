/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)
 
 September 2018
 
 # Even Fibonacci numbers
 
 Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:
 
 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
 
 By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.
 
 */
/*:
 ## Fibonacci number at a given index - using Memoization
 
 First let's write a function to find the fibonacci number at a given index with memoization.
 */
import Foundation

func fibonacciNumber(at index: Int, memo: inout [Int: Int]) -> Int {
    if let memoNumber = memo[index] {
        return memoNumber
    }
    
    var nextFibNumber = 0
    switch index {
    case ..<0: nextFibNumber = 0
    case 0: nextFibNumber = 1
    case 1: nextFibNumber = 2
    default: nextFibNumber = fibonacciNumber(at: index - 1, memo: &memo) + fibonacciNumber(at: index - 2, memo: &memo)
    }
    memo[index] = nextFibNumber
    
    return nextFibNumber
}

var memo: [Int: Int] = [:]
fibonacciNumber(at: 4, memo: &memo)

/*:
 ## Sum of Even Fibonacci numbers
 
 Using the memoized fibonacci function, we can find the sum of even fibonacci numbers less than a given limit relatively quickly.
 
 Complexity: O(n)
 
 Note: Memoization removes the need to calculate the fibonacci numbers repeatedly.
 
 */
func sumOfEvenFibonacciNumbers(lessThan limit: Int) -> Int {
    var sum = 0
    var index = 0
    var memo: [Int: Int] = [:]
    var number = fibonacciNumber(at: index, memo: &memo)
    while number <= limit {
        sum += number % 2 == 0 ? number : 0
        index += 1
        number = fibonacciNumber(at: index, memo: &memo)
    }
    
    return sum
}

sumOfEvenFibonacciNumbers(lessThan: 4000000)

/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)
 */
