//: [Previous](@previous)

import Foundation

/*:
 # Null Object Design pattern
 ## Objective:
 Implement the Null Object pattern
 
 #### Definition:
 ![Uml](NullObjectUml.png)
 
 - The null object pattern provides an object as a surrogate for the lack of an object of a given type.
 - Use the null object pattern when an object might or might not exist and you want to avoid excessive null checking.
 
 #### Specific Problems and Implementations
 Null Object and Factory:
  The null object pattern is likely to be used with the factory pattern because a factory must return a concrete class to the client. If an invalid configuration is given to the factory, then it can return a null object.
 Null Object and Template Method
   The Template method design pattern needs to define an abstract class that defines the template and each concrete class implements the steps for the template. If there are cases when sometimes the template is called and sometimes not, then in order to avoid null checks.
 Removing old functionality
   The null object can be used to remove old functionality by replacing it with null objects. The big advantage is thatthe existing code doesn't need to be touched.
 
 ## Example:
 */

protocol Logger {
    func log(message: String)
}
private class NullLogger : Logger {  // private since nobody should be able to create this except the LoggerFactory.
    func log(message: String) {
        // do nothing
    }
}

class TerminalLogger : Logger {
    func log(message: String) {
        print("Terminal: \(message)")
    }
}
class DatabaseLogger : Logger {
    func log(message: String ) {
        print("Database: \(message)")
    }
}

class LoggerFactory {
    enum LoggerTypes {
        case terminal, database, disabled
    }
    
    static func getLogger(type: LoggerTypes) -> Logger {
        switch type {
        case .terminal: return TerminalLogger()
        case .database: return DatabaseLogger()
        case .disabled: return NullLogger()
        }
    }
}
//: #### Usage
var logger = LoggerFactory.getLogger(type: .terminal)
logger.log(message: "some message") // logs to the terminal

logger = LoggerFactory.getLogger(type: .disabled)
logger.log(message: "some message") // does nothing.
//: #### Output
/*
 Terminal: some message
 */
//: [Next](@next)




