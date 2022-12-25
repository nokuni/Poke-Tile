//
//  GameViewModel.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 17/02/2022.
//

// Lock/Unlock deck for prebuild
// Deck playable only if the user has all cards.
// Search in decks view

//CardSummonAnimation
//UserHandView
//GameGridView

import SwiftUI

class GameViewModel: ObservableObject {
    
    static let shared = GameViewModel()
    
    let animation = ChainAnimation()
    
    @Published var game = Game()
    @Published var gameAI = GameAI()
    
    @Published var cardConversion = CardConversion()
    
    // MARK: - Actions
    @Published var cardGestureAction = CardGestureAction()
    @Published var typeCardAction = TypeCardAction()
    @Published var legendaryCardAction = LegendaryCardAction()
    
    @Published var isShowingTurnAnimation = false
    @Published var isShowingGameEnding = false
    @Published var isRotatingCard = [Bool](repeating: false, count: 16)
    
    // MARK: - CORE
    @Published var home = HomeViewModel()
    @Published var adventure = AdventureViewModel()
    @Published var user = UserViewModel()
    @Published var mission = MissionViewModel()
    @Published var summons = SummonsViewModel()
    
    init() {
        game = Game()
        gameAI = GameAI()
        //user.filteredDecks(filter: filter)
    }
    
    // MARK: - CORE
    func createNewGame(trainer: Trainer, deck: Deck) {
        game.deck = deck
        print(deck.name)
        game.trainer = trainer
        loadBoard(bonus: addDebuffs, setup: setupTutorialBoard)
        loadPlayerHand()
        loadOpponentHand()
        print("Game created")
    }
    func createTutorialGame(trainer: Trainer) {
        guard let prebuildDeck = trainer.prebuildDeck else { return }
        game.deck = Deck(name: "Tutorial Deck", associatedType: .grass, pokemons: prebuildDeck, background: "lab.background")
        game.trainer = trainer
        loadPlayerHand()
        loadOpponentHand()
        loadBoard(bonus: addDebuffs, setup: setupTutorialBoard)
    }
    func resetGame() {
        game.trainer = nil
        game.trainerCards = [Card]()
        game.deck = nil
        game.userCards = [Card]()
        game.board = [Card]()
        game.boardFrames = [CGRect](repeating: .zero, count: 16)
        game.turn = nil
    }
    func loadGame() {
        isShowingGameEnding.toggle()
        game.turn = .user
        loadPlayerHand()
        loadOpponentHand()
        loadBoard(bonus: addDebuffs, setup: setupTutorialBoard)
    }
    func loadBoard(bonus: ((Trainer?) -> Void), setup: ((Trainer?) -> Void)) {
        guard let trainer = game.trainer else { return }
        game.board = Array(repeating: Card.empty, count: 16)
        if Trainer.tutorialTrainers.contains(where: { $0.name == trainer.name }) {
            setup(game.trainer)
        } else {
            bonus(game.trainer)
        }
    }
    func loadPlayerHand() {
        if let deck = game.deck { game.userCards = deck.cards }
        game.userCards.indices.forEach { game.userCards[$0].side = .user }
        game.userCards.indices.forEach { game.userCards[$0].isActivated = true }
    }
    func loadOpponentHand() {
        guard let trainer = game.trainer else { return }
        game.trainerCards = trainer.cards
        game.trainerCards.indices.forEach { game.trainerCards[$0].side = .opponent }
    }
    
    func tutorialBoard(trainerDisableCardCount: Int, userDisableCardCount: Int, activationIndices: [Int], cardCountOnBoard: Int, userCardCountOnBoard: Int, trainerCardCountOnBoard: Int, bonusTiles: [(type: CardType, locations: [Int])]) {
        guard let trainer = game.trainer else { return }
        guard let prebuildDeck = trainer.prebuildDeck else { return }
        let decks = prebuildDeck + prebuildDeck
        let count = prebuildDeck.count * 2
        for index in  game.trainerCards.indices {
            if index < trainerDisableCardCount { game.trainerCards[index].isActivated = false }
        }
        for index in  game.userCards.indices {
            if index < userDisableCardCount { game.userCards[index].isActivated = false }
        }
        for index in activationIndices {
            game.userCards[index].isActivated = true
        }
        for index in 0..<count {
            if index < cardCountOnBoard {
                game.board[index] = try! Card.getPokemon(name: decks[index])
            }
            if index < userCardCountOnBoard {
                game.board[index].side = .user
            } else if index < trainerCardCountOnBoard {
                game.board[index].side = .opponent
            }
        }
        
        for bonusTile in bonusTiles {
            let type = try! Card.getDebuff(type: bonusTile.type)
            for location in bonusTile.locations {
                game.board[location] = type
                game.board[location].debuffs = [bonusTile.type.rawValue, bonusTile.type.rawValue, bonusTile.type.rawValue, bonusTile.type.rawValue]
            }
        }
    }
    
    func setupTutorialBoard(trainer: Trainer?) {
        guard let trainer = game.trainer else { return }
        
        switch true {
        case trainer.name == "Prof.Oak":
            tutorialBoard(trainerDisableCardCount: 7, userDisableCardCount: 7, activationIndices: [], cardCountOnBoard: 14, userCardCountOnBoard: 14, trainerCardCountOnBoard: 14, bonusTiles: [])
        case trainer.name == "Prof.Elm":
            tutorialBoard(trainerDisableCardCount: 7, userDisableCardCount: 8, activationIndices: [1], cardCountOnBoard: 14, userCardCountOnBoard: 6, trainerCardCountOnBoard: 14, bonusTiles: [])
        case trainer.name == "Prof.Birch":
            tutorialBoard(trainerDisableCardCount: 7, userDisableCardCount: 8, activationIndices: [1], cardCountOnBoard: 14, userCardCountOnBoard: 7, trainerCardCountOnBoard: 14, bonusTiles: [(type: .water, locations: [15]), (type: .ice, locations: [14])])
        default: ()
        }
    }
    
    
    // Futur changes of making it not random
    func addDebuffs(trainer: Trainer?) {
        guard let trainer = trainer else { return }
        guard let type = trainer.associatedType else { return }
        let debuff = try! Card.getDebuff(type: type)
        for index in trainer.bonusLocations {
            game.board[index] = debuff
        }
    }
}
