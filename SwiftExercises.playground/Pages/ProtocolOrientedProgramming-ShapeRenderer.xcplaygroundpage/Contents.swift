//: [Previous](@previous)

import Foundation
import UIKit

/*:
 # ProtocolOrientedProgramming-ShapeRenderer
 ## Objective:
 Implement a simple shape / document renderer example using structs and protocols instead of classes.  This is the example given in the WWDC presentation on Protocol Oriented Programming in Swift.
 
 #### Summary
 - Protocols better than superclasses for abstraction
 - Protocol extensions are great
 
 #### When to use classes
 You want implicit sharing when
- Copying or comparing instances doesn't make sense (e.g. window, midi ports...)
- Instance lifetime is tied to external effects (e.g. TemporaryFile)
- Instances are just "sinks" - write only conduits to external state (e.g. CGContext)
 
 ## Example:
 */

protocol Renderer {
    func moveTo(_ p: CGPoint)
    func lineTo(_ p: CGPoint)
    func arcAt(center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat)
}

struct TestRenderer : Renderer {
    func moveTo(_ p: CGPoint) {
        print("moveTo(\(p.x), \(p.y))")
    }
    func lineTo(_ p: CGPoint) {
        print("lineTo(\(p.x), \(p.y))")
    }
    func arcAt(center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat) {
        print("arcAt(\(center), radius: \(radius), startAngle: \(startAngle), endAngle: \(endAngle))")
    }
}

extension CGContext : Renderer {
    func moveTo(_ p: CGPoint) {
        move(to: p)
    }
    func lineTo(_ p: CGPoint) {
        addLine(to: p)
    }
    func arcAt(center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat) {
        addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    }
}

protocol Drawable {
    func isEqualTo(_ other: Drawable) -> Bool
    func draw(renderer: Renderer)
}

extension Drawable where Self : Equatable {
    func isEqualTo(_ other: Drawable) -> Bool {
        if let _other = other as? Self {
            return self == _other
        }
        return false
    }
}
struct Circle : Drawable, Equatable {
    let center: CGPoint
    let radius: CGFloat;

    func draw(renderer: Renderer) {
        renderer.arcAt(center: center, radius: radius, startAngle: CGFloat(0), endAngle: CGFloat(CGFloat.pi * 2))
    }
    
    static func ==(lhs: Circle, rhs: Circle) -> Bool {
        return rhs.center == lhs.center && rhs.radius == lhs.radius
    }
}

struct Polygon : Drawable, Equatable {
    let points: Array<CGPoint>
    
    func draw(renderer: Renderer) {
        if points.isEmpty {
            return
        }
        renderer.moveTo(points.last!)
        
        for point in points {
            renderer.lineTo(point)
        }
    }
    static func == (lhs: Polygon, rhs: Polygon) -> Bool {
        return rhs.points == lhs.points
    }
}

struct Diagram : Equatable {
    let elements: [Drawable]
    
    func draw(renderer: Renderer) {
        for element in elements {
            element.draw(renderer: renderer)
        }
    }
    
    static func ==(lhs: Diagram, rhs: Diagram) -> Bool {
        //return lhs.elements == rhs.elements // nopeBool
        return lhs.elements.count == rhs.elements.count && !zip(lhs.elements, rhs.elements).contains(where: {(arg: (Drawable, Drawable)) in return !arg.0.isEqualTo(arg.1)})
    }
}
//: #### Usage

var circle = Circle(center: CGPoint(x:0, y:0), radius: CGFloat(40))
var square = Polygon(points: [CGPoint(x:0, y:0), CGPoint(x:40, y:0), CGPoint(x:40, y:40), CGPoint(x:40, y:0)])

var diagram = Diagram(elements: [circle, square])

diagram.draw(renderer: TestRenderer())

//: #### Output
/*
 arcAt((0.0, 0.0), radius: 40.0, startAngle: 0.0, endAngle: 6.28318530717959)
 moveTo(40.0, 0.0)
 lineTo(0.0, 0.0)
 lineTo(40.0, 0.0)
 lineTo(40.0, 40.0)
 lineTo(40.0, 0.0)

 */
//: [Next](@next)








