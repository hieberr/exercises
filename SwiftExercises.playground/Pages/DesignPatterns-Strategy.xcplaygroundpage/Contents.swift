//: [Previous](@previous)

import Foundation

/*:
 # Strategy Design Pattern (also called Policy pattern)
 ## Objective:
 Implement the Strategy pattern
 
 #### Definition:
 ![Uml](StrategyUml.jpg)
 
 The strategy pattern defines a family of algorithms, encapsulates each algorithm, and makes each  interchangeable within the family.
 The essential feature of the strategy pattern is the ability to store a reference to some code in a datastructure and execute it when needed.  This can be achieved through class inheritence, function pointers, or first class functions ( or even via reflection)
 The strategy pattern:
    - Defines a strategy interface that the client class uses.
    - Defines concrete strategy classes that implement the interface.
    - At run time the client class selects the appropriate strategy implementation to use.
 
 
 #### When to use
 - When a class should be configured with an algorithm instead of directly coding one for the class.
 - When algorithms should be selected and exchanged at runtime.
  
 ## Example:
 */

protocol ISendMessageStrategy {
    func sendMessage(message: String)
}

class SmsStrategy : ISendMessageStrategy {
    init() {
        // connect to SMS server etc.
    }
    func sendMessage(message: String) {
        print("Sending via SMS: \(message)")
    }
}
class EmailStrategy : ISendMessageStrategy {
    init() {
        // connect to email server etc.
    }
    func sendMessage(message: String) {
        print("Sending via email: \(message)")
    }
}

class ResponseBot {
    var responseStrategy: ISendMessageStrategy
    
    init(initialResponseStrategy: ISendMessageStrategy){
        self.responseStrategy = initialResponseStrategy
    }
    func setResponseStrategy(responseStrategy: ISendMessageStrategy) {
        self.responseStrategy = responseStrategy
    }
    func recieveMessage(message: String) {
        responseStrategy.sendMessage(message: "Responding to: \(message)")
    }
}
//: #### Usage

let bot = ResponseBot(initialResponseStrategy: EmailStrategy())
bot.recieveMessage(message: "foo") // responding via email

bot.setResponseStrategy(responseStrategy: SmsStrategy())
bot.recieveMessage(message: "bar") //responding via sms

//: #### Output
/*
 Sending via email: Responding to: foo
 Sending via SMS: Responding to: bar
 */
//: [Next](@next)








