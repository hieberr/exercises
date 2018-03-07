//: [Previous](@previous)
/*:
 # Prototype
 #### Objective
 To create an example of the Prototype Pattern
 
 #### Definition
 When creating an object is expensive, create it once and cache the prototype. Create future instances by cloning the prototype.
 
 ![UML](PrototypeUml.png)
 
 #### When To Use
 - The prototype Design pattern should be used when you need to create new objects that are cheaper to clone, than to create via new() and then setting its member values.
 
 - The prototype pattern can be used in conjuction with the abstract factory pattern .
 - The prototype pattern can use a singleton to hold the initial prototype from which others are cloned.
 - Design patterns that make heavy use of composite and decorator patterns can benefit from the prototype pattern as well.
 - Rule of thumb: clone an object when you want to create another object at runtime that is a true copy of the object you are cloning. For example, if you had an Account object that you wanted to clone, modify slightly, and then replace the original object with the updated Account object.
 
 #### Implementation
 - Generally you create an abstract class which includes a clone() method.  One or more classes implement this abstract class and a client instantiates the first one (or a singleton holds the prototype), and makes clones when more are needed.
 
 */
import Foundation

protocol Game {
    func setupScore(teamA: Int, teamB: Int)
    func getScore() -> (teamA: Int, teamB: Int)
    func getSport() -> String //returns the name of the sport
    func clone() -> Game
}


class BasketballGame: Game {
    var teamAScore = 0, teamBScore = 0;
    var courtDimensions: (x: Int, y: Int)
    var someExpensiveThing: String
    
    init() {
        //do expensive general initializing.
        courtDimensions = (x: 40, y: 200)
        someExpensiveThing = "expensiveBasketballOperation"
    }
    
    init(game: BasketballGame) {
        self.courtDimensions = game.courtDimensions;
        self.someExpensiveThing = game.someExpensiveThing;
        teamAScore = game.teamAScore;
        teamBScore = game.teamBScore;
    }
    
    func setupScore(teamA: Int, teamB: Int) {
        //More setup of things to be customized after cloning.
        teamAScore = teamA;
        teamBScore = teamB;
    }
    
    func getScore() -> (teamA: Int, teamB: Int) {
        return (teamAScore, teamBScore)
    }
    
    func getSport() -> String {
        return "Basketball"
    }
    
    func clone() -> Game {
        return BasketballGame(game: self)
    }
}

class FootballGame: Game {
    var teamAScore = 0, teamBScore = 0;
    var fieldDimensions: (x: Int, y: Int)
    var someExpensiveFootballThing: String
    
    init() {
        //do expensive general initializing.
        fieldDimensions = (x: 40, y: 200)
        someExpensiveFootballThing = "expensiveFootballOperation"
    }
    
    init(game: FootballGame) {
        self.fieldDimensions = game.fieldDimensions;
        self.someExpensiveFootballThing = game.someExpensiveFootballThing;
        teamAScore = game.teamAScore;
        teamBScore = game.teamBScore;
    }
    
    func setupScore(teamA: Int, teamB: Int) {
        //More setup of things to be customized after cloning.
        teamAScore = teamA;
        teamBScore = teamB;
    }
    
    func getScore() -> (teamA: Int, teamB: Int) {
        return (teamAScore, teamBScore)
    }
    
    func getSport() -> String {
        return "Football"
    }
    
    func clone() -> Game {
        return FootballGame(game: self)
    }
}

class EndOfGameViewController {
    private var game: Game
    public init(gameToDisplay: Game) {
        game = gameToDisplay.clone()
        
        // display the score
        let score = game.getScore()
        print("\(game.getSport()) - FinalScore: \(score.teamA), \(score.teamB)")
    }
}

//: #### Usage:
var basketballGame: BasketballGame = BasketballGame()
basketballGame.setupScore(teamA: 110, teamB: 90)

// viewController clones game and keeps it's own local copy.
var viewController = EndOfGameViewController(gameToDisplay: basketballGame)

// Continuing on with the next game, doesn't impact the copy that EndofGameViewController has
basketballGame.setupScore(teamA: 77, teamB: 88)

// And the same works for football game
var footballGame: FootballGame = FootballGame()
footballGame.setupScore(teamA: 21, teamB: 28)
viewController = EndOfGameViewController(gameToDisplay: footballGame)

//: #### Output
 /*
 Basketball - FinalScore: 110, 90
 Football - FinalScore: 21, 28
*/

//: [Next](@next)
