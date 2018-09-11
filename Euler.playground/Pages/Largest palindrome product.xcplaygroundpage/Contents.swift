/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)
 
 September 2018
 
 # Largest palindrome product
 
 A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
 
 Find the largest palindrome made from the product of two 3-digit numbers.
 */
import Foundation

/*:
 ## Largest palindrome product by checking multiples of 11
 
 First observation is that the number must be between 100^2 and 999^2 or in the range of [10000, 998001]. As the majority of numbers has 6 digits and we're looking for the largest, we ignore 5 digits numbers. Based on this, we can construct a palindromic number as:
 
        ′abccba′    = 100000a + 10000b + 1000c + 100c + 10b +a
                    = 100001a + 10010b + 1100c
                    = 11(9091a + 910b + 100c)
 As such, we're looking for two largest numbers p, q where 100 <= p, q <= 999 and
 
        p * q = 11(9091a + 910b + 100c) <= 999^2
 
 This equation shows us, that either p or q, but not both must have a factor of 11. We can now find product of multiples p and q where p % 11 == 0 and 100 <= p, q <= 999.
 
 It can be optimized by stop decrementing q when the product becomes less than the largest palindrome product already calculated. A similar optimation is to stop decrementing q when a palindrome product greater than the currrent largest product is found beacuse a product of smaller numbers won't produce a greater number.
 
 Complexity:    O(n^2)
 */
func isPlaindromeUsingReversal(_ number: Int) -> Bool {
    return String(number) == String(String(number).reversed())
}

isPlaindromeUsingReversal(9045409)

func largestMultiple(of divisor: Int, lessThanOrEqualTo number: Int) -> Int {
    guard number > divisor else { return 0 }
    for i in stride(from: number, through: 1, by: -1) where i % divisor == 0 {
        return i
    }
    return 0
}

largestMultiple(of: 11, lessThanOrEqualTo: 999)

func largestPalindromeProductOfTwoNumbersCheckingMultiplesOf11(numberOfDigits n: Int) -> Int {
    let largestNDigitNumber = Int(pow(10.0, Double(n))) - 1
    let smallestNDigitNumber = Int(pow(10.0, Double(n-1)))
    var largestPalindromeProduct = 0
    
    let largestMultipleOf11 = largestMultiple(of: 11, lessThanOrEqualTo: largestNDigitNumber)
    
    for p in stride(from: largestMultipleOf11, through: smallestNDigitNumber, by: -11) {
        for q in stride(from: largestNDigitNumber, through: smallestNDigitNumber, by: -1) {
            let product = p * q
            if product <= largestPalindromeProduct {
                // We can break the loop now because if we decrease the multiplier q further, the product will be smaller than the largest palindrome product.
                break
            } else if isPlaindromeUsingReversal(product) {
                largestPalindromeProduct = product
                // We can break the loop now because if we decrease the multiplier q further, the product will be smaller than the largest palindrome product.
                break
            }
        }
    }
    
    return largestPalindromeProduct
}

largestPalindromeProductOfTwoNumbersCheckingMultiplesOf11(numberOfDigits: 3)

/*:
 ## Largest palindrome product by checking all possible multiplier combinations
 
 In this method, we calculate the product of all possible combinations of two integers, say p & q, with 3 digits.
 
 This can similarly be optimized by stop decrementing q when the product becomes less than the largest palindrome product already calculated. Another optimation is to stop decrementing q when a palindrome product greater than the currrent largest product is found beacuse a product of smaller numbers won't produce a greater number.
 
 Complexity:    O(n^2)
 */
func largestPalindromeProductOfTwoNumbers(numberOfDigits n: Int) -> Int {
    let largestNDigitNumber = Int(pow(10.0, Double(n))) - 1
    let smallestNDigitNumber = Int(pow(10.0, Double(n-1)))
    var largestPalindromeProduct = 0
    
    for p in stride(from: largestNDigitNumber, through: smallestNDigitNumber, by: -1) {
        for q in stride(from: largestNDigitNumber, through: p, by: -1) {
            let product = p * q
            if product <= largestPalindromeProduct {
                // We can break the loop now because if we decrease the multiplier q further, the product will be smaller than the largest palindrome product.
                break
            } else if isPlaindromeUsingReversal(product) {
                largestPalindromeProduct = product
                // We can break the loop now because if we decrease the multiplier q further, the product will be smaller than the largest palindrome product.
                break
            }
        }
    }
    
    return largestPalindromeProduct
}

largestPalindromeProductOfTwoNumbers(numberOfDigits: 2)

/*:
 # Some palindrome checking variations
 */
/*:
 ## Check palindrome using two pointers method
 
 In this method, we start comparing the elements at opposite ends of a string (or integer) and compare till the middle. It can be done directly to the digits of an integer or by converting ghte integer to a string and then doing the comparison. Since swift string is a collection, the integer implementation will be very similar to the string.
 */
func isPalindromeUsingPointers(_ string: String) -> Bool {
    
    guard string.count > 1 else { return true }
    
    var left = string.startIndex
    var right = string.index(before: string.endIndex)
    
    while left <= right {
        
        if string[left] != string[right] {
            return false
        }
        left = string.index(after: left)
        right = string.index(before: right)
    }
    
    return true
}

isPalindromeUsingPointers("\(9045409)")

func digits(_ number: Int) -> [Int] {
    var digits: [Int] = []
    var dividend = number
    while dividend > 0 {
        digits.insert(dividend % 10, at: 0)
        dividend /= 10
    }
    return digits
}

/*:
 ## Check palindrome by comparing halfs
 
 In this method, we create an array of digits, then divide the array into two halves around the center and compare if the right half is the reverse of the left half or vice versa.
 */
func isPalindromeUsingHalving<T: Equatable>(_ array: [T]) -> Bool {
    guard array.count > 1 else { return true }
    let leftMaxIndex = array.count/2
    let rightMinIndex = array.count % 2 == 0 ? array.count/2 : array.count/2 + 1
    let left = Array(array[..<leftMaxIndex])
    let right = Array(array[rightMinIndex...])
    return left == right.reversed()
}

func isPalindromeUsingHalving(_ number: Int) -> Bool {
    let digitsArray = digits(number)
    return isPalindromeUsingHalving(digitsArray)
}

isPalindromeUsingHalving(9045409)

/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)
 */
