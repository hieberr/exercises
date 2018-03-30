//: [Previous](@previous)

import Foundation

/*:
 # Visitor Design Pattern 
 ## Objective:
 Implement the Visitor Pattern
 
 #### Definition:
 ![Uml](VisitorUml.jpg)
 gof definition: Represent an operation to be performed on elements of an object structure. Visitor lets you define a new operation without changing the classes of the elements on which it operates.
 
 #### Use the visitor pattern when:
- many unrelated operations on an object structure are required,
- the classes that make up the object structure are known and not expected to change,
- new operations need to be added frequently,
- an algorithm involves several classes of the object structure, but it is desired to manage it in one single location,
- an algorithm needs to work across several independent class hierarchies.
 
 A drawback to this pattern, however, is that it makes extensions to the class hierarchy more difficult, as new classes typically require a new visit method to be added to each visitor.
 #### Specific Problems and Implementations
 
 ## Example: (mostly borrowed from https://github.com/kingreza/Swift-Visitor)
 ![ExampleUml](VisitorMechanicExampleUml.png)
 In this example we have a mechanic shop which has customer, mechanic, car, appointments, and quote entities. They want to generate reports for appointments and quotes in both Email and Report format (and potentially more formats in the future).
 
 The solution is to define Documenter and Documentable interfaces (Visitor and Visitable). The subjects of the reports (Quote and Appointment) both implement Visitable which means they have a process() function which takes Documenter and calls documentor.process(self) on itself.
 
    Then EmailDocumenter and ReportDocumenter classes are created which implement Visitor. So each one needs a process() function for each type of documentable object they might encounter.

    Finally in the implementation we can simply loop through the appointments and quotes and call  accept() for both our documentors on each one.
 */
struct Car {
    let make: String
    let model: String
    let mileage: Int
    
    init(make: String, model: String, mileage: Int) {
        self.make = make
        self.model = model
        self.mileage = mileage
    }
}

struct Mechanic {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

struct Customer {
    let name: String
    let email: String
    // address, zipcode etc.
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}

// interface for Visitable
protocol Documentable {
    func accept(documenter: Documenter)
}

// interface for Visitor
protocol Documenter {
    func process(_ documentable: Appointment)
    func process(_ documentable: Quote)
}

class Appointment: Documentable {
    var customer: Customer
    var mechanic: Mechanic
    var price: Double
    // date etc.
    
    init(customer: Customer, mechanic: Mechanic, price: Double) {
        self.customer = customer
        self.mechanic = mechanic
        self.price = price
    }
    
    func accept (documenter: Documenter) {
        documenter.process(self)
    }
}

class Quote: Documentable {
    var customer: Customer
    var price: Double
    var car: Car
    
    init(customer: Customer, price: Double, car: Car) {
        self.customer = customer
        self.price = price
        self.car = car
    }
    
    func accept (documenter: Documenter) {
        documenter.process(self)
    }
}
struct Email {
    let from: String
    let to: String
    let subject: String
    var body: String
    
    init(from: String = "hi@example.com", to: String, subject: String = "", body: String = "" ) {
        self.from = from
        self.to = to
        self.subject = subject
        self.body = body
    }
    
    func output() {
        print("From: \(self.from)")
        print("To: \(self.to)")
        print("Subject: \(self.subject)")
        print("Body: \(body)")
    }
}

struct Report {
    let reportType: ReportType
    let title: String
    let content: String
    
    init(reportType: ReportType, title: String, content: String) {
        self.reportType = reportType
        self.title = title
        self.content = content
    }
    
    func output() {
        print("Report: \(self.title)")
        print("Content: \(self.content)")
        print("************************\n")
    }
}

enum ReportType: Int {
    case Quote = 0, Appointment
}

class EmailDocumenter: Documenter {
    func process(_ documentable: Quote) {
        var content = "Hello \(documentable.customer.name) \n"
        content += "We have a quote for your \(documentable.car.make) \(documentable.car.model) \n"
        //content += "For the services you have requested in \(documentable.customer.address) \n"
        content += "We have generated a quote priced at \(documentable.price) \n"
        let email = Email(to: documentable.customer.email,
                          subject: "Here is a quote for your \(documentable.car.make)",
            body: content)
        
        email.output()
    }
    
    func process(_ documentable: Appointment) {
        var content = "Hello \(documentable.customer.name) \n"
        content += "make sure you have not driven your car for an hour before the appointment \n"
        content += "\(documentable.mechanic.name) will be more than happy " +
        "to answer any questions you might have \n"
        content += "You card will be billed for \(documentable.price) " +
        "once the appointment is finished \n"
        
        let email = Email(to: documentable.customer.email,
                          subject: "Your appointment is set",
            body: content)
        
        email.output()
    }
}

class ReportDocumenter: Documenter {
    func process(_ documentable: Quote) {
        var content = "Quote for \(documentable.car.make) \(documentable.car.model) was generated \n"
        content += "Customer:\t \(documentable.customer.name) \n"
        content += "Quoted Price:\t \(documentable.price)"
        
        let report = Report(reportType: .Quote,
                            title: "Quote Generation Report for \(documentable.customer.name)",
            content: content)
        
        report.output()
    }
    func process(_ documentable: Appointment) {
        var content = "Appointment for \(documentable.customer.name) was generated\n"
        content += "Customer:\t \(documentable.customer.name)\n"
        content += "Mechanic:\t \(documentable.mechanic.name)\n"
        content += "Price:\t \(documentable.price)"
        
        let report = Report(reportType: .Appointment,
                            title: "Appointment Generation Report for \(documentable.customer.name)",
            content: content)
        report.output()
    }
}
//: #### Usage
// Make some data:
var joe = Mechanic(name: "Joe Stevenson")
var mike = Mechanic (name: "Mike Dundee")
var reza = Customer(name: "Reza Shirazian",
                    email: "reza@example.com")
var lyanne = Customer(name: "Lyanne Borne",
                      email: "jb_hhm@example.com")
var sam = Customer(name: "Sam Lee",
                   email: "lee.sam.3oo@example.com")

var quote1 = Quote(customer: reza,
                   price: 55.00,
                   car: Car(make: "Ford", model: "Mustang", mileage: 9500))
var quote2 = Quote(customer: lyanne,
                   price: 463.25,
                   car: Car(make: "Chevrolet", model: "Silverado", mileage: 15200))
var quote3 = Quote(customer: sam,
                   price: 1155.00,
                   car: Car(make: "Honda", model: "Civic", mileage: 78000))
var quotes = [quote1, quote2, quote3]

var appointment1 = Appointment(customer: reza,
                               mechanic: joe,
                               price: 455.88)
var appointment2 = Appointment(customer: sam,
                               mechanic: mike,
                               price: 554.00)
var appointments = [appointment1, appointment2]

// Make our documenters.
var documentors: [Documenter] = [EmailDocumenter(), ReportDocumenter()]

// Loop through our documentors and generate reports.
for documentor in documentors {
    for quote in quotes {
        documentor.process(quote)
    }
    for appointment in appointments {
        documentor.process(appointment)
    }
}


//: #### Output
/*
 From: hi@example.com
 To: reza@example.com
 Subject: Here is a quote for your Ford
 Body: Hello Reza Shirazian
 We have a quote for your Ford Mustang
 We have generated a quote priced at 55.0
 
 From: hi@example.com
 To: jb_hhm@example.com
 Subject: Here is a quote for your Chevrolet
 Body: Hello Lyanne Borne
 We have a quote for your Chevrolet Silverado
 We have generated a quote priced at 463.25
 
 From: hi@example.com
 To: lee.sam.3oo@example.com
 Subject: Here is a quote for your Honda
 Body: Hello Sam Lee
 We have a quote for your Honda Civic
 We have generated a quote priced at 1155.0
 
 From: hi@example.com
 To: reza@example.com
 Subject: Your appointment is set
 Body: Hello Reza Shirazian
 make sure you have not driven your car for an hour before the appointment
 Joe Stevenson will be more than happy to answer any questions you might have
 You card will be billed for 455.88 once the appointment is finished
 
 From: hi@example.com
 To: lee.sam.3oo@example.com
 Subject: Your appointment is set
 Body: Hello Sam Lee
 make sure you have not driven your car for an hour before the appointment
 Mike Dundee will be more than happy to answer any questions you might have
 You card will be billed for 554.0 once the appointment is finished
 
 Report: Quote Generation Report for Reza Shirazian
 Content: Quote for Ford Mustang was generated
 Customer:     Reza Shirazian
 Quoted Price:     55.0
 ************************
 
 Report: Quote Generation Report for Lyanne Borne
 Content: Quote for Chevrolet Silverado was generated
 Customer:     Lyanne Borne
 Quoted Price:     463.25
 ************************
 
 Report: Quote Generation Report for Sam Lee
 Content: Quote for Honda Civic was generated
 Customer:     Sam Lee
 Quoted Price:     1155.0
 ************************
 
 Report: Appointment Generation Report for Reza Shirazian
 Content: Appointment for Reza Shirazian was generated
 Customer:     Reza Shirazian
 Mechanic:     Joe Stevenson
 Price:     455.88
 ************************
 
 Report: Appointment Generation Report for Sam Lee
 Content: Appointment for Sam Lee was generated
 Customer:     Sam Lee
 Mechanic:     Mike Dundee
 Price:     554.0
 ************************

 */
//: [Next](@next)








