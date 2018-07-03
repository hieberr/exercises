//: [Previous](@previous)
import Foundation
/*:
 # Map, Filter, Reduce and Flatmap
 ## Objective: Experiment with filter, reduce, and flatmap
*/

print("====== Map =======")
// ### Map
let charArray = ["a", "b", "c", "d", "e"]

// ### Map including index: Use map on enumerated()
let charIndexArray = charArray.enumerated().map{(index, element) in return String(index) + element}
print(charIndexArray.joined(separator: " "))

print("====== Reduce =======")
// ### Reduce
print(charIndexArray.reduce("", {$0 + " " + $1}))
// trailing form
print(charIndexArray.reduce("") {$0 + " " + $1})

print("====== Filter =======")
// ### Filter
print(charArray.filter{"a c e".contains($0)}.joined(separator: " "))
print(charArray.enumerated().filter{ (index, element) in return index < 3}.map{$0.element}.joined(separator: " "))

print("====== Flatmap =======")
// ### Flatmap
let codes = ["abc","xyz","qqq","msft"]

print(codes.flatMap{$0})
print(codes.flatMap{$0.map{String($0).uppercased()}}.reduce(""){$0 + $1})

// flatmap first removes nil for you
let numbers = [[1.2, 1.3, 6.6], nil, [5.5, 3.2], [2.4], [1.0]]
print(numbers.flatMap{$0})
// then flattens the array
print(numbers.flatMap{$0}.flatMap{$0})
// round each element
print(numbers.flatMap{$0}.flatMap{$0}.map{String($0.rounded())})

//: #### Output
/*
 ====== Map =======
 0a 1b 2c 3d 4e
 ====== Reduce =======
 0a 1b 2c 3d 4e
 0a 1b 2c 3d 4e
 ====== Filter =======
 a c e
 a b c
 ====== Flatmap =======
 ["a", "b", "c", "x", "y", "z", "q", "q", "q", "m", "s", "f", "t"]
 ABCXYZQQQMSFT
 [[1.2, 1.3, 6.5999999999999996], [5.5, 3.2000000000000002], [2.3999999999999999], [1.0]]
 [1.2, 1.3, 6.5999999999999996, 5.5, 3.2000000000000002, 2.3999999999999999, 1.0]
 ["1.0", "1.0", "7.0", "6.0", "3.0", "2.0", "1.0"]
 */
//: [Next](@next)
