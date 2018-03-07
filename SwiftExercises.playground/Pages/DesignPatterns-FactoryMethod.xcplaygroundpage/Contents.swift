//: [Previous](@previous)

import Foundation

/*:
 # Factory Method
 ## Objective
Implement the Factory Method design pattern
 
 ### Factory Method Definition:
 "Define an interface for creating an object, but let subclasses decide which class to instantiate. The Factory method lets a class defer instantiation it uses to subclasses." (Gang Of Four)
 
 ![UML](FactoryMethodUml.png)
 
 #### When to use this pattern:
 - Use the factory method if the business requirements are more than just product creation.
 - If you need to abstract the factory itself as well as product creation.
 - If you want to control product creation steps or configuration, and the steps are customized depending on the factory.

 #### When not to use this pattern:
 - If you can, use a static/simple factory. For example, if you find yourself only needing ONE concrete factory, you don't need the added complexity of the abstract factory.
 
 ## Example
 I wanted to implement an example where the created types take different initialization data which the factory passes to them.  I have encountered this problem numerous times before. One case that I can remember involved creating MIDI messages which are used in music software to communicate note on/off messages as well as control changes (in addition to other types of MIDI message).  This example is a simplified version of the problem and does not match the MIDI specification.
 
 This example defines two types of Midi message: NoteMessage which contains a note value, and ControlMessage which contains a control number. Both types of midi message have data, and channel values.
 
 There are two factory classes, one for each type of Midi Message. The factory is initialized with a channel value, and  createMessage() takes the data as an argument. The ControlFactory is also initizlized with a control value which defines the value that its control messages get.
 */

// *************** The Messages  ***************
protocol AbstractMidiMessage {
    func getChannel() -> Int
    func getData() -> Int
    func getType() -> String
}

//Base MidiMessageBase class holds channel and data members which all midi messages contain.
class MidiMessageBase {
    var channel, data: Int
    public init(channel:Int, data: Int) {
        self.channel = channel
        self.data = data
    }
    
    public func getChannel() -> Int {
        return channel;
    }
    
    public func getData() -> Int {
        return data;
    }
}

class NoteMessage: MidiMessageBase, AbstractMidiMessage {
    private var noteValue: Int
    
    init(channel: Int, data: Int, noteValue: Int) {
        self.noteValue = noteValue
        super.init(channel: channel, data: data)
    }
    
    public func getType() -> String {
        return "NoteMessage"
    }
    // NoteMessage specific stuff
    public func getNote() -> Int {
        return noteValue;
    }
}

class ControlMessage: MidiMessageBase, AbstractMidiMessage {
    private var controlValue: Int;
    init(channel: Int, data: Int, controlValue: Int) {
        self.controlValue = controlValue
        super.init(channel: channel, data: data)
    }
    
    func getType() -> String {
        return "ControlMessage"
    }
    func getControlValue() -> Int {
        return controlValue;
    }
}

// *************** The Factories ******************
protocol AbstractMidiMessageFactory {
    func makeMessage(data: Int) -> AbstractMidiMessage
}

// Factory which makes note midi messages with a random note value assigned.
class RandomNoteFactory: AbstractMidiMessageFactory {
    private var channel: Int
    init(channel: Int) {
        self.channel = channel
    }
    func makeMessage(data: Int) -> AbstractMidiMessage {
        let randomNote: Int = Int(arc4random_uniform(128))
        return NoteMessage(channel: channel, data: data, noteValue: randomNote)
    }
}

// A factory for control midi messages. The factory is initialized with a control number, and outputs control messages with this number.
class ControlFactory: AbstractMidiMessageFactory {
    private var channel: Int
    private var controlValue: Int // controlValue for messages created by this factory.
    init(channel: Int, controlValue: Int) {
        self.channel = channel
        self.controlValue = controlValue
    }
    func makeMessage(data: Int) -> AbstractMidiMessage {
        return ControlMessage(channel: channel, data: data, controlValue: controlValue)
    }
}

//: #### Usage
// Create a messageFactory variable and assign a RandomNoteFactory to it.
var messageFactory: AbstractMidiMessageFactory = RandomNoteFactory(channel: 0)
var message: AbstractMidiMessage = messageFactory.makeMessage(data: 5)
print("Type: \(message.getType()) Channel: \(message.getChannel()) Data: \(message.getData())");

// Switch the message factory to a ControlFactory
messageFactory = ControlFactory(channel: 1, controlValue: 55)
message = messageFactory.makeMessage(data: 10)
print("Type: \(message.getType()) Channel: \(message.getChannel()) Data: \(message.getData())");

//: #### Output
/*
Type: NoteMessage Channel: 0 Data: 5
Type: ControlMessage Channel: 1 Data: 10
*/

//: [Next](@next)
