//: [Previous](@previous)

import Foundation
/*:
 # Bridge Design Pattern
 #### Objective:
 Implement ObjectAdapter
 
 #### Definition:
 -Decouple abstration from implementation so that the two can vary independently.
 - An Abstraction can be implemented by an abstraction implementation, and this implementation does not depend on any concrete implementers of the Implementor interface. Extending the abstraction does not affect the Implementor.  Also, extending the Implementor has no effect on the Abstraction.
 ![UML](BridgeUml.png)
 
 #### Solves problems like:
The bridge pattern applies when there is a need to avoid permanent binding between an abstraction and an implementation and when the abstraction and implementation need to vary independently. Using the bridge pattern would leave the client code unchanged with no need to recompile the code.
 -e.g. GUI Frameworks separate a Window abstractino from a Window implementation for different operating systems
 -e.g. Persistence frameworks (Database, FileSystem)
 #### Related Patterns
 An Abstract Factory pattern can be used to create and configure a particular Bridge. e.g. a factory can choose the suitable concrete implementor at runtime.
 
 ## Example:

 */
// A dummy representation of some data to save
class DataObject {
    private var data: String
    init(_ data: String) {
        self.data = data
    }
    
    public static func deSerialize(serializedData: String) -> DataObject? {
        return DataObject(serializedData)
    }
    
    public func serialize() -> String {
        return data
    }
    
    public func setData(newData: String) {
        data = newData
    }
}

protocol Persistence {
    func persist(object: DataObject) -> String
    func findById(id: String) -> DataObject?
    func deleteById(id: String)
}

/* First implementation of PersistenceApi.  Note that we could implement a second version of this, or extend this class without having to change Persistence Implementations below.
 */

class PersistenceApi : Persistence {
    var implementor: PersistenceImplementor
    
    init(implementor: PersistenceImplementor) {
        self.implementor = implementor
    }
    
    func persist(object: DataObject) -> String {
        return String(implementor.saveObject(object: object))
    }
    
    func findById(id: String) -> DataObject? {
        return implementor.getObject(id: id)
    }
    
    func deleteById(id: String) {
        implementor.deleteObject(id: id)
    }
}

/*
Persistence Implementor protocol and Implementations
 */
protocol PersistenceImplementor {
    func saveObject(object: DataObject) -> String
    func deleteObject(id: String)
    func getObject(id: String) -> DataObject?
}

/*
  FileSystemPersistenceImplementor
 */
public class FileSystemPersistenceImplementor : PersistenceImplementor {
    //A pretend file system where each "File" is just a string stored in a dictionary who's key is the path/id of the file
    private var files: Dictionary<String, String> = Dictionary<String,String>()
    
    func saveObject(object: DataObject) -> String {
        let id = NSUUID().uuidString
        writeFile(id: id, object: object)
        return id
    }
    
    func deleteObject(id: String) {
        if let index = files.index(forKey: id) {
            files.remove(at: index)
        }
    }
    
    func getObject(id: String) -> DataObject? {
        if let fileData = readFile(id: id){
            return DataObject.deSerialize(serializedData: fileData)
        }
        return nil
    }
    
    func writeFile(id: String, object: DataObject) {
        files[id] = object.serialize()
    }
    
    func readFile(id: String) -> String? {
        if let fileData = files[id] {
            return fileData
        }
        return nil
    }
}

/*
 DatabasePersistenceImplementor
 */
public class DatabasePersistenceImplementor : PersistenceImplementor {
    //A pretend Database system where each entry is just a string stored in a dictionary who's key is the path/id of the file.
    //Imagine this is a different implementation than the File System Implementor
    private var files: Dictionary<String, String> = Dictionary<String,String>()
    
    func saveObject(object: DataObject) -> String {
        let serializedData = object.serialize()
        let id = NSUUID().uuidString
        files[id] = serializedData
        return id
    }
    
    func deleteObject(id: String) {
        if let index = files.index(forKey: id) {
            files.remove(at: index)
        }
    }
    
    func getObject(id: String) -> DataObject? {
        if let fileData = files[id] {
            return DataObject.deSerialize(serializedData: fileData)
        }
        return nil
    }
}

/*:
 #### Usage
 -The following sets up an implementor at run time which could be either a Database or a FileSystem depending on what is available.
 
 -A PersistenceApi is created which uses the implementor.
 
 -The PersistenceApi is used to create/modifify/delete objects.  Note that the code that uses the PersistenceApi doesn't need to change at all when the implementor is switched.
 */

class ExampleClient {
    var implementor: PersistenceImplementor? = nil

    init(databaseDriverExists: Bool) {
        if databaseDriverExists {
            implementor = DatabasePersistenceImplementor()
        } else {
            implementor = FileSystemPersistenceImplementor()
        }
        let persistenceApi = PersistenceApi(implementor: implementor!)

        
        // create the objects
        var o1Id = persistenceApi.persist(object: DataObject("object 1"))
        var o2Id = persistenceApi.persist(object: DataObject("object 2"))
        
        // find / reload object 1
        if let o1 = persistenceApi.findById(id: o1Id) {
            print("o1 Data: \"\(o1.serialize())\"")
            //delete the old object
            persistenceApi.deleteById(id: o1Id)
            //modify the objects data
            o1.setData(newData: "object 1 modified")
            o1Id = persistenceApi.persist(object: o1)
        }
        
        // retrieve the modified object
        if let o1 = persistenceApi.findById(id: o1Id) {
            print("o1 Data: \"\(o1.serialize())\"")
        }
    }
}

print("*** Using Database***")
let databaseClient = ExampleClient(databaseDriverExists: true)

print("\n*** Using FileSystem***")
let fileSystemClient = ExampleClient(databaseDriverExists: false)


//: #### Output
/*
 *** Using Database***
 o1 Data: "object 1"
 o1 Data: "object 1 modified"
 
 *** Using FileSystem***
 o1 Data: "object 1"
 o1 Data: "object 1 modified"

*/

//: [Next](@next)

