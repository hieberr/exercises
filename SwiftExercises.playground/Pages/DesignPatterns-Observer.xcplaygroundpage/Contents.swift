//: [Previous](@previous)

import Foundation

/*:
 # Observer Design Pattern
 ## Objective:
 Implement the Observer pattern

 #### Definition:
 ![Uml](ObserverUml.jpg)
 
 The observer pattern is a software design pattern in which an object, called the subject, maintains a list of its dependents, called observers, and notifies them automatically of any state changes, usually by calling one of their methods.
 
 #### Specific Problems and Implementations
 - Memory leaks.  Listeners must explicietly un-register themselves from the subject. This can cause retain cycles. In Swift, the listeners should maintain weak references to the subject.
 - Sending the new value:
    - update() can have no arguments, and the Observers respond by querying the subject (stored as a weak reference) for its state.
    - update() can pass along a reference to the subject so that Observers can query it for state.
    - update() can pass along the changed value(s) which the Observers use.
 ## Example:
 In the example below the notification passes the updated value along instead of a reference to the subject itself.
 */

protocol IObserver {
    var id: Int {get}
    func update(with newValue: Int)
}

protocol IObservable {
    func addObserver(_ observer : IObserver)
    func removeObserver(_ observer : IObserver)
    func removeAllObservers()
    func notifyAllObservers(with newValue: Int)
}

class ValueBox : IObservable {
    private var observers : Array<IObserver> = []
    private var _value: Int = 0
    
    public var value : Int {
        get {
            return _value
        }
        set {
            _value = newValue
            notifyAllObservers(with: newValue)
        }
    }
    init() {}
    
    func addObserver(_ observer : IObserver) {
        observers.append(observer)
    }
    func removeObserver(_ observer: IObserver) {
        if let index = observers.index(where: {$0.id == observer.id}) {
            observers.remove(at: index)
        }
    }
    func removeAllObservers() {
        observers = []
    }
    func notifyAllObservers(with newValue: Int) {
        for observer in observers {
            observer.update(with: newValue)
        }
    }
}

class Observer : IObserver {
    private static var nextId : Int = 0
    static func getId() -> Int {
        let id = nextId
        nextId += 1
        return id
    }
    
    public var id: Int
    init() {
        id = Observer.getId()
    }
    public func update(with newValue: Int) {
        print("Value Changed: \(newValue)")
    }
}

class DecimalObserver : Observer {
    override public func update(with newValue: Int) {
        print("Value Changed(Decimal): " + String(newValue, radix: 10))
    }
}
class HexObserver : Observer {
    override public func update(with newValue: Int) {
        print("Value Changed(Hex): " + String(newValue, radix: 16))
    }
}
class BinaryObserver : Observer {
    override public func update(with newValue: Int) {
        print("Value Changed(Bin): " + String(newValue, radix: 2))
    }
}
//: #### Usage

let valueBox = ValueBox()
let decimalObserver = DecimalObserver()
let hexObserver = HexObserver()
let binaryObserver = BinaryObserver()
valueBox.addObserver(decimalObserver)
valueBox.addObserver(hexObserver)
valueBox.addObserver(binaryObserver)

valueBox.value = 16

valueBox.removeObserver(hexObserver)
valueBox.value = 17

//: #### Output
/*
 Value Changed(Decimal): 16
 Value Changed(Hex): 10
 Value Changed(Bin): 10000
 Value Changed(Decimal): 17
 Value Changed(Bin): 10001
 */
//: [Next](@next)








