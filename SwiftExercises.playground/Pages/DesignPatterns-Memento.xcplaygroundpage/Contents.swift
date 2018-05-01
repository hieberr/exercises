//: [Previous](@previous)

import Foundation

/*:
 # Memento Design Pattern
 ## Objective:
 Implement the Memento pattern
 
 #### Definition:
 ![Uml](MementoUml.jpg)
 
 Consists of three parts: Originator, memento, and caretaker.
 
 The originator is responsible for
 
 - saving its internal state to a (memento) object and
 - restoring to a previous state from a (memento) object.
 - Only the originator that created a memento is allowed to access it.
 
 A client (caretaker) can request a memento from the originator (to save the internal state of the originator) and pass a memento back to the originator (to restore to a previous state).
 This enables to save and restore the internal state of an originator without violating its encapsulation.
 
 #### Specific Problems and Implementations
 

 ## Example:
 */
//The memento
struct GameState {
    public var score, level : Int
    public var chapter: String
    
    init(score: Int, level: Int, chapter: String) {
        self.score = score; self.level = level; self.chapter = chapter;
    }

}

// The originator
struct Game {
    public var score = 0, level = 0
    public var chapter: String = ""
    
    public func SaveGame() -> GameState {
        return GameState(score: score, level: level, chapter: chapter)
    }
    
    public mutating func loadGame(from: GameState) {
        score = from.score; level = from.level; chapter = from.chapter
    }
    
    public func PrintGameState() {
        print("Beginning game at chapter: \(chapter)-level: \(level), score: \(score)")
    }
    
    
}

// The caretaker
struct GameController {
    private var savedStates: Array<GameState> = Array<GameState>()
    
    public mutating func store(state: GameState) {
        savedStates.append(state)
    }
    
    public func get(index: Int) -> GameState? {
        return savedStates[index]
    }
}

//: #### Usage
var gameController = GameController()
var game = Game()

game.score += 200;
game.level = 1;
game.chapter = "Bubble World"
gameController.store(state: game.SaveGame())

game.score += 300;
game.level = 2;
game.chapter = "Bubble World"
gameController.store(state: game.SaveGame())

game.score += 500;
game.level = 3;
game.chapter = "Bubble World"
gameController.store(state: game.SaveGame())

game.score += 300;
game.level = 1;
game.chapter = "Lava World"
gameController.store(state: game.SaveGame())

game.score += 800;
game.level = 2;
game.chapter = "Lava World"
gameController.store(state: game.SaveGame())

game.loadGame(from: gameController.get(index: 2)!)
game.PrintGameState()
game.loadGame(from: gameController.get(index: 3)!)
game.PrintGameState()

game.loadGame(from: gameController.get(index: 0)!)
game.PrintGameState()

//: #### Output
/*
 Beginning game at chapter: Bubble World-level: 3, score: 1000
 Beginning game at chapter: Lava World-level: 1, score: 1300
 Beginning game at chapter: Bubble World-level: 1, score: 200
 */
//: [Next](@next)







