//: [Previous](@previous)

import Foundation

/*:
 # Mediator Design Pattern
 ## Objective:
 Implement the Mediator Pattern
 
 #### Definition:
 ![Uml](MediatorUml.jpg)
 
 The mediator object sits between two objects that need to communicate so that each change independently.
 - Tight coupling between a set of interacting objects should be avoided.
 - It should be possible to change the interaction between a set of objects independently.

 
 #### Specific Problems and Implementations
 - While this pattern aims to reduce complexity, without proper design, the Mediator object itself can become very complicated itself.The Observer pattern could help here, with the colleague objects dealing with the events from the mediator, rather than having the mediator look after all orchestration.
 
 #### Mediator vs observer
 Mediator and Observer are competing patterns. The difference between them is that Observer distributes communication by introducing "observer" and "subject" objects, whereas a Mediator object encapsulates the communication between other objects. We've found it easier to make reusable Observers and Subjects than to make reusable Mediators.
 
 ## Example: (https://medium.com/@NilStack/swift-world-design-patterns-mediator-e6b3c35d68b0)
 This example has three objects where each needs to send messages to both of the other types.
 ![ExampleBefore](MediatorExampleBefore.png)
 
 This is a tight coupling between all these different classes which makes them hard to change or to add new roles.  This can be alleviated by adding a mediator class which since in between and manages the sending of messages between everyone.
 
 ![ExampleAfter](MediatorExampleAfter.png)
 

 */
protocol Mediator {
    func send(message: String, sender: Colleague)
}

class TeamMediator : Mediator {
    var colleagues: [Colleague] = []
    func register(colleague: Colleague) {
        colleagues.append(colleague)
    }
    func send(message: String, sender: Colleague) {
        for colleague in colleagues {
            if colleague.id != sender.id {
                colleague.receive(message: message)
            }
        }
    }
}

protocol Colleague {
    var id: String {get}
    var mediator: Mediator {get}
    func send(message: String)
    func receive(message: String)
}

class Developer: Colleague {
    var id: String
    var mediator: Mediator
    
    init(mediator: Mediator) {
        self.id = "Developer"
        self.mediator = mediator
    }
    
    func send(message: String) {
        mediator.send(message: message, sender: self)
    }
    
    func receive(message: String) {
        print("Developer received: " + message)
    }
}

class QE: Colleague {
    var id: String
    var mediator: Mediator
    
    init(mediator: Mediator) {
        self.id = "QE"
        self.mediator = mediator
    }
    
    func send(message: String) {
        mediator.send(message: message, sender: self)
    }
    
    func receive(message: String) {
        print("QE received: " + message)
    }
}

class PM: Colleague {
    var id: String
    var mediator: Mediator
    
    init(mediator: Mediator) {
        self.id = "PM"
        self.mediator = mediator
    }
    
    func send(message: String) {
        mediator.send(message: message, sender: self)
    }
    
    func receive(message: String) {
        print("PM received: " + message)
    }
    
}
//: #### Usage
let mediator = TeamMediator()
let qe = QE(mediator: mediator)
let developer = Developer(mediator: mediator)
let pm = PM(mediator: mediator)

mediator.register(colleague: developer)
mediator.register(colleague: qe)
mediator.register(colleague: pm)

mediator.send(message: "Message from developer", sender: developer)
print("\n")
mediator.send(message: "Message from QE", sender: qe)
print("\n")
mediator.send(message: "Message from PM", sender: pm)


//: #### Output
/*
 QE received: Message from developer
 PM received: Message from developer
 
 
 Developer received: Message from QE
 PM received: Message from QE
 
 
 Developer received: Message from PM
 QE received: Message from PM


 */
//: [Next](@next)








