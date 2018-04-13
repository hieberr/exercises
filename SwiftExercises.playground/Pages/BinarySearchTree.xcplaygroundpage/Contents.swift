//: [Previous](@previous)

import Foundation

/*:
 # Binary Search Tree
 ## Objective:
See if I can implement a binary tree using swift
 
 */

class Node : Equatable {
    var left, right, parent : Node?
    let name: String
    
    init(name: String) {
        self.name = name
    }
    public var isRoot: Bool {
        return parent == nil
    }
    
    public var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    public var isLeftChild: Bool {
        return parent?.left === self
    }
    
    public var isRightChild: Bool {
        return parent?.right === self
    }
    
    public var hasLeftChild: Bool {
        return left != nil
    }
    
    public var hasRightChild: Bool {
        return right != nil
    }
    
    public var hasAnyChild: Bool {
        return hasLeftChild || hasRightChild
    }
    
    public var hasBothChildren: Bool {
        return hasLeftChild && hasRightChild
    }
    
    public var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    
    public var minimum: Node? {
        var node = self
        while let next = node.left {
            node = next
        }
        return node
    }
    
    public var maximum: Node? {
        var node = self
        while let next = node.right {
            node = next
        }
        return node
    }
    
    private func reconnectParentTo(node: Node?) {
        if let parent = parent {
            if isLeftChild {
                parent.left = node
            } else {
                parent.right = node
            }
        }
        node?.parent = parent
    }
    
    public func search(value: String) -> Node? {
        if value == name {
            return self
        }
        if value < name, let l = left {
            return l.search(value: value)
        } else if let r = right {
            return r.search(value: value)
        }
        return nil
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
                left!.parent = self
            }
        } else {
            if let r = right {
                r.add(nameToAdd)
            } else {
                right = Node(name: nameToAdd)
                right!.parent = self
            }
        }
    }
    

    public func remove() -> Node? {
        var replacement: Node?
        
        if let right = right {
            replacement = right.minimum
        } else if let left = left {
            replacement = left.maximum
        }
        replacement?.remove()
        
        // Place the replacement at current nodes position
        replacement?.right = right
        replacement?.left = left
        right?.parent = replacement
        left?.parent = replacement
        reconnectParentTo(node: replacement)
        
        parent = nil;left = nil; right = nil
        return replacement
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
root.printNamesInOrder()

print(" ")
root.search(value: "Bob")?.remove()
root.printNamesInOrder()

//: #### Output
/*
 Alice
 Barny
 Bob
 Frank
 Ryan
 Zach
 
 Alice
 Barny
 Frank
 Ryan
 Zach


 */
//: [Next](@next)








