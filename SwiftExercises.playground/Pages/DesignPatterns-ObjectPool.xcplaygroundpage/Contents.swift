//: [Previous](@previous)

import Foundation

/*:
 # ObjectPool Design pattern
 ## Objective:
 Implement the ObjectPool pattern
 
 #### Definition:
 - Reuse objects that are expensive to create.
 
 ![UML](ObjectPoolUml.png)
 
 
 Implementation involves the following objects:
 Reusable - Wraps the limited resource, will be shared by several clients for a limited amount of time.
 Client - uses an instance of type Reusable.
 ReusablePool - manage the reusable objects for use by Clients, creating and managing a pool of objects.
 
 When a client asks for a Reusable object, the pool performs the following actions:
 -   Search for an available Reusable object and if it was found it will be returned to the client.
 -   If no Reusable object was found then it tries to create a new one. If this actions succeds the new Reusable object will be returned to the client.
 -   If the pool was unable to create a new Reusable, the pool will wait until a reusable object will be released.
 
 
 #### Solves problems like:
 - You have several clients who need the same stateless resource which is expensive to create.

 #### Implementation issues
 
 - If a resource is limited the pool can throw an exception or return a null value until a resource is availalable.
 - If a resource fails to be returned (due to limitation or some other error) the client should be notified somehow.
 - Syncronization: In a multithreading environment the methods that are used by different threads should be synchronized.  There are only three methods in the ResourcePool object that have to be syncronized:
    - getInstance() - should be synchronized or should contain a synchronized block.
    - acquireConnectionImpl() - the method that returns a resource should be syncronized not to return the same resource to two different clients in different threads.
    - releaseConnectionImpl() - Usually doesn't have to be sychronized.  Internally some blocks might need to be synchronized depending on the method implementation and the internal structures used to keep the pool.
 
 - Expired resources: Sometimes clients forget or fail to release a resource. It can be useful to have some sort of mechanism to keep track of the amount of time since the resource was used and return the resource to the pool after this time.
 
 ## Example:

 ![ExampleUml](ObjectPoolDatabaseExampleUml.png)
 */
class ConnectionImpl {
    var id: String
    init(id: String) {
        self.id = id
    }
}

class ConnectionPool {
    private var connectionImpls: Array<ConnectionImpl>
    private var connectionImplsInUse = Array<ConnectionImpl>()
    
    private init() {
        connectionImpls = Array<ConnectionImpl>()
        for i in 1...4 {
            connectionImpls.append(ConnectionImpl(id: String(i)))
        }
    }
    
    static var _instance: ConnectionPool? = nil
    static var instance: ConnectionPool {
        get {
            if _instance == nil {
                _instance = ConnectionPool()
            }
            return _instance!
        }
    }
    
    // Returns the connectionImpl or nil if none were available.
    func acquireConnectionImpl() -> ConnectionImpl? {
        if let connection = connectionImpls.popLast() {
            connectionImplsInUse.append(connection)
            return connection
        }
        return nil
    }
    
    func releaseConnectionImpl(reusable: ConnectionImpl) {
        var foundIndex: Int? = nil
        
        for i in 0...(connectionImplsInUse.count - 1) {
            let current = connectionImplsInUse[i]
            if current.id == reusable.id {
                foundIndex = i
                connectionImpls.append(current)
                break
            }
        }
        if foundIndex != nil {
            connectionImplsInUse.remove(at: foundIndex!)
        }
    }
}

//: #### Usage

//: #### Output
/*
 
 */
//: [Next](@next)


