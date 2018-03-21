//: [Previous](@previous)

import Foundation

/*:
 # Template Method Design Pattern
 ## Objective:
 Implement the Template Method Pattern
 
 #### Definition:
 ![Uml](TemplateMethodUml.png)
Template Method is used when you want to abstract out the structure of an algorithm but leave some of the steps for a subclass to implement. This avoids duplicating code where different implementors of the algorithm would re-implement the higher level structure. By only allowing certain steps to be overridden, the template can control which steps of the algorithm implemntors can define.
 
 
 #### Specific Problems and Implementations
 Frameworks: The template method is used in frameworks, where each implements the invariant parts of a domain's architecture, leaving "placeholders" for customization options. This inverted control structure has been affectionately labelled "the Hollywood principle" - "don't call us, we'll call you".
 
 #### Template Method vs Strategy Pattern
 - Strategy is like Template Method except in its granularity.
 - Template Method uses inheritance to vary part of an algorithm. Strategy uses delegation to vary the entire algorithm.
 - Strategy modifies the logic of individual objects. Template Method modifies the logic of an entire class.
 - Factory Method is a specialization of Template Method.

 ## Example:
 ![Example](TemplateMethodWorkerExample.png)
 */

class Worker {
    public final func performDay() {
        print("**** \(title()) ****")
        print(getUp())
        print(eatBreakfast())
        print(gotoWork())
        print(work())
        print(returnHome())
        print(relax())
        print("\(sleep())\n")
    }
    func title() -> String {
        return "Worker"
    }
    private func getUp() -> String {
        return "Waking up"
    }
    func eatBreakfast() -> String {
        return "Having breakfast"
    }
    func gotoWork() -> String {
        return "Going to work"
    }
    func work() -> String {
        return "Working"
    }
    func returnHome() -> String {
        return "Going home"
    }
    func relax() -> String {
        return "Relaxing"
    }
    
    private func sleep() -> String {
        return "Sleeping"
    }
}
class FireFighter : Worker {
    override func title() -> String { return "Fire Fighter" }
    override func work() -> String { return "Putting out fires"}
}
class LumberJack : Worker {
    override func title() -> String { return "Lumber Jack" }
    override func work() -> String { return "Chopping down trees"}
}
class Postman : Worker {
    override func title() -> String { return "Postman" }
    override func work() -> String { return "Delivering Mail" }
}
class Manager : Worker {
    override func title() -> String { return "Manager" }
    override func work() -> String { return "Managing business" }
    override func relax() -> String { return "Living the dream" }
}

//: #### Usage
let workers : [Worker] = [FireFighter(), LumberJack(), Postman(), Manager()]
for worker in workers {
    worker.performDay()
}

//: #### Output
/*
 **** Fire Fighter ****
 Waking up
 Having breakfast
 Going to work
 Putting out fires
 Going home
 Relaxing
 Sleeping
 
 **** Lumber Jack ****
 Waking up
 Having breakfast
 Going to work
 Chopping down trees
 Going home
 Relaxing
 Sleeping
 
 **** Postman ****
 Waking up
 Having breakfast
 Going to work
 Delivering Mail
 Going home
 Relaxing
 Sleeping
 
 **** Manager ****
 Waking up
 Having breakfast
 Going to work
 Managing business
 Going home
 Living the dream
 Sleeping
 

 */
//: [Next](@next)






