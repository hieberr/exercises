//: [Previous](@previous)

import Foundation

/*:
 # Binary Tree
 ## Objective:
See if I can implement a binary tree using swift
 
 */

class Node : Equatable {
    var left, right : Node?
    let name: String
    
    init(name: String) {
        self.name = name
    }
    public func add(_ nameToAdd: String) {
        if nameToAdd == name {
            //error already exists
            return
        }
        if nameToAdd < name {
            if let l = left {
                l.add(nameToAdd)
            } else {
                left = Node(name: nameToAdd)
            }
        } else {
            if let r = right {
                r.add(nameToAdd)
            } else {
                right = Node(name: nameToAdd)
            }
        }
    }
    
    public func add(_ child: Node) {
        if child.name < name {
            if let l = left {
                l.add(child)
            } else {
                left = child
            }
        } else {
            if let r = right {
                r.add(child)
            } else {
                right = child
            }
        }
    }
    
    public func remove(_ nameToRemove: String) {
        if nameToRemove < name {
            if let l = left {
                if l.name == nameToRemove {
                    let removed = l
                    left = removed.left
                    if let removedRight = removed.right {
                        self.add(removedRight)
                    }
                } else {
                    l.remove(nameToRemove)
                }
            } else {
                // the name didn't exist
            }
        } else {
            if let r = right {
                if r.name == nameToRemove {
                    let removed = r
                    right = removed.left
                    if let removedRight = removed.right {
                        self.add(removedRight)
                    }
                } else {
                    r.remove(nameToRemove)
                }
            } else {
                // the name didn't exist
            }
        }
    }
    public static func ==(lhs: Node, rhs: Node) -> Bool {
        return lhs.name == rhs.name
    }
    
    public func printNode(tabs: String) {
        print("\(tabs)\(name)")
        left?.printNode(tabs: tabs.appending("\t"))
        right?.printNode(tabs: tabs.appending("\t"))
    }
    
    public func printNamesInOrder() {
        if let l = left {
            l.printNamesInOrder()
        }
        print("\(name)")
        if let r = right {
            r.printNamesInOrder()
        }
    }
}

//: #### Usage

var root = Node(name: "Ryan")

root.add("Bob")
root.add("Frank")
root.add("Alice")
root.add("Zach")
root.add("Barny")


//root.printNode(tabs: "")
print(" ")
root.printNamesInOrder()
//: #### Output
/*

 Alice
 Barny
 Bob
 Frank
 Ryan
 Zach

 */
//: [Next](@next)








