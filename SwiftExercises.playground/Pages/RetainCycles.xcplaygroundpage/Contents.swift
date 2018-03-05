//: [Previous](@previous)

import Foundation
/* # Retain Cycles in swift
 
 ## Objective:
 Explore examples of retain cycles in swift and how to fix them.
 
 ### Definition:
 
*/

//#### Interclass retain cycle

class PersonRetainCycle {
    public var friends: Array<PersonRetainCycle> = []
    private var name: String
    
    init(_ name: String) {
        print("init: \(name)")
        self.name = name
    }
    
    deinit {
        print("deinit: \(name)")
    }
}

var bobWithCycle: PersonRetainCycle? = PersonRetainCycle("BobWithCycle")
var aliceWithCycle: PersonRetainCycle? = PersonRetainCycle("AliceWithCycle")

bobWithCycle?.friends.append(aliceWithCycle!)
aliceWithCycle?.friends.append(bobWithCycle!)

bobWithCycle = nil
aliceWithCycle = nil
print("\n")
/* #### Output:
 Notice that the deinit never gets called
 
 init: Bob
 init: Alice
 
 We can fix/avoid this in two ways. The first way is to remember to clear out the friends array when we are destroying a person.
 bob.friends.RemoveAll()
 bob = nil
 
 
 We can also wrap the person objects held in the array with wrapper class/struct that holds a weak reference to a person.
 */

struct WeakPerson {
    public weak var person: Person?
    
    init(_ person: Person) {
        self.person = person
    }
}

class Person {
    public var friends: Array<WeakPerson> = []
    private var name: String
    
    init(_ name: String) {
        print("init: \(name)")
        self.name = name
    }
    
    deinit {
        print("deinit: \(name)")
    }
}

var bob: Person? = Person("Bob")
var alice: Person? = Person("Alice")

bob?.friends.append(WeakPerson(alice!))
alice?.friends.append(WeakPerson(bob!))

bob = nil
alice = nil
print("\n")

/* #### Output:
 Notice that now the deinits get called
 
 init: Bob
 init: Alice
 deinit: Bob
 deinit: Alice
 */


//#### Closure retain cycle
// KrakenRetainCycle captures a strong reference to self in the notificationObserver closure.  de-init will never get called because this captured reference will always keep the retain count for the parent object at least 1.
class KrakenRetainCycle {
    var notificationObserver: NSObjectProtocol? = nil
    init() {
        notificationObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "humanEnteredKrakensLair"), object: nil, queue: .main) { _ in
            self.eatHuman()
        }
        print("init: KrakenWithCycle")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(notificationObserver!)
        print("deinit: KrakenWithCycle")
    }
    
    public func eatHuman() -> Void {
        print("eatHuman()")
    }
}

var krakenWithCycle: KrakenRetainCycle? = KrakenRetainCycle()
krakenWithCycle = nil
print("\n")

/* #### Output:
 Notice that the deinit doesn't get called
 init: Kraken
 
 
 adding [weak self] to the closure arguments means the closure now keeps a weak reference, which doesn't increase the retain count on self.
 */
class KrakenWithWeakSelf {
    var notificationObserver: NSObjectProtocol? = nil
    init() {
        notificationObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "humanEnteredKrakensLair"), object: nil, queue: .main) { [weak self] (notification) in
            self?.eatHuman() // weak variables are optional
        }
        print("init: KrakenWithWeakSelf")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(notificationObserver!)
        print("deinit: KrakenWithWeakSelf")

    }
    
    public func eatHuman() -> Void {print("eatHuman()")}
}

var krakenWithWeakSelf: KrakenWithWeakSelf? = KrakenWithWeakSelf()
krakenWithWeakSelf = nil

/* #### Output:
 Now the deinit is called

 init: KrakenWithWeakSelf
 deinit: KrakenWithWeakSelf
 
*/
print("\n")

/* Delegate example
 GodzillaWithCycle has a retain cycle in the onRoar() delegate assigned in the init.
 */
 
class GodzillaWithCycle {
    private var maxAge: Int = 33
    private var name: String
    
    var onRoar: (() -> Void)?
    
    init(_ name: String) {
        self.name = name
        print("init: GodzillaWithCycle \(self.name)")
        onRoar = {
            print("\(self.name): Roaar!!")
        }
    }
    deinit {
        print("deinit: GodzillaWithCycle \(self.name)")
    }
}

var godzillaWithCycle: GodzillaWithCycle? = GodzillaWithCycle("BobzillaWithCycle")
godzillaWithCycle = nil
/* #### Output:
Note that the deinit doesn't get called due to the retain cycle:
init: GodzillaWithCycle BobzillaWithCycle
 */


print("\n")
/* This can be fixed by either having the captured self be weak or unowned. In this case the captured self will never outlive the class itself so we can use unowned instead of weak.
 */

class GodzillaWithUnowned {
    private var maxAge: Int = 33
    private var name: String
    
    var onRoar: (() -> Void)?
    
    init(_ name: String) {
        self.name = name
        print("init: GodzillaWithUnowned \(self.name)")
        onRoar = {[unowned self] in
            print("\(self.name): Roaar!!")
        }
    }
    deinit {
        print("deinit: GodzillaWithUnowned \(self.name)")
    }
}

var godzillaWithUnowned: GodzillaWithUnowned? = GodzillaWithUnowned("BobzillaWithUnowned")
godzillaWithUnowned = nil

/* ####Output:
 init: GodzillaWithUnowned BobzillaWithUnowned
 deinit: GodzillaWithUnowned BobzillaWithUnowned
 */


//: [Next](@next)
