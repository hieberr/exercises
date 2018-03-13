//: [Previous](@previous)

import Foundation

/*:
 # Builder Design pattern
 ## Objective:
 Implement Builder
 
 #### Definition:
 - Builder pattern builds a complex object using simple objects and using a step by step approach.
 -
 ![UML](BuilderUml.jpg)
 
 #### Solves problems like:
 - How can a class (the same construction process) create different representations of a complex object?
 - How can a class that includes creating a complex object be simplified?
 
 For example:
 ![UML](BuilderBurgerExampleUml.jpg)
 
 #### Disadvantages
 - Requires creating a seperate ConcreteBuilder for each different type of product.
 - Requires the builder classes to be mutable.
 - Data members of constructed object aren't guarunteed to be initialized.
 - Dependency injection may be less supported.
 
 #### Builder Pattern vs Abstract Factory
 - Builder and Abstract Factory solve similar problems.
 - In the case of the Abstract Factory the client uses the factories methods directly to create objects. The builder class is instructed on how to create the object, and then is asked for the constructed object.  The way that the class is put together is up to the Builder.
 - Products created by concrete builders have a different structure so there is rarely a reason to derive products from a common base class unlike the Abstract Factory pattern which creates objects derived from a common base.
 
 
 ## Example:
 The Director assembles a car instance, delegating the construction to a separate builder object which was passed in by the client.
 ![UML](CarExampleUml.png)
 */

public class Car {
    public var make: String
    public var model: String
    public var color: String
    public var numDoors: Int
    
    init(make: String, model: String, color: String, numDoors: Int) {
        self.make = make; self.model = model; self.color = color; self.numDoors = numDoors;
    }
    
    func description() -> String {
        return "\(make)-\(model), \(color), \(numDoors)-door"
    }
}

protocol ICarBuilder {
    var color: String {get set}
    var numDoors: Int {get set}
    func getResult() -> Car
}

public class FerrariBuilder : ICarBuilder {
    private var _color: String = "Red"
    public var color: String {
        get {
            return _color
        }
        set {
            _color = newValue
        }
    }
    private var _numDoors: Int = 2
    public var numDoors: Int {
        get {
            return _numDoors
        }
        set {
            _numDoors = newValue
        }
    }

    init() { }
    
    func getResult() -> Car {
        return Car(make: "Ferrari", model: "500", color: color, numDoors: numDoors  )
    }
}

class SportsCarBuildDirector {
    private var builder: ICarBuilder
    init(builder: ICarBuilder) {
        self.builder = builder
    }
    
    public func construct() {
        builder.color = "Blue"
        builder.numDoors = 4
    }
}


//: #### Usage

// A client might do the following:
var builder = FerrariBuilder()
var director = SportsCarBuildDirector(builder: builder)

director.construct()
var aCar = builder.getResult()

print("aCar: \(aCar.description())")


//: #### Output
/*
 aCar: Ferrari-500, Blue, 4-door
 */
//: [Next](@next)
