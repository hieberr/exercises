//: [Previous](@previous)

import Foundation

/*:
 # Composite Design Pattern
 ## Objective:
 Implement the Composite Design Pattern
 
 #### Definition:
 ![Uml]()
 Group objects in a part-whole relationship where a client can interact with the group in the same way it would interact with the whole.  Implementing the composite pattern lets clients treat individual objects and compositions uniformly.
 
 - A part-whole hierarchy should be represented so that clients can treat part and whole objects uniformly.
 - A part-whole hierarchy should be represented as tree structure.
 - This enables clients to work through the Component interface to treat Leaf and Composite objects uniformly: Leaf objects perform a request directly, and Composite objects forward the request to their child components recursively downwards the tree structure. This makes client classes easier to implement, change, test, and reuse.
 
 #### When to use
 Composite should be used when clients ignore the difference between compositions of objects and individual objects.[1] If programmers find that they are using multiple objects in the same way, and often have nearly identical code to handle each of them, then composite is a good choice; it is less complex in this situation to treat primitives and composites as homogeneous.
 
 #### Specific Problems and Implementations
 There are two design variants for defining and implementing child-related operations like adding/removing a child component to/from the container (add(child)/remove(child)) and accessing a child component (getChild()):
 
 Design for uniformity: Child-related operations are defined in the Component interface. This enables clients to treat Leaf and Composite objects uniformly. But type safety is lost because clients can perform child-related operations on Leaf objects.
 Design for type safety: Child-related operations are defined only in the Composite class. Clients must treat Leaf and Composite objects differently. But type safety is gained because clients can not perform child-related operations on Leaf objects.
 
 The Composite design pattern emphasizes uniformity over type safety.
 
 ## Example:
 */


//: #### Usage



//: #### Output
/*
 
 */
//: [Next](@next)








