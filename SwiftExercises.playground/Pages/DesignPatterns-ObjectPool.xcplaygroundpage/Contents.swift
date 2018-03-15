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
 
 ##### 1. Limited Number of Resources in Pool
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


//: #### Usage

//: #### Output
/*
 
 */
//: [Next](@next)


