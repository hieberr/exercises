//: [Previous](@previous)
import Foundation

/* # SimpleFactory and Static Factory
 ## Objective:
 Implement the simple factory design pattern. This pattern abstracts out the creation details of an object. This simple pattern isn't really a GOF design pattern but is worth knowing about. For more complex cases use the Abstract Factory pattern.
 
 ### Simple/Static Factory Definition:
    Creates objects without exposing the instantiation logic to the client.
    Refers to the newly created object through a common interface
 
 #### When to use this pattern:
 -When you need to abstract out creation details or configuration of an object but don't need to control.  Sometimes the factory keeps a reference to all the created objects or otherwise organizes them.
 - When you want to control instanciation. e.g. you want to restrict the total number of instances, or otherwise limit the instances.  The factory can keep a count and deny creating new ones. A constructor approach can't do this.
 - Encapsulation - When there are other classes to set up to properly create an object (e.g. database connection, file system connection). Rather than connecting to these with each created instance, a factory allows you to set this up once in the factory, and then create instances fromm there.
 - Constructor disambiguation- If you have several constructors with similar signatures, it can be confusing for the client to choose the correct one.  A factory allows you to provide better names for the client.
 
 #### When to use the Factory Method pattern instead (see the playground page DesignPatterns-FactoryMethod for an example)
 Use the factory method if the business requirements are more than just product creation.
 - If you need to abstract the factory itself as well as product creation.
 - If you want to control product creation steps or configuration, and the steps are customized depending on the factory.
 - If you want to create families or groups of objects use an Abstract Factory
 */


print("**** StaticFactory example ****")
/********** Static Factory ***********/
// Note we could also put the static members in another class called WidgetFactory. And it would behave the same. This is commonly done, for example in the java Logger/LoggerFactory classes.
public class Widget {
    var data: String
    public static var instanceCount = 0
    
    public static func createInstance(data: String) -> Widget {
        instanceCount += 1
        return Widget(data: data)
    }
    
    init(data: String) {
        self.data = data
    }
}
//## Usage
var w1 = Widget.createInstance(data: "w1")
var w2 = Widget.createInstance(data: "w2")

print("Instance count: \(Widget.instanceCount)")

/* ## Output
 Instance count: 2
 */


print("\n\n**** SimpleFactory example ****")
//********** Simple Factory ***********
// In most cases you can probably use a static factory instead. It's simpler since you don't need to instantiate the factory itself. However, you might need to instantiate the factory if there is some database/file connection that needs to be instantiated.  The factory can hold on to this.
enum VehicleType {
    case sedan, suv, truck
}

protocol Vehicle {
    func drive()
    var id: String {get set}
}


class Sedan: Vehicle {
    public var id: String
    init(id: String) {
        self.id = id
    }
    
    func drive() {
        print("driving a sedan(id: \(id))")
    }
}
class Suv: Vehicle {
    public var id: String
    init(id: String) {
        self.id = id
    }
    func drive() {
        print("driving a SUV(id: \(id))")
    }
}
class Truck: Vehicle {
    public var id: String
    init(id: String) {
        self.id = id
    }
    func drive() {
        print("driving a truck(id: \(id))")
    }
}

class VehicleFactory {
    static var nextId: Int = 0;
    static func CreateVehicle(type: VehicleType) -> Vehicle {
        let id = String(VehicleFactory.nextId)
        VehicleFactory.nextId += 1
        switch type {
        case .sedan:
            return Sedan(id: id)
        case .suv:
            return Suv(id: id)
        case .truck:
            return Truck(id: id)
        }
    }
}

//## Usage
let sedan = VehicleFactory.CreateVehicle(type: .sedan)
let sedan2 = VehicleFactory.CreateVehicle(type: .sedan)
let suv = VehicleFactory.CreateVehicle(type: .suv)
let truck = VehicleFactory.CreateVehicle(type: .truck)

sedan.drive()
sedan2.drive()
suv.drive()
truck.drive()

/*
 ## Output
 driving a sedan(id: 0)
 driving a sedan(id: 1)
 driving a SUV(id: 2)
 driving a truck(id: 3)
*/


//: [Next](@next)
