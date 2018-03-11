//: [Previous](@previous)

import Foundation

/*:
 # Facade Design pattern
 ## Objective:
 Implement Facade
 
 #### Definition:
 - A facade object provides a simplified interface to a more complex body of code such as a class library.
 
 ![UML](FacadeUml.jpg)
 
 #### Solves problems like:
 - You need a simple interface to access a complex system. Because the system is more complex than you need, or maybe it is poorly designed and can't be changed.
 - An entry point is needed to each level of layered software
 - The abstractions and implementations of a subsystem are tightly coupled.
 
 
 #### Resources
 
 ## Example:
 This example is probably overly simple, but imagine a highly configurable graphics system which has windows, devices, and graphics contexts.  A client might only want to draw a few simple shapes and maybe change the graphics context. The ShapeMaker facade exposes the shapes needed, and uses the underlying system to make it happen.
 
 A better example is the Java JOptionPane:
 
 ![UML](FacadeExampleJOptionPane.jpg)
 */

protocol Shape {
    func draw(context: GraphicsContext)
}

class GraphicsContext {
    private var name : String
    
    init(name: String) {
        self.name = name
    }
    
    func GetName() -> String {
        return name
    }
    // ...more members and complicated stuff that needs interacts with other systems and components.
}

class Circle: Shape {
    public func draw(context: GraphicsContext) {
        print("Drawing a Circle in \(context.GetName())")
    }
    // ...more members and complicated stuff that needs interacts with other systems and components.
}
class Rectangle: Shape {
    var length, width: Float
    
    init(length: Float, width: Float) {
        self.length = length; self.width = width
    }
    public func draw(context: GraphicsContext) {
        print("Drawing a Rectangle[\(length),\(width)] in \(context.GetName())")
    }
    // ...more members and complicated stuff that needs interacts with other systems and components.
}

// Our facade: ShapeMaker makes it simple for a client draw a shape without having to set things up
class ShapeMaker {
    var context: GraphicsContext = GraphicsContext(name: "Default")
    private var circleBrush: Circle = Circle()
    private var squareBrush: Rectangle = Rectangle(length: 10, width: 10)
    private var rectangleBrush: Rectangle = Rectangle(length: 3, width: 8)

    func SetContext(context: GraphicsContext) {
        //...initialize the new context, destruct the old context, and maybe do some complex stuff.
        self.context = context
    }
    
    func drawCircle() {
        circleBrush.draw(context: context)
    }
    
    func drawRectangle() {
        rectangleBrush.draw(context: context)
    }
    
    func drawSquare() {
        squareBrush.draw(context: context)
    }
}

//: #### Usage

let shapeMaker = ShapeMaker()

shapeMaker.drawCircle()
shapeMaker.drawSquare()
shapeMaker.drawRectangle()

//: #### Output
/*
Drawing a Circle in Default
Drawing a Rectangle[10.0,10.0] in Default
Drawing a Rectangle[3.0,8.0] in Default
*/
//: [Next](@next)

