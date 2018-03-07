//: [Previous](@previous)
import Foundation
/* # SimpleFactory
 ## Objective:
 Implement the abstract factory design pattern.

 ### Definition:
    - Abstract Factory offers the interface for creating a family of related objects, without explicitly specifying their classes.
    - Abstract factories are usually implemented using a set of factory methods.
 
 #### difference from Factory Method:
    - The main difference between a "factory method" and an "abstract factory" is that the factory method is a single method, and an abstract factory is an object. Because the factory method is just a method, it can be overridden in a subclass.
    - The abstract factory pattern uses composition to delegate responsibility of creating object to another class while factory method pattern uses inheritance and relies on a derived class or sub class to create object.
 
 #### When to use this pattern:
    - When you need to create families of products or you want to provide a library of products without exposing implementation details.
    - From the GOF:
        “a system should be configured with one of multiple families of products”
 
        “you want to provide a class library of products, and you want to reveal just their interfaces, not their implementations”
 
 #### When not to use this pattern
    - Use a simpler factory pattern if you can. e.g. If you only need several types of factory: use factory method. If you only need a single concrete factory: use a static factory.
    - Don't create an abstract factory if you think you might need one later.  It's usually easy to refactor later than do the extra work up front and not need it.

 #### Resources
    - good information on the different factory patterns: http://coding-geek.com/design-pattern-factory-patterns/
 */

// ------------------------------------
// This example defines a layout factory for user interface elements. The example includes two factories that build UiElements that look/behave differently (in theory).  

/* The UiElements */
public protocol UixButton {
    func display()
}

public protocol UixWindow {
    func display()
}

public class MetalButton: UixButton {
    var metalConfiguration: String
    init(configuration: String) {
        self.metalConfiguration = configuration
    }
    
    public func display() {
        print("Metal Button displayed. Metal Config: \(metalConfiguration)")
    }
}

public class FlatButton: UixButton {
    public func display() {
        print("Flat Button displayed.")
    }
}

public class MetalWindow: UixWindow {
    var metalConfiguration: String
    init(configuration: String) {
        self.metalConfiguration = configuration
    }
    
    public func display() {
        print("Metal Window displayed. Metal Config: \(metalConfiguration)")
    }
}

public class FlatWindow: UixWindow {
    public func display() {
        print("Flat Button displayed.")
    }
}

/* The factories */
public protocol UiElementFactory {
    func getButton() -> UixButton // create a button
    func getWindow() -> UixWindow // create a window
    
    func destroyUi() //deletes all the elements
}

public class MetalUiFactory: UiElementFactory {
    var metalUiConfiguration: String
    init(configurationParamaters: String) {
        // Complicated initialization that only needs to be done once but all metal elements use.
        // store this result in metalUiConfiguration so we can pass a reference to each element created.
        metalUiConfiguration = configurationParamaters
    }
    
    public func getButton() -> UixButton {
        return MetalButton(configuration: metalUiConfiguration)
    }
    
    public func getWindow() -> UixWindow {
        return MetalWindow(configuration: metalUiConfiguration)
    }
    
    public func destroyUi() {
        print("Destroying all MetalUi elements")
    }
}

public class FlatUiFactory: UiElementFactory {
    // Flat button doesn't have any special configuration, but needs to keep track of all elements.
    var buttons: Array<UixButton> = []
    var windows: Array<UixWindow> = []
    
    init() {}
    
    public func getButton() -> UixButton {
        let button: UixButton = FlatButton()
        buttons.append(button)
        return button
    }
    
    public func getWindow() -> UixWindow {
        let window: UixWindow = FlatWindow()
        windows.append(window)
        return window
    }
    
    public func destroyUi() {
        print("Destroying all FlatUi elements")
        for button in buttons {
            //destroy the button.
        }
        buttons.removeAll();
        for window in windows {
            //destroy the button.
        }
        windows.removeAll();
    }
}

/* ## Usage */
// In this example we create a metalUi with a window and a button, destroy it, and then create a flat ui window and button.
var uiFactory: UiElementFactory = MetalUiFactory(configurationParamaters: "metal paramaters")

var button: UixButton = uiFactory.getButton()
var window: UixWindow = uiFactory.getWindow()
button.display()
window.display()
uiFactory.destroyUi()

// Switch the factory to a Flat factory which makes Flat style Ui elements
uiFactory = FlatUiFactory()
button = uiFactory.getButton()
window = uiFactory.getWindow()

//display the new UI
button.display()
window.display()
uiFactory.destroyUi()

/* ## Output
 Metal Button displayed. Metal Config: metal paramaters
 Metal Window displayed. Metal Config: metal paramaters
 Destroying all MetalUi elements
 Flat Button displayed.
 Flat Button displayed.
 Destroying all FlatUi elements
 */

//: [Next](@next)
