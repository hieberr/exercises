//: [Previous](@previous)

import Foundation

/*:
 # Proxy Design Pattern (Surrogate)
 ## Objective:
 Implement the Proxy Pattern
 
 #### Definition:
 ![Uml](ProxyUml.jpg)
Proxy provides the same interface as the proxied-for class and typically does some housekeeping stuff on its own. (So instead of making multiple copies of a heavy object X you make copies of a lightweight proxy P which in turn manages X and translates your calls as required.) You are solving the problem of the client from having to manage a heavy and/or complex object.
 
 - A proxy may hide information about the real object to the client.
 - A proxy may perform optimization like on demand loading.
 - A proxy may do additional house-keeping job like audit tasks.
 - Proxy design pattern is also known as surrogate design pattern.

 
 #### Specific Problems and Implementations
 - Protection Proxy: When accessing sensitive objects, for example, it should be possible to check that clients have the needed access rights.
 - Remote Proxy: In a distributed system a local object represents a remote object. e.g. for an atm a local bank account object represents the remote bank account. Method invocation on the local object results in remote methods being called to the remote object.
 -Virtual Proxy: When you have a complex or resource intensive object it may be beneficial to have a lightweight representation of the object which only loadds the complex object when required.
 
 ## Example:
 */

protocol Image {
    func display()
}
class RealImage : Image {
    private var filename: String
    
    public init(filename: String) {
        self.filename = filename
        loadFromDisk()
    }
    
    func loadFromDisk() {
        print("Loading \(filename)")
    }
    
    public func display() {
        print("Displaying \(filename)")

    }
}

class ProxyImage : Image {
    private var image: RealImage? = nil
    private var filename : String
    
    public init(filename: String) {
        self.filename = filename
    }
    
    public func display() {
        if image == nil {
            image = RealImage(filename: filename)
        }
        image?.display()
    }
}

//: #### Usage

let image0 : Image = ProxyImage(filename: "HiRezPhoto00.jpg")
let image1 : Image = ProxyImage(filename: "HiRezPhoto01.jpg")

image0.display() // loads and displays image 0
image0.display() // loading unnecessary just displays image 0
image1.display() // loads and displays image 1
image1.display() // loading unnecessary just displays

//: #### Output
/*
 Loading HiRezPhoto00.jpg
 Displaying HiRezPhoto00.jpg
 Displaying HiRezPhoto00.jpg
 Loading HiRezPhoto01.jpg
 Displaying HiRezPhoto01.jpg
 Displaying HiRezPhoto01.jpg
 */
//: [Next](@next)





