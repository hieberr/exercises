//: [Previous](@previous)

/* # Objective
Implement a threadsafe Singleton in Swift. It turns out this is easy since static members are initialized atomically in Swift.
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

// Usage:
Singleton.instance.doSomething()

// Output:
// Doing something...

//: [Next](@next)
