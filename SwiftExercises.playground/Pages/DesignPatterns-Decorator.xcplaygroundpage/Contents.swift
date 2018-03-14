//: [Previous](@previous)

import Foundation

/*:
 # Decorator Design pattern
 ## Objective:
 Implement the Decorator pattern
 
 #### Definition:
The decorator pattern adds or alters behavior of a class dynamically at run time. The decorator object forwards requests to the decorated object and does work before or after the request to modify it. The decorator, and the decorated both implement the same interface so they can be used interchangably. It is helpful in maintaining the Single Responsibility principle as well as the Open Close Principle.
 
 ![UML](DecoratorUml.jpg)
 #### Solves problems like:
 - You need to extend (or remove) an objects responsibilities statically or in some cases dynamically at run time.
 - You need to stick to the Single Responsibility and Open Close principals for a class. Add decorators instead of extending or adding to a class.
 
 #### Decorator vs Chain of Responsibility Pattern
 The Decorator pattern is structurally nearly identical to the Chain of Responsibility. The difference is that in a Chain of Responsibility only ONE class handles the request. In the decorator the request gets passed along to potentially many other decorators.
 
 #### Builder Pattern vs Abstract Factory

 ## Example:
The following example adds decorators to add scroll bars to a window. You could also achieve this by making a "scrollbarWindow" subclass but then you run into problems when you want to add other window types, say a window with a border. Using decorators you simply add a decorator for horizontal scrollbars, and one for vertical scroll bars, and another for borders.
 ![ExampleUml](DecoratorWindowExampleUml.png)
 
 */

protocol IWindow {
    func draw()
    func getDescription() -> String
}

class Window: IWindow {
    public func draw() {
        
    }
    func getDescription() -> String {
        return "A window"
    }
}

class WindowDecorator: IWindow {
    var decorating : IWindow
    
    init(decorating: IWindow) {
        self.decorating = decorating
    }
    
    public func draw() {}
    public func getDescription() -> String {
        return decorating.getDescription()
    }
}


class HorizontalScrollDecorator: WindowDecorator {
    override init(decorating: IWindow) {
        super.init(decorating: decorating)
    }
    
    override func draw() {
        super.draw()
        drawHorizontalScrollBar()
    }
    
    override func getDescription() -> String {
        return super.getDescription() + " with Horizontal Scroll Bars"
    }
    
    func drawHorizontalScrollBar() {
        // draw the vertical scroll bar
    }
}

class VerticalScrollDecorator: WindowDecorator {
    override init(decorating: IWindow) {
        super.init(decorating: decorating)
    }
    
    override func draw() {
        super.draw()
        drawHorizontalScrollBar()
    }
    
    override func getDescription() -> String {
        return super.getDescription() + " with Vertical Scroll Bars"
    }
    
    func drawHorizontalScrollBar() {
        // draw the vertical scroll bar
    }
}
//: #### Usage

var window: IWindow = Window()
print("initialWindow: \(window.getDescription())\n")
window = HorizontalScrollDecorator(decorating: window)

print("After Adding Horizontal ScrollBars: \n\(window.getDescription())\n")
window = VerticalScrollDecorator(decorating: window)

print("After Adding Vertical ScrollBars: \n\(window.getDescription())\n")

//: #### Output
/*
 initialWindow: A window
 
 After Adding Horizontal ScrollBars:
 A window with Horizontal Scroll Bars
 
 After Adding Vertical ScrollBars:
 A window with Horizontal Scroll Bars with Vertical Scroll Bars

 */
//: [Next](@next)

