//: [Previous](@previous)

import Foundation
print("\n\n ==== Enum Associated Types===")
/*:
 # Enumerations in Swift
  Enums declare types with finite sets of possible states and accompanying values. With nesting, methods, associated values, and pattern matching, however, enums can define any hierarchically organized data.
 
 */

/*:
 # Enum exercise: Associated Type
 
 ## Objective
 My goal here is to convert the width: argument in the fetch() function below to take an enum instead of a Float.  The enum can define some standard sizes as well as providing a custom size using an associated type. This gives the client a hint at the categories they should use while still providing the flexibility for them to add custom sizes.
 
 */

//: ## Initial Example using CGFloat
class ImageProviderWithFloat {
    static func fetch(name: String, width: Float) {
        print("Fetching Image with width: \(width)")
    }
}

//: ## Enum example

enum ImageSize {
    case small
    case medium
    case large
    case custom(width: Float)
    
    var value : Float {
        get {
            switch self {
            case .small: return 300
            case .medium: return 500
            case .large: return 900
            case .custom(let width): return width
            }
        }
    }
}

class ImageProviderWithEnum {
    static func fetch(name: String, width: ImageSize) {
        print("Fetching Image with width: \(width.value)")
    }
}

//: #### Usage

print("Original Example")
ImageProviderWithFloat.fetch(name: "image.png", width: 300)

print("\nEnum Example")
ImageProviderWithEnum.fetch(name: "image.png", width: ImageSize.small)
ImageProviderWithEnum.fetch(name: "image.png", width: ImageSize.custom(width: 1024))

//: #### Output
/*
Float Example
Fetching Image with width: 300.0

Enum Example
Fetching Image with width: 300.0
Fetching Image with width: 1024.0
*/

print("\n\n ====Using enums associated type for error codes===")
/*:
# Enum exercise: Associated Type for ErrorCodes

## Objective
 Implement a simple vending machine class which throws errors defined in an enum.  I've also been learning about structs, so as a bonus I want to implement the VendingMachine object as a struct. Realistically this is a good candidate for a class since it is maintaining state over time and every function is mutating.
*/

//: ## Example

struct Item {
    var price: Float
    var count: Int
}

struct VendingMachine {
    enum VendingError: Error {
        case invalidSelection(invalidItem: String)
        case insufficientFunds(amountShort: Float)
        case outOfStock
    }
    var inventory : [String : Item]
    
    var moneyDeposited : Float = 0
    
    init(inventory initialInventory: [String : Item]) {
        inventory = initialInventory
    }
    mutating func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingError.invalidSelection(invalidItem: name)
        }
        guard item.count > 0 else {
            throw VendingError.outOfStock
        }
        guard item.price <= moneyDeposited else {
            throw VendingError.insufficientFunds(amountShort: item.price - moneyDeposited)
        }
        
        moneyDeposited -= item.price
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
    
    mutating func depositMoney(amount: Float) {
        moneyDeposited += amount
    }
}

//: #### Usage
//helper function to buy an item and handle the error.
func buyItem(from: inout VendingMachine, item: String) {
    do {
        try from.vend(itemNamed: item)
    } catch  VendingMachine.VendingError.invalidSelection(let invalidName) {
        print("Invalid Item: \(invalidName)")
    } catch  VendingMachine.VendingError.insufficientFunds(let amountShort) {
        print("InsufficientFunds short by: \(amountShort)")
    } catch  VendingMachine.VendingError.outOfStock{
        print("OutOfStock")
    } catch {
        print("Error")
    }
}

var vendingMachine = VendingMachine(inventory:  [
    "Candy Bar" : Item(price: 1.25, count: 20),
    "Chips" : Item(price: 2.00, count: 10),
    "Pretzels" : Item(price: 1.75, count: 0)
    ])

buyItem(from: &vendingMachine, item: "Chips") //insufficient funds
vendingMachine.depositMoney(amount: 2)
buyItem(from: &vendingMachine, item: "IceCream")// invalid item
buyItem(from: &vendingMachine, item: "Pretzels")// out of stock
buyItem(from: &vendingMachine, item: "Chips") // OK! dispensing chips


//: #### Output
/*
 InsufficientFunds short by: 2.0
 Invalid Item: IceCream
 OutOfStock
 Dispensing Chips
 */
//: [Next](@next)

print("\n\n ====Using enums for bit flags===")
/*:
 # Enum exercise: Using enums for Bit Flags
 
 ## Objective
 enums in swift are a way to give readable names for bit flags.  You could also use static ints.
 */

//: ## Example
enum VNodeFlags : UInt32 {
    case Delete = 0x00000001
    case Write = 0x00000002
    case Extended = 0x00000004
    case Attrib = 0x00000008
    case Link = 0x00000010
    case Rename = 0x00000020
    case Revoke = 0x00000040
    case None = 0x00000080
}

//: #### Usage
let flags : UInt32  = VNodeFlags.Delete.rawValue | VNodeFlags.Write.rawValue

print(flags)

//: #### Output
/*
 3
 */

print("\n\n ====Recursive Enums===")
/*:
 # Enum exercise: Recursive enum
 
 ## Objective

 
 */

//: ## Initial Example


//: #### Usage


//: #### Output
/*

 */
//: [Next](@next)
