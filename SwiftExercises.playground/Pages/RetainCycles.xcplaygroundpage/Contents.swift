//: [Previous](@previous)

import Foundation
/* # Retain Cycles in swift
 
 ## Objective:
 Explore examples of retain cycles in swift and how to fix them.
 
 ### Definition:
 
*/

//#### Closure retain cycle
// KrakenRetainCycle captures a strong reference to self in the notificationObserver closure.  de-init will never get called because this captured reference will always keep the retain count for the parent object at least 1.
class KrakenRetainCycle {
    var notificationObserver: NSObjectProtocol? = nil
    init() {
        notificationObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "humanEnteredKrakensLair"), object: nil, queue: .main) { _ in
            self.eatHuman()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(notificationObserver!)
    }
    
    public func eatHuman() -> Void {
        print("eatHuman()")
    }
}

//#### Usage:
var kraken = KrakenRetainCycle()
print("kraken retain count: \(CFGetRetainCount(kraken))")

/* adding [weak self] to the closure arguments means the closure now keeps a weak reference, which doesn't increase the retain count on self.
 */
class KrakenWithWeakSelf {
    var notificationObserver: NSObjectProtocol? = nil
    init() {
        notificationObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "humanEnteredKrakensLair"), object: nil, queue: .main) { [weak self] (notification) in
            self?.eatHuman() // weak variables are optional
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(notificationObserver!)
    }
    
    public func eatHuman() -> Void {print("eatHuman()")}
}
//#### Usage:
let krakenWithWeakSelf = KrakenWithWeakSelf()
print("kraken retain count: \(CFGetRetainCount(krakenWithWeakSelf))")



//: [Next](@next)
