//: [Previous](@previous)

import Foundation
/*:
 # FizzBuzz
 #### Objective
 My goal here is to implement FizzBuzz using as few statements as possible. Since you can use Array(1...100) to generate the initial array. I thought you could implement fizzBuzz using a map to calculate each element.
*/

print(Array(1...100).map({
    switch $0 {
    case _ where $0 % 15 == 0: return "fizzbuzz"
    case _ where $0 % 3 == 0: return "fizz"
    case _ where $0 % 5 == 0: return "buzz"
    default: return String($0)
    }
}).joined(separator: " "))

// Output:
//  1 2 fizz 4 buzz fizz 7 8 fizz buzz 11 fizz 13 14 fizzbuzz 16 17 fizz 19 buzz fizz 22 23 fizz buzz 26 fizz 28 29 fizzbuzz 31 32 fizz 34 buzz fizz 37 38 fizz buzz 41 fizz 43 44 fizzbuzz 46 47 fizz 49 buzz fizz 52 53 fizz buzz 56 fizz 58 59 fizzbuzz 61 62 fizz 64 buzz fizz 67 68 fizz buzz 71 fizz 73 74 fizzbuzz 76 77 fizz 79 buzz fizz 82 83 fizz buzz 86 fizz 88 89 fizzbuzz 91 92 fizz 94 buzz fizz 97 98 fizz buzz

//: [Next](@next)
