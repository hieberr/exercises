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
 ![ExampleUml](CompositeExampleUml.png)
 */
public protocol Employee {
    func isEqualTo(_ other: Employee) -> Bool
    func add(employee: Employee)
    func remove(employee: Employee)
    func getChild(index: Int) -> Employee?
    func getName() -> String
    func getSalary() -> Double
    func printDescription(tabs: String)
}

public class Manager : Employee {
    private var name: String
    private var salary: Double
    private var employees: Array<Employee> = Array<Employee>()
    
    public init(name: String, salary: Double){
        self.name = name
        self.salary = salary
    }
    
    public func isEqualTo(_ other: Employee) -> Bool {
        return name == other.getName()
    }
    
    public func add(employee: Employee) {
        employees.append(employee)
    }
    
    public func remove(employee: Employee) {
        if let index = employees.index( where: {$0.isEqualTo(employee) }) {
            employees.remove(at: index)
        }
    }
    
    public func getChild(index: Int) -> Employee? {
        if index < 0 || index > employees.count - 1 {
            return nil
        }
        return employees[index]
    }
    
    public func getName() -> String {
        return name
    }
    
    public func getSalary() -> Double {
        return salary
    }
    
    public func printDescription(tabs: String) {
        print("\(tabs)Name: \(name)")
        print("\(tabs)Salary: \(salary)")
        print("\(tabs)-----------------------")
        
        for employee in employees {
            employee.printDescription(tabs: tabs + "\t")
        }
    }
}

// Developer is a leaf node, so it doesn't keep track of any employees.
public class Developer : Employee {
    private var name: String
    private var salary: Double
    
    public init(name: String, salary: Double){
        self.name = name
        self.salary = salary
    }
    
    public func isEqualTo(_ other: Employee) -> Bool {
        return name == other.getName()
    }
    
    public func add(employee: Employee) {
    }
    
    public func remove(employee: Employee) {
    }
    
    public func getChild(index: Int) -> Employee? {
        return nil
    }
    
    public func getName() -> String {
        return name
    }
    
    public func getSalary() -> Double {
        return salary
    }
    
    public func printDescription(tabs: String) {
        print("\(tabs)Name: \(name)")
        print("\(tabs)Salary: \(salary)")
        print("\(tabs)-----------------------")
    }
}

//: #### Usage
let manager1 : Employee  = Manager(name: "Bill", salary: 200000)
manager1.add(employee: Developer(name: "John", salary: 100000))
manager1.add(employee: Developer(name: "David", salary: 150000))

let manager2 : Employee  = Manager(name: "Bob", salary: 200000)
manager2.add(employee: Developer(name: "Frank", salary: 150000))

let generalManager : Employee = Manager(name: "Rich", salary: 200000)
generalManager.add(employee: manager1)
generalManager.add(employee: manager2)

generalManager.printDescription(tabs: "")
//: #### Output
/*
 Name: Rich
 Salary: 200000.0
 -----------------------
    Name: Bill
    Salary: 200000.0
    -----------------------
        Name: John
        Salary: 100000.0
        -----------------------
        Name: David
        Salary: 150000.0
        -----------------------
    Name: Bob
    Salary: 200000.0
    -----------------------
        Name: Frank
        Salary: 150000.0
        -----------------------
 */
//: [Next](@next)








