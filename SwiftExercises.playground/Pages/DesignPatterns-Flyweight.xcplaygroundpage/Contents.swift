//: [Previous](@previous)

import Foundation

/*:
 # Flyweight Design pattern
 ## Objective:
 Implement the Flyweight pattern
 
 #### Definition:
 ![Uml](FlyweightUml.jpg)

 - The flyweight pattern is used when you need to use many objects that all share some unchanging intrinsic state. Rather than each object having a copy of this state, each object has a reference to the "flyweight" object which is the shared intrinsic value. A flyweight factory creates and manages the flyweight objects (often just a singleton, or a singleton hashmap of types)
 
 ## Example:
 ![ExampleUml](FlyweightSoldierExampleUml.png)
 */

/*
 SoldierFactory is the Flyweight factory that holds a singleton SoldierImp.
 If there are more types this can be hashmap of types. Or for more types see the factory method and abstract factory patters.
 */
class SoldierFactory {
    private static let soldier: Soldier = SoldierImp()

    private init() {}
    
    public static func getSoldier() -> Soldier {
        return soldier
    }
}

protocol Soldier{
    func move(previousX: Int, previousY: Int, newX: Int, newY: Int)
}

class SoldierImp : Soldier {
    /**
     * Intrinsic State maintained by flyweight implementation
     * Solider Shape ( graphical represetation)
     * how to display the soldier is up to the flyweight implementation. In this example its just a string.
     */
    var soldierGraphicalRepresentation: String = "SOLDIER"
    
    init() {}
    /**
     * Note that this method accepts soldier location
     * Soldier Location is Extrinsic and no reference to previous location
     * or new location is maintained inside the flyweight implementation
     */
    func move(previousX: Int, previousY: Int, newX: Int, newY: Int) {
        // delete soldier representation from previous location
        // then render soldier representation in new location
        print("Removing \(soldierGraphicalRepresentation) at \(previousX),\(previousY)")
        print("Drawing \(soldierGraphicalRepresentation) at \(newX),\(newY)")
    }
}
class SoldierClient {
    // ref to the Flyweight
    private var soldier:Soldier = SoldierFactory.getSoldier()
    
    private var currentX = 0, currentY = 0;
    
    public func move(newX: Int, newY: Int) {
        // flyweight handles moving/drawing the soldier. (intrinsic state)
        soldier.move(previousX: currentX, previousY: currentY, newX: newX, newY: newY)
        
        // this object maintains extreinsic state.
        currentX = newX
        currentY = newY
    }
}
//: #### Usage

var s0 = SoldierClient()
var s1 = SoldierClient()
var s2 = SoldierClient()


s0.move(newX: 1, newY: 1)
s0.move(newX: 2, newY: 2)
s0.move(newX: 3, newY: 3)

s1.move(newX: 11, newY: 11)
s1.move(newX: 12, newY: 12)
s1.move(newX: 13, newY: 13)

s2.move(newX: 21, newY: 21)
s2.move(newX: 22, newY: 22)
s2.move(newX: 23, newY: 24)

//: #### Output
/*
 Removing SOLDIER at 0,0
 Drawing SOLDIER at 1,1
 Removing SOLDIER at 1,1
 Drawing SOLDIER at 2,2
 Removing SOLDIER at 2,2
 Drawing SOLDIER at 3,3
 Removing SOLDIER at 0,0
 Drawing SOLDIER at 11,11
 Removing SOLDIER at 11,11
 Drawing SOLDIER at 12,12
 Removing SOLDIER at 12,12
 Drawing SOLDIER at 13,13
 Removing SOLDIER at 0,0
 Drawing SOLDIER at 21,21
 Removing SOLDIER at 21,21
 Drawing SOLDIER at 22,22
 Removing SOLDIER at 22,22
 Drawing SOLDIER at 23,24
 */
//: [Next](@next)



