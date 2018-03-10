//: [Previous](@previous)

import Foundation
/*:
 # ObjectAdapter Design pattern
 ## Objective:
 Implement ObjectAdapter
 
#### Definition:
 - Allows the interface of an existing class to be used by another interface.
 - Is often used to make existing classes work with others without havint to modify their source code.
 
![UML](adapter-pattern.png)
 
 #### Solves problems like:
 - How can a class be reused that does not have an interface that a client requires?
 - How can classes that have incompatible interfaces work together?
 - How can an alternative interface be provided for a class?
 
 #### Adapter vs decorator vs facade vs bridge
 - An adapter can be used when the wrapper must respect a particular interface. Converts one interface into another so that it matches what the client is expecting.
 - A decorator makes it possible to add or alter behavior of an interface at run-time.
 - A facade is used when an easier or simpler interface to an underlying object is desired.  Use a facade to simpliy an interface.
 - Adapter makes things work after they're designed; Bridge makes them work before they are.
 - Bridge is designed up-front to let the abstraction and the implementation vary independently.  Adapter is retrofitted to make unrelated classes work together.
 
 #### Object Adapter vs Class Adapter
 - The Class adapter uses inheritence to wrap a class instead of composition. The object Adapter / composition method is generally prefered because:
    * composition is generally prefered over inheritence. (better encapsulation, less complex, easier to test, requires well defined interfaces)
    * Class Adapter method often requires multiple inheritence which is not possible in some languages (C#, Java, Swift)
 
 ####  Conventions
 - Name the adapter "ClassName"To"Inteface"Adapter e.g. DAOToProviderAdapter.
 - Adapter should have a constructor which takes an adapteee class variable as a parameter. This paramater is stored by the adapter instance so that it can access any data/functionality in order to obtain the desired output.
 
 #### Resources

 ## Example:
 In this example a client has an existing RectangleArea instance but needs a SquareArea instance to do the calculation.
 So we create an adapter class which implements the SquareArea protocol.
 */
class RectangleArea {
    public func getArea(length: Int, width: Int) -> Int {
        return length * width
    }
}

protocol SquareArea {
    func getArea(length: Int) -> Int
}

class RectangleAreaToSquareAreaAdapter : SquareArea {
    private var rectangleArea: RectangleArea
    
    init(rectangleArea:RectangleArea) {
        self.rectangleArea = rectangleArea
    }
    
    public func getArea(length: Int) -> Int {
        return rectangleArea.getArea(length: length, width: length)
    }
}

class Client {
    var existingRectangleArea = RectangleArea()
    
    init(length: Int) {
        calculateGeometry(squareArea: RectangleAreaToSquareAreaAdapter(rectangleArea: existingRectangleArea))
    }
    func calculateGeometry(squareArea: SquareArea) {
        print("Area: \(squareArea.getArea(length: 5))")
    }
}
var client = Client(length: 5)


//: #### Output
//Area: 25

//: [Next](@next)
