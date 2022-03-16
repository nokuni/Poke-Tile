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
    @Published var game = Game()
    
    @Published var isShowingTurnAnimation = false
    @Published var isShowingGameEnding = false
    @Published var isRotatingCard = [Bool](repeating: false, count: 16)
    
    static let shared = GameViewModel()
    
    init() { }
    
    // MARK: - CORE
    func createNewGame(trainer: Trainer, deck: Deck) {
        game.deck = deck
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
        game = Game()
        isShowingGameEnding.toggle()
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
    
    // MARK: - CARD ACTIONS
    
    // Legendary special actions
    func grassLegendaryActions(name: String, edgeIndex: Int, match: Int) {
        var grassDebuff = try! Card.getDebuff(type: .grass)
        
        switch name {
        case "Venusaur":
            fillBoard(with: grassDebuff)
        case "Vileplume":
            fillLines(with: grassDebuff, on: match)
        case "Torterra":
            grassDebuff.debuffs = Array(repeating: "grass", count: 2)
            if game.board[edgeIndex].isAvailable {
                withAnimation { game.board[edgeIndex] = grassDebuff }
            }
        case "Serperior":
            convertAll(debuff: grassDebuff)
        case "Tsareena":
            ()
        case "Appletun":
            ()
        default: ()
        }
    }
    func fireLegendaryActions(name: String, edgeIndex: Int, match: Int) {
        let fireDebuff = try! Card.getDebuff(type: .fire)
        switch name {
        case "Charizard":
            for index in game.boardIndices {
                if game.board[index].isDebuff && game.board[index].type != .fire {
                    game.board[index] = fireDebuff
                }
            }
        default: ()
        }
    }
    func waterLegendaryActions(name: String, edgeIndex: Int, match: Int, card: Card) {
        switch name {
        case "Blastoise":
            for index in game.boardIndices { resetCardStats(index: index, on: match, card: card) }
        default: ()
        }
    }
    
    // Type actions
    func normalAction(of index: Int, on match: Int, card: Card) {
        guard card.type == .normal else { return }
        buffOnEmptyCard(of: index, on: match, card: card)
    }
    func grassAction(edgeIndex: Int, on match: Int, card: Card) {
        guard card.type == .grass else { return }
        let grassDebuff = try! Card.getDebuff(type: .grass)
        grassLegendaryActions(name: card.name, edgeIndex: edgeIndex, match: match)
        if game.board[edgeIndex].isAvailable {
            withAnimation { game.board[edgeIndex] = grassDebuff }
        } else if game.board[edgeIndex].isDebuff && game.board[edgeIndex].type == .grass {
            if game.board[edgeIndex].debuffs.count < 4 {
                withAnimation { game.board[edgeIndex].debuffs.append("grass") }
            }
        }
    }
    func fireAction(edgeIndex: Int, on match: Int, card: Card) {
        guard card.type == .fire else { return }
        let fireDebuff = try! Card.getDebuff(type: .fire)
        //fireDebuff.debuffs.append("fire")
        fireLegendaryActions(name: card.name, edgeIndex: edgeIndex, match: match)
        if game.board[edgeIndex].isDebuff && game.board[edgeIndex].type != .fire {
            game.board[edgeIndex] = fireDebuff
        }
    }
    func waterAction(edgeIndex: Int, on match: Int, card: Card) {
        guard card.type == .water else { return }
        waterLegendaryActions(name: card.name, edgeIndex: edgeIndex, match: match, card: card)
        resetCardStats(index: edgeIndex, on: match, card: card)
    }
    func fightingAction(edgeIndex: Int, with cardIndex: Int) {
        if game.userCards[cardIndex].type == .fighting {
            game.board[edgeIndex].stats.top += 1
            game.board[edgeIndex].stats.trailing += 1
            game.board[edgeIndex].stats.bottom += 1
            game.board[edgeIndex].stats.leading += 1
        }
    }
    func fightingActionForOpponent(edgeIndex: Int, with cardIndex: Int) {
        if game.trainerCards[cardIndex].type == .fighting {
            game.board[edgeIndex].stats.top += 1
            game.board[edgeIndex].stats.trailing += 1
            game.board[edgeIndex].stats.bottom += 1
            game.board[edgeIndex].stats.leading += 1
        }
    }
    
    func typeAction(of index: Int, on match: Int, card: Card) {
        switch card.type {
        case .empty:
            ()
        case .bug:
            ()
        case .dark:
            ()
        case .dragon:
            ()
        case .electric:
            ()
        case .fairy:
            ()
        case .fighting:
            ()
        case .fire:
            actionOnAdjacents(on: match, card: card)
        case .flying:
            ()
        case .ghost:
            ()
        case .grass:
            actionOnAdjacents(on: match, card: card)
        case .ground:
            ()
        case .ice:
            ()
        case .normal:
            normalAction(of: index, on: match, card: card)
        case .poison:
            ()
        case .psychic:
            ()
        case .rock:
            ()
        case .steel:
            ()
        case .water:
            actionOnAdjacents(on: match, card: card)
        }
    }
    
    // Various actions
    func fillBoard(with debuff: Card) {
        for index in game.boardIndices {
            if game.board[index].isAvailable {
                withAnimation { game.board[index] = debuff }
            }
        }
    }
    func fillLines(with debuff: Card, on match: Int) {
        let debuffLocations = Array(game.board.indices).getAdjacentLinesIndices(from: match)
        for location in debuffLocations {
            if game.board[location].isAvailable {
                withAnimation { game.board[location] = debuff }
            }
        }
    }
    func resetCardStats(index: Int, on match: Int, card: Card) {
        guard let dataIndex = Card.pokemons.firstIndex(where: { $0.name == game.board[index].name }) else { return }
        if card.side == .user {
            if game.board[index].isPokemon && game.board[index].side == .user {
                if game.board[index].stats.top < 0 { game.board[index].stats.top = abs(game.board[index].stats.top) }
                if game.board[index].stats.trailing < 0 { game.board[index].stats.trailing = abs(game.board[index].stats.trailing) }
                if game.board[index].stats.bottom < 0 { game.board[index].stats.bottom = abs(game.board[index].stats.bottom) }
                if game.board[index].stats.leading < 0 { game.board[index].stats.leading = abs(game.board[index].stats.leading) }
            }
            if game.board[index].isPokemon && game.board[index].side == .opponent {
                if game.board[index].stats.top > Card.pokemons[dataIndex].stats.top { game.board[index].stats.top = Card.pokemons[dataIndex].stats.top }
                if game.board[index].stats.trailing > Card.pokemons[dataIndex].stats.trailing { game.board[index].stats.trailing = Card.pokemons[dataIndex].stats.trailing }
                if game.board[index].stats.bottom > Card.pokemons[dataIndex].stats.bottom { game.board[index].stats.bottom = Card.pokemons[dataIndex].stats.bottom }
                if game.board[index].stats.leading > Card.pokemons[dataIndex].stats.leading { game.board[index].stats.leading = Card.pokemons[dataIndex].stats.leading }
            }
        }
        if card.side == .opponent {
            if game.board[index].isPokemon && game.board[index].side == .opponent {
                if game.board[index].stats.top < 0 { game.board[index].stats.top = abs(game.board[index].stats.top) }
                if game.board[index].stats.trailing < 0 { game.board[index].stats.trailing = abs(game.board[index].stats.trailing) }
                if game.board[index].stats.bottom < 0 { game.board[index].stats.bottom = abs(game.board[index].stats.bottom) }
                if game.board[index].stats.leading < 0 { game.board[index].stats.leading = abs(game.board[index].stats.leading) }
            }
            if game.board[index].isPokemon && game.board[index].side == .user {
                if game.board[index].stats.top > Card.pokemons[dataIndex].stats.top { game.board[index].stats.top = Card.pokemons[dataIndex].stats.top }
                if game.board[index].stats.trailing > Card.pokemons[dataIndex].stats.trailing { game.board[index].stats.trailing = Card.pokemons[dataIndex].stats.trailing }
                if game.board[index].stats.bottom > Card.pokemons[dataIndex].stats.bottom { game.board[index].stats.bottom = Card.pokemons[dataIndex].stats.bottom }
                if game.board[index].stats.leading > Card.pokemons[dataIndex].stats.leading { game.board[index].stats.leading = Card.pokemons[dataIndex].stats.leading }
            }
        }
    }
    func buffOnEmptyCard(of index: Int, on match: Int, card: Card) {
        let isEmptyDebuff = game.board[match].isDebuff && game.board[match].debuffs.isEmpty
        if game.board[match].isAvailable || isEmptyDebuff {
            if card.side == .user {
                game.userCards[index].stats.top += 1
                game.userCards[index].stats.trailing += 1
                game.userCards[index].stats.bottom += 1
                game.userCards[index].stats.leading += 1
            } else if card.side == .opponent {
                game.trainerCards[index].stats.top += 1
                game.trainerCards[index].stats.trailing += 1
                game.trainerCards[index].stats.bottom += 1
                game.trainerCards[index].stats.leading += 1
            }
        }
    }
    func convertAll(debuff: Card) {
        for index in game.boardIndices {
            if game.board[index].isDebuff {
                game.board[index] = debuff
            }
        }
    }
    func actionOnAdjacents(on match: Int, card: Card) {
        let adjacentIndex = game.getAdjacentCardIndex(from: match)
        
        if let topIndex = adjacentIndex.top {
            grassAction(edgeIndex: topIndex, on: match, card: card)
            fireAction(edgeIndex: topIndex, on: match, card: card)
            waterAction(edgeIndex: topIndex, on: match, card: card)
        }
        if let trailingIndex = adjacentIndex.trailing {
            grassAction(edgeIndex: trailingIndex, on: match, card: card)
            fireAction(edgeIndex: trailingIndex, on: match, card: card)
            waterAction(edgeIndex: trailingIndex, on: match, card: card)
        }
        if let bottomIndex = adjacentIndex.bottom {
            grassAction(edgeIndex: bottomIndex, on: match, card: card)
            fireAction(edgeIndex: bottomIndex, on: match, card: card)
            waterAction(edgeIndex: bottomIndex, on: match, card: card)
        }
        if let leadingIndex = adjacentIndex.leading {
            grassAction(edgeIndex: leadingIndex, on: match, card: card)
            fireAction(edgeIndex: leadingIndex, on: match, card: card)
            waterAction(edgeIndex: leadingIndex, on: match, card: card)
        }
    }
    func convertAdjacents(from match: Int, with cardIndex: Int) {
        let adjacentIndex = game.getAdjacentCardIndex(from: match)
        
        if let topIndex = adjacentIndex.top {
            if game.userCards[cardIndex].stats.top > game.board[topIndex].stats.bottom {
                if game.board[topIndex].isPokemon && !game.board[topIndex].isUserSide {
                    simpleSuccess()
                    rotatingCardAnimation(index: topIndex)
                    game.board[topIndex].side = .user
                    fightingAction(edgeIndex: topIndex, with: cardIndex)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isRotatingCard[topIndex].toggle()
                    }
                }
            }
        }
        
        if let trailingIndex = adjacentIndex.trailing {
            if game.userCards[cardIndex].stats.trailing > game.board[trailingIndex].stats.leading {
                if game.board[trailingIndex].isPokemon && !game.board[trailingIndex].isUserSide {
                    simpleSuccess()
                    rotatingCardAnimation(index: trailingIndex)
                    game.board[trailingIndex].side = .user
                    fightingAction(edgeIndex: trailingIndex, with: cardIndex)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isRotatingCard[trailingIndex].toggle()
                    }
                }
            }
        }
        
        if let bottomIndex = adjacentIndex.bottom {
            if game.userCards[cardIndex].stats.bottom > game.board[bottomIndex].stats.top {
                if game.board[bottomIndex].isPokemon && !game.board[bottomIndex].isUserSide {
                    simpleSuccess()
                    rotatingCardAnimation(index: bottomIndex)
                    game.board[bottomIndex].side = .user
                    fightingAction(edgeIndex: bottomIndex, with: cardIndex)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isRotatingCard[bottomIndex].toggle()
                    }
                }
            }
        }
        
        if let leadingIndex = adjacentIndex.leading {
            if game.userCards[cardIndex].stats.leading > game.board[leadingIndex].stats.trailing {
                if game.board[leadingIndex].isPokemon && !game.board[leadingIndex].isUserSide {
                    simpleSuccess()
                    rotatingCardAnimation(index: leadingIndex)
                    game.board[leadingIndex].side = .user
                    fightingAction(edgeIndex: leadingIndex, with: cardIndex)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isRotatingCard[leadingIndex].toggle()
                    }
                }
            }
        }
    }
    func convertAdjacentsForOpponent(from match: Int, with cardIndex: Int) {
        let adjacentIndex = game.getAdjacentCardIndex(from: match)
        
        if let topIndex = adjacentIndex.top {
            if game.trainerCards[cardIndex].stats.top > game.board[topIndex].stats.bottom {
                if game.board[topIndex].isPokemon && game.board[topIndex].isUserSide {
                    rotatingCardAnimation(index: topIndex)
                    game.board[topIndex].side = .opponent
                    fightingActionForOpponent(edgeIndex: topIndex, with: cardIndex)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isRotatingCard[topIndex].toggle()
                    }
                }
            }
        }
        
        if let trailingIndex = adjacentIndex.trailing {
            if game.trainerCards[cardIndex].stats.trailing > game.board[trailingIndex].stats.leading {
                if game.board[trailingIndex].isPokemon && game.board[trailingIndex].isUserSide {
                    rotatingCardAnimation(index: trailingIndex)
                    game.board[trailingIndex].side = .opponent
                    fightingActionForOpponent(edgeIndex: trailingIndex, with: cardIndex)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isRotatingCard[trailingIndex].toggle()
                    }
                }
            }
        }
        
        if let bottomIndex = adjacentIndex.bottom {
            if game.trainerCards[cardIndex].stats.bottom > game.board[bottomIndex].stats.top {
                if game.board[bottomIndex].isPokemon && game.board[bottomIndex].isUserSide {
                    rotatingCardAnimation(index: bottomIndex)
                    game.board[bottomIndex].side = .opponent
                    fightingActionForOpponent(edgeIndex: bottomIndex, with: cardIndex)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isRotatingCard[bottomIndex].toggle()
                    }
                }
            }
        }
        
        if let leadingIndex = adjacentIndex.leading {
            if game.trainerCards[cardIndex].stats.leading > game.board[leadingIndex].stats.trailing {
                if game.board[leadingIndex].isPokemon && game.board[leadingIndex].isUserSide {
                    rotatingCardAnimation(index: leadingIndex)
                    game.board[leadingIndex].side = .opponent
                    fightingActionForOpponent(edgeIndex: leadingIndex, with: cardIndex)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isRotatingCard[leadingIndex].toggle()
                    }
                }
            }
        }
    }
    func endOfTurnConvertAdjacents() {
        if let cardLocationOnBoard = game.boardIndices.first(where: { game.board[$0].name == "Victreebel" && game.board[$0].side == .user }),
           let cardLocationOnHand = game.userCards.firstIndex(where: { $0.name == "Victreebel" }) {
            convertAdjacents(from: cardLocationOnBoard, with: cardLocationOnHand)
        }
        
        if let cardLocationOnBoard = game.boardIndices.first(where: { game.board[$0].name == "Victreebel" && game.board[$0].side == .opponent }),
           let cardLocationOnHand = game.trainerCards.firstIndex(where: { $0.name == "Victreebel" }) {
            convertAdjacentsForOpponent(from: cardLocationOnBoard, with: cardLocationOnHand)
        }
    }
    
    // Card gesture
    func dropCard(match: Int, index: Int, card: Card, turn: Turn) {
        switch game.board[match].category {
        case .pokemon: return
        case .debuff:
            cardAction(match: match, index: index, buff: buffUserCard)
        case .empty:
            cardAction(match: match, index: index, buff: nil)
        }
    }
    func cardDropped(location: CGPoint, index: Int, card: Card) {
        if let match = game.boardFrames.firstIndex(where: { $0.contains(location) }) {
            dropCard(match: match, index: index, card: card, turn: .opponent)
        }
    }
    func cardAction(match: Int, index: Int, buff: ((Int, Card) -> Void)?) {
        buff?(index, game.board[match])
        typeAction(of: index, on: match, card: game.userCards[index])
        convertAdjacents(from: match, with: index)
        game.board[match] = game.userCards[index]
        game.userCards[index].isActivated = false
        game.turn = .opponent
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if !self.game.isGameOver {
                self.isShowingTurnAnimation.toggle()
            } else {
                self.isShowingGameEnding.toggle()
            }
        }
    }
    
    func buffUserCard(index: Int, debuff: Card) {
        let count = debuff.debuffs.count
        let buffAmount = game.userCards[index].type == debuff.type ? count : -count
        let invertedBuffAmount = game.userCards[index].type != debuff.type ? count : -count
        if game.userCards[index].type == .ghost {
            game.userCards[index].stats.top += invertedBuffAmount
            game.userCards[index].stats.trailing += invertedBuffAmount
            game.userCards[index].stats.bottom += invertedBuffAmount
            game.userCards[index].stats.leading += invertedBuffAmount
        } else {
            game.userCards[index].stats.top += buffAmount
            game.userCards[index].stats.trailing += buffAmount
            game.userCards[index].stats.bottom += buffAmount
            game.userCards[index].stats.leading += buffAmount
        }
    }
    func buffTrainerCard(index: Int, debuff: Card) {
        let count = debuff.debuffs.count
        let buffAmount = game.trainerCards[index].type == debuff.type ? count : -count
        game.trainerCards[index].stats.top += buffAmount
        game.trainerCards[index].stats.trailing += buffAmount
        game.trainerCards[index].stats.bottom += buffAmount
        game.trainerCards[index].stats.leading += buffAmount
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
    
    // MARK: - OPPONENT AI
    
    func compareCardsStats(firstCard: Card, secondCard: Card) -> ((top: Bool, location: Int), (trailing: Bool, location: Int), (bottom: Bool, location: Int), (leading: Bool, location: Int)) {
        guard let firstCardIndex = game.board.firstIndex(where: { $0.id == firstCard.id }) else { return ((top: false, location: -1), (trailing: false, location: -1), (bottom: false, location: -1), (leading: false, location: -1)) }
        
        let adjacentCardIndex = game.getAdjacentCardIndex(from: firstCardIndex)
        
        var result: ((top: Bool, location: Int), (trailing: Bool, location: Int), (bottom: Bool, location: Int), (leading: Bool, location: Int)) = ((top: false, location: -1), (trailing: false, location: -1), (bottom: false, location: -1), (leading: false, location: -1))
        
        
        if let topIndex = adjacentCardIndex.top {
            let buffedTop = secondCard.buffed(with: game.board[topIndex])
            result.0.top = buffedTop.stats.bottom > firstCard.stats.top
            result.0.location = topIndex
        }
        
        if let trailingIndex = adjacentCardIndex.trailing {
            let buffedTrailing = secondCard.buffed(with: game.board[trailingIndex])
            result.1.trailing = buffedTrailing.stats.leading > firstCard.stats.trailing
            result.1.location = trailingIndex
        }
        
        if let bottomIndex = adjacentCardIndex.bottom {
            let buffedBottom = secondCard.buffed(with: game.board[bottomIndex])
            result.2.bottom = buffedBottom.stats.top > firstCard.stats.bottom
            result.2.location = bottomIndex
        }
        
        if let leadingIndex = adjacentCardIndex.leading {
            let buffedLeading = secondCard.buffed(with: game.board[leadingIndex])
            result.3.leading = buffedLeading.stats.trailing > firstCard.stats.leading
            result.3.location = leadingIndex
        }
        
        return result
    }
    
    func convertingMatches(of firstCardIndex: Int, with secondCard: Card) -> [Int] {
        let cardsComparison = compareCardsStats(firstCard: game.board[firstCardIndex], secondCard: secondCard)
        
        var result = [Int]()
        
        if cardsComparison.0.top { result.append(cardsComparison.0.location) }
        if cardsComparison.1.trailing { result.append(cardsComparison.1.location) }
        if cardsComparison.2.bottom { result.append(cardsComparison.2.location) }
        if cardsComparison.3.leading { result.append(cardsComparison.3.location) }
        
        return result
    }
    
    func rotatingCardAnimation(index: Int) {
        withAnimation(.linear.repeatCount(2, autoreverses: false)) {
            isRotatingCard[index].toggle()
        }
    }
    
    func opponentCardAction(actionIndex: Int, cardIndex: Int, targetIndex: Int?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            if let targetIndex = targetIndex {
                self.isRotatingCard[targetIndex].toggle()
            }
            
            self.isRotatingCard[actionIndex].toggle()
            
            withAnimation {
                self.buffTrainerCard(index: cardIndex, debuff: self.game.board[actionIndex])
                self.typeAction(of: cardIndex, on: actionIndex, card: self.game.trainerCards[cardIndex])
                self.game.board[actionIndex] = self.game.trainerCards[cardIndex]
                if let targetIndex = targetIndex {
                    self.game.board[targetIndex].side = .opponent
                }
                self.game.trainerCards[cardIndex].isActivated = false
                self.endOfTurnConvertAdjacents()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        if !self.game.isGameOver {
                            self.game.turn = .user
                            self.isShowingTurnAnimation.toggle()
                        } else {
                            self.isShowingGameEnding.toggle()
                        }
                    }
                }
            }
        }
    }
    
    func userMatchingWeaknesses(with card: Card) -> (locations: [Int], index: Int?) {
        var weaknessLocations = [Int]()
        var userCardIndex: Int? = nil
        let userCardsSortedByCostIndices = game.userCardsIndicesOnBoard.sorted(by: { game.board[$0].cost > game.board[$1].cost })
        for index in userCardsSortedByCostIndices {
            let indices = convertingMatches(of: index, with: card).filter { game.board[$0].category != .pokemon }
            if !indices.isEmpty {
                weaknessLocations = indices
                userCardIndex = index
                break
            }
        }
        return (weaknessLocations, userCardIndex)
    }
    
    func getBestLocation(with card: Card) -> Int? {
        let availableLocations = game.boardIndices.filter { game.board[$0].category != .pokemon }
        let debuffLocations = availableLocations.filter { game.board[$0].debuffs.contains(card.type.rawValue) }
        let bestLocationsForCard = debuffLocations.sorted(by: { game.board[$0].debuffs.count > game.board[$1].debuffs.count })
        if bestLocationsForCard.isEmpty {
            return availableLocations.randomElement()
        } else {
            return bestLocationsForCard.first
        }
    }
    
    func opponentPlays() {
        let availableCards = game.trainerCards.filter { $0.isActivated }
        let sortedAvailableCards = availableCards.sorted(by: { $0.cost < $1.cost })
        guard let firstPlayableCard =  sortedAvailableCards.first else { return }
        guard let firstPlayableCardIndex = game.trainerCards.firstIndex(of: firstPlayableCard) else { return }
        
        if let chosenCard = sortedAvailableCards.first(where: { userMatchingWeaknesses(with: $0).index != nil && !userMatchingWeaknesses(with: $0).locations.isEmpty }),
           let cardIndex = game.trainerCards.firstIndex(of: chosenCard) {
            let matchingWeaknesses = userMatchingWeaknesses(with: chosenCard)
            if let weaknessIndex = matchingWeaknesses.locations.randomElement() {
                rotatingCardAnimation(index: weaknessIndex)
                if let targetIndex = matchingWeaknesses.index {
                    rotatingCardAnimation(index: targetIndex)
                    opponentCardAction(actionIndex: weaknessIndex, cardIndex: cardIndex, targetIndex: targetIndex)
                }
            }
        } else {
            print("No target")
            if let location = getBestLocation(with: firstPlayableCard) {
                rotatingCardAnimation(index: location)
                opponentCardAction(actionIndex: location, cardIndex: firstPlayableCardIndex, targetIndex: nil)
            }
        }
    }
}
