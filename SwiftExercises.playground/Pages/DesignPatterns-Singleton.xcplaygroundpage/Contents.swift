//: [Previous](@previous)

/*:
 # Singleton
 #### Objective
Implement a threadsafe Singleton in Swift. It turns out this is easy since static members are initialized atomically in Swift.
 
 #### Definition
 A singleton provides ONLY a single instance of the class which is globally accessible.
 
 ![UML](SingletonUml.png)
 
 #### When to use
 - When you only need a single instance of a class.
 - When you need centralized management of internal or external resources and you need a global point of access.
 
*/
final class Singleton {
    // In Swift 'static' (class) memebers are initized lazily, and with dispatch_once so that it is thread safe.
    static let instance: Singleton = Singleton()
    
    // Make the initializer private so that the class can't be initialized anywhere else.
    private init() {}
    
    public func doSomething() {
        print("Doing something...");
    }
}

//: #### Usage:
Singleton.instance.doSomething()

//: #### Output:
// Doing something...

//: [Next](@next)
