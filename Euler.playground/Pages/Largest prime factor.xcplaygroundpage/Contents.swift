/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)
 
 September 2018
 
 # Largest prime factor
 
 The prime factors of 13195 are 5, 7, 13 and 29.
 
 What is the largest prime factor of the number 600851475143
 
 */
/*:
 ## Prime factorization - Using Squareroots
 
 Factors of a number greater than its squareroot are compliments of its factors less than the squareroot. Therefor, all factors of a number can be calculated if the factors of the number upto its sqaure root are known.

 Using this information, we find the largest prime factor by finding the largest factor of a number that is less than or equal to its squareroot whose compliment or the factor itself is a prime number
 
 Finally, because the largest factor of a number is itself because for any n * 1 = n, checking whether the number itself is a prime number will reduce the number of operations to be performed.
 
 We use the loop method to check for prime number because the Sieve of Eratosthenes runs through several loops instead of one. That would be a more efficient way of finding all prime numbers less than a given number.
 
 Complexity:    O(n) + O(1) + O( sqrt(n) * sqrt(n) ) = O(n)
 
 1. Checking if the number is prime: O(n)
 2. Squareroot: Assume O(1). O(M(n)) using e.g. Newton’s iteration, where M(n) is the time needed to multiply two n-digit integers. If we assume multiplication to be a O(1) then we can assume that squareroot is also O(1)
 3. Run from squareroot to 2 is O(sqrt(n)) multiplied by O(sqrt(n)) for checking if the number is a prime number.
 
 */
import Foundation

func isPrimeNumber(_ number: Int) -> Bool {
    guard number > 2 else { return true }
    for i in 2..<number {
        if number % i == 0 { return false }
    }
    return true
}

func largestPrimeFactor(_ number: Int) -> Int {
    guard !isPrimeNumber(number) else { return number }
    
    let squareRoot = Int(sqrt(Double(number)))
    
    for divisor in stride(from: squareRoot, through: 2, by: -1) {
        if number % divisor == 0 {
            
            let quotient = number / divisor
            
            if isPrimeNumber(quotient) {
                return quotient
            } else if isPrimeNumber(divisor) {
                return divisor
            }
        }
    }
    
    return number
}

largestPrimeFactor(600851475143)

/*:
 ## Other solutions
 */
/*:
 
 ## Sieve of Eratosthenes
 
 Sieve of Eratosthenes can be used to find all prime numbers less than a given number. It returns an array with 'number' integers. The value at an index is 1 if the index is a prime number and 0 otherwise. This method uses the Sieve of Eratosthenes to set 1 for the prime indices. More info on that can be found on [Wikipedia.](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes)
 */
func sieveOfEratosthenes(_ number: Int) -> [Int] {
    var sieve = Array(repeating: 1, count: number+1)
    
    var p = 2
    
    while p*p < sieve.count {
        if sieve[p] == 1 {
            var index = p*p
            while index < sieve.count {
                sieve[index] = 0
                index += p
            }
        }
        p += 1
    }
    return sieve
}
 
/*:
 ## Prime factorization by dividing with prime numbers
 
 In this approach, we divide the number with prime numbers until we find a quotient that is also a prime number. The quotient then is the largest prime factor.
 
    66 / 2 = 33 / 3 = 11
    13195 / 5 = 2639 / 7 = 377 / 13 = 29
 */
func largestPrimeFactorByPrimeDivision(_ number: Int) -> Int {
    
    let sieve = sieveOfEratosthenes(number)
    
    var dividend = number
    
    for i in 2..<sieve.count where sieve[i] == 1 {
        let primeNumber = i
        while dividend % primeNumber == 0 {
            if sieve[dividend] == 1 {
                return dividend
            }
            dividend /= primeNumber
        }
    }
    
    return dividend
}

largestPrimeFactorByPrimeDivision(13195)

/*:
 ## Prime factorization by dividing with all numbers
 
 In this approach, we keep dividing the number with numbers from 2 to the number itself until its divisible and save the result as the dividend. When the dividend becomes 1, the divisor is the prime number
 
 
    66 / 2 = 33 / 3 = 11 / 4, 5, 6, 7, 8, 9, 10 = 11 / 11 = 1
    13195 / 2 = 13195 / 3 = 13195 / 4 = 13195 / 5 = 2639 / 5 = 2639 / 6, 7, 8, 9, 10, 11, 12 = 2639 / 13 = 29 / 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28 = 29 / 29 = 1
 
 As compared to the previous approach we avoid finding the list of prime numbers and checking if the dividend is a prime number.
 
 Complexity:    O(n)
 */
func largestPrimeFactorByDivision(_ number: Int) -> Int {
    guard number > 2 else { return number }
    
    var dividend = number
    var largestFactor = dividend
    for divisor in 2..<number {
        
        while dividend % divisor == 0 {
            
            if dividend == 1 {
                return largestFactor
            }
            
            dividend /= divisor
            largestFactor = divisor
        }
    }
    return largestFactor
}

largestPrimeFactorByDivision(13195)

/*:
 [Table of contents](Table%20of%20contents) • [Previous page](@previous) • [Next page](@next)
 */
