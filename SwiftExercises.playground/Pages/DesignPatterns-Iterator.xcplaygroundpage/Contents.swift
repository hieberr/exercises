//: [Previous](@previous)

import Foundation

/*:
 # Iterator Design Pattern
 ## Objective:
 Implement the Iterator Pattern
 
 #### Definition:
 ![Uml](IteratorUml.png)
 The iterator pattern is used to traverse and access a container of elements sequentially without knowing it's representation (e.g. the datastructure of the aggregate could be an array, a heap, a binary tree.. etc)
 
 - Define a seperate iterator object that encapsulates accessing and traversing an aggregate object.
 
 ## Example:
 */

struct Ship {
    let name: String
}

struct Fleet {
    let ships: [Ship]
}

struct FleetIterator: IteratorProtocol {
    private var current = 0
    private let fleet: Fleet
    
    init(_ fleet: Fleet) {
        self.fleet = fleet
    }
    
    mutating func next() -> Ship? {
        var result: Ship? = nil
        result = current < fleet.ships.count ? fleet.ships[current] : nil
        current += 1;
        return result;
    }
}

extension Fleet: Sequence {
    func makeIterator() -> FleetIterator {
        return FleetIterator(self)
    }
}

//: #### Usage
let fleet: Fleet = Fleet(ships: [Ship(name: "USS Essess"), Ship(name: "Fleetwood Mac"), Ship(name: "Pinapple Express")])

var iterator = fleet.makeIterator()
while let ship = iterator.next() {
    print("\(ship.name), ")
}


//: #### Output
/*
 USS Essess,
 Fleetwood Mac,
 Pinapple Express,

 */
//: [Next](@next)

