//: [Previous](@previous)

import Foundation

/*:
 # Exceptions
 ## Objective:
 Try out basic exception usage

 */

enum CustomError: Error {
    case networkingError(message: String)
    case coreDataError(message: String)
}

func someNetworkFunction(throwError: Bool) throws -> String {
    let returnMessage = "We made it."
    if throwError {
        throw CustomError.networkingError(message: "Couldn't connect.")
    }
    return returnMessage
}

let response0 = try? someNetworkFunction(throwError: true)
print("response0 was: ")
print(response0)

print("\n")
let response1 = try? someNetworkFunction(throwError: false)
print("response1 was: ")
print(response1)



// FATAL ERROR due to implicit unwrap: try!:
//print("\n")
//let response2 = try! someNetworkFunction(throwError: true)
//print("response2 was: ")
//print(response2)

print("\n")
let response3 = try! someNetworkFunction(throwError: false)
print("response3 was: ")
print(response3)


print("\n")
do {
    let response4 = try someNetworkFunction(throwError: true)
    print("response4 was: ")
    print(response4)
} catch CustomError.networkingError(let errorMessage) {
    print("Networking Error with message: " + errorMessage)
} catch CustomError.coreDataError(let errorMessage) {
    print("Core Data Error with message: " + errorMessage)
} catch {
    print("General Error")
}

//: #### Output
/*
 response0 was:
 nil
 
 
 response1 was:
 Optional("We made it.")
 
 
 response3 was:
 We made it.
 
 
 Networking Error with message: Couldn't connect.

 */
//: [Next](@next)



