//
//  GameViewModel.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 17/02/2022.
//

// Lock/Unlock deck for prebuild
// Deck playable only if the user has all cards.
// Search in decks view

import SwiftUI

enum DeckFilters: String, CaseIterable {
    case all, playable
}

class GameViewModel: ObservableObject {
    @Published var trainers = [Trainer]()
    @Published var user = User(profile: Profile(name: "Nokuni", image: "userboy"))
    @Published var game = Game()
    
    @Published var isShowingTurnAnimation = false
    @Published var isShowingGameEnding = false
    @Published var isRotatingCard = [Bool](repeating: false, count: 16)
    
    static var shared = GameViewModel()
    
    init() {
        
    }
    
    func unlockedTrainers(from adventure: Adventure) -> [Trainer] {
        var realTrainers = adventure.realTrainers
        realTrainers[0].isUnlocked = true
        return realTrainers
    }
    
    func filteredDecks(filter: DeckFilters) -> [Deck] {
        switch filter {
        case .all:
            return user.decks
        case .playable:
            return user.decks.filter { isDeckPlayable(deck: $0) }
        }
    }
    
    func isCardInDeck(_ card: Card) -> Bool {
        user.cards.contains(where: { $0.name == card.name })
    }
    
    func resetGame() {
        game = Game()
        isShowingGameEnding.toggle()
    }
    
    func loadGame() {
        isShowingGameEnding.toggle()
        game.turn = .user
        loadBoard(bonus: addDebuffs)
        loadPlayerHand()
        loadOpponentHand()
    }
    
    func createNewGame(trainer: Trainer, deck: Deck) {
        game.deck = deck
        game.trainer = trainer
        loadBoard(bonus: addDebuffs)
        loadPlayerHand()
        loadOpponentHand()
        print("Game created")
    }
    
    func cardDropped(location: CGPoint, index: Int, card: Card) {
        if let match = game.boardFrames.firstIndex(where: { $0.contains(location) }) {
            dropCard(match: match, index: index, card: card, turn: .opponent)
        }
    }
    
    func endTurn(toStart turn: Turn) {
        if !self.game.isGameOver() { game.turn = turn }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if !self.game.isGameOver() {
                self.isShowingTurnAnimation.toggle()
            } else {
                
                self.isShowingGameEnding.toggle()
            }
        }
    }
    
    func convertAdjacents(from match: Int, with cardIndex: Int) {
        let adjacentIndex = game.getAdjacentCardIndex(from: match)
        
        if let topIndex = adjacentIndex.top,
           let deck = game.deck {
            if deck.cards[cardIndex].stats.top > game.board[topIndex].stats.bottom {
                if game.board[topIndex].category == .pokemon && game.board[topIndex].side != .user {
                    rotatingCardAnimation(index: topIndex)
                    game.board[topIndex].side = .user
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isRotatingCard[topIndex].toggle()
                    }
                }
            }
        }
        
        if let trailingIndex = adjacentIndex.trailing,
           let deck = game.deck {
            if deck.cards[cardIndex].stats.trailing > game.board[trailingIndex].stats.leading {
                if game.board[trailingIndex].category == .pokemon && game.board[trailingIndex].side != .user {
                    rotatingCardAnimation(index: trailingIndex)
                    game.board[trailingIndex].side = .user
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isRotatingCard[trailingIndex].toggle()
                    }
                }
            }
        }
        
        if let bottomIndex = adjacentIndex.bottom,
           let deck = game.deck {
            if deck.cards[cardIndex].stats.bottom > game.board[bottomIndex].stats.top {
                if game.board[bottomIndex].category == .pokemon && game.board[bottomIndex].side != .user {
                    rotatingCardAnimation(index: bottomIndex)
                    game.board[bottomIndex].side = .user
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isRotatingCard[bottomIndex].toggle()
                    }
                }
            }
        }
        
        if let leadingIndex = adjacentIndex.leading,
           let deck = game.deck {
            if deck.cards[cardIndex].stats.leading > game.board[leadingIndex].stats.trailing {
                if game.board[leadingIndex].category == .pokemon && game.board[leadingIndex].side != .user {
                    rotatingCardAnimation(index: leadingIndex)
                    game.board[leadingIndex].side = .user
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isRotatingCard[leadingIndex].toggle()
                    }
                }
            }
        }
    }
    
    func cardAction(match: Int, index: Int, buff: ((Int, Card) -> Void)?) {
        buff?(index, game.board[match])
        convertAdjacents(from: match, with: index)
        game.board[match] = game.userCards[index]
        game.userCards[index].isActivated = false
        //game.deck?.cards[index].isActivated = false
        game.turn = .opponent
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if !self.game.isGameOver() { self.isShowingTurnAnimation.toggle() } else { self.isShowingGameEnding.toggle()
            }
        }
    }
    
    func dropCard(match: Int, index: Int, card: Card, turn: Turn) {
        switch game.board[match].category {
        case .pokemon: return
        case .debuff:
            cardAction(match: match, index: index, buff: buffUserCard)
        case .empty:
            cardAction(match: match, index: index, buff: nil)
        }
    }
    
    func buffUserCard(index: Int, debuff: Card) {
        guard let debuffAmount = debuff.debuffAmount else { return }
        guard let deck = game.deck else { return }
        let buffAmount = deck.cards[index].type == debuff.type ? debuffAmount : -debuffAmount
        game.userCards[index].stats.top += buffAmount
        game.userCards[index].stats.trailing += buffAmount
        game.userCards[index].stats.bottom += buffAmount
        game.userCards[index].stats.leading += buffAmount
//        game.deck?.cards[index].stats.top += buffAmount
//        game.deck?.cards[index].stats.trailing += buffAmount
//        game.deck?.cards[index].stats.bottom += buffAmount
//        game.deck?.cards[index].stats.leading += buffAmount
    }
    
    func buffTrainerCard(index: Int, debuff: Card) {
        guard let debuffAmount = debuff.debuffAmount else { return }
        let buffAmount = game.trainerCards[index].type == debuff.type ? debuffAmount : -debuffAmount
        game.trainerCards[index].stats.top += buffAmount
        game.trainerCards[index].stats.trailing += buffAmount
        game.trainerCards[index].stats.bottom += buffAmount
        game.trainerCards[index].stats.leading += buffAmount
    }
    
    func buffedCard(card: Card, debuff: Card) -> Card {
        var card = card
        guard let debuffAmount = debuff.debuffAmount else { return card }
        let buffAmount = card.type == debuff.type ? debuffAmount : -debuffAmount
        card.stats.top += buffAmount
        card.stats.trailing += buffAmount
        card.stats.bottom += buffAmount
        card.stats.leading += buffAmount
        
        return card
    }
    
    func loadBoard(bonus: ((Trainer?) -> Void)) {
        game.board = Array(repeating: Card.empty, count: 16)
        bonus(game.trainer)
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
    
    func addDebuffs(trainer: Trainer?) {
        guard let trainer = trainer else { return }
        let types = Set(trainer.cards.map { $0.type })
        let randomIndices = game.boardIndices.differentRandomElements(amount: trainer.bonusAmount)
        for index in randomIndices {
            guard let randomType = types.randomElement() else { return }
            let randomCard = try! Card.getDebuff(type: randomType)
            game.board[index] = randomCard
            game.board[index].debuffAmount = Int.random(in: 1...3)
        }
    }
    
    func isDeckPlayable(deck: Deck) -> Bool {
        var boolArray = [Bool]()
        for card in deck.cards {
            if isCardInDeck(card) { boolArray.append(true) } else { boolArray.append(false) }
        }
        return boolArray.allSatisfy({ $0 == true })
    }
    
    // MARK: - OPPONENT AI
    
    func compareCardsStats(firstCard: Card, secondCard: Card) -> ((top: Bool, location: Int), (trailing: Bool, location: Int), (bottom: Bool, location: Int), (leading: Bool, location: Int)) {
        guard let firstCardIndex = game.board.firstIndex(where: { $0.id == firstCard.id }) else { return ((top: false, location: -1), (trailing: false, location: -1), (bottom: false, location: -1), (leading: false, location: -1)) }
        
        let adjacentCardIndex = game.getAdjacentCardIndex(from: firstCardIndex)
        
        var result: ((top: Bool, location: Int), (trailing: Bool, location: Int), (bottom: Bool, location: Int), (leading: Bool, location: Int)) = ((top: false, location: -1), (trailing: false, location: -1), (bottom: false, location: -1), (leading: false, location: -1))
        
        
        if let topIndex = adjacentCardIndex.top {
            let buffedTop = buffedCard(card: secondCard, debuff: game.board[topIndex])
            result.0.top = buffedTop.stats.bottom > firstCard.stats.top
            result.0.location = topIndex
        }
        
        if let trailingIndex = adjacentCardIndex.trailing {
            let buffedTrailing = buffedCard(card: secondCard, debuff: game.board[trailingIndex])
            result.1.trailing = buffedTrailing.stats.leading > firstCard.stats.trailing
            result.1.location = trailingIndex
        }
        
        if let bottomIndex = adjacentCardIndex.bottom {
            let buffedBottom = buffedCard(card: secondCard, debuff: game.board[bottomIndex])
            result.2.bottom = buffedBottom.stats.top > firstCard.stats.bottom
            result.2.location = bottomIndex
        }
        
        if let leadingIndex = adjacentCardIndex.leading {
            let buffedLeading = buffedCard(card: secondCard, debuff: game.board[leadingIndex])
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
        withAnimation(.linear.repeatCount(1, autoreverses: false)) {
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
                self.game.board[actionIndex] = self.game.trainerCards[cardIndex]
                if let targetIndex = targetIndex {
                    self.game.board[targetIndex].side = .opponent
                }
                self.game.trainerCards[cardIndex].isActivated = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        if !self.game.isGameOver() {
                            self.game.turn = .user
                            self.isShowingTurnAnimation.toggle()
                        } else { self.isShowingGameEnding.toggle() }
                    }
                }
            }
        }
    }
    
    func userMatchingWeaknesses(with card: Card) -> (locations: [Int], index: Int?) {
        var weaknessLocations = [Int]()
        var userCardIndex: Int? = nil
        for index in game.userCardsIndicesOnBoard {
            let indices = convertingMatches(of: index, with: card).filter { game.board[$0].category != .pokemon }
            if !indices.isEmpty {
                weaknessLocations = indices
                userCardIndex = index
                break
            }
        }
        return (weaknessLocations, userCardIndex)
    }
    
    // TEMPORARY
    var randomLocation: Int? {
        let debuffLocations = game.boardIndices.filter { game.board[$0].category != .pokemon }
        return debuffLocations.randomElement()
    }
    
    func opponentPlays() {
        let availableCards = game.trainerCards.filter { $0.isActivated }
        guard let randomCard = availableCards.randomElement() else { return }
        guard let cardIndex = game.trainerCards.firstIndex(of: randomCard) else { return }
        
        let userMatchingWeaknesses = userMatchingWeaknesses(with: randomCard)
        
        if let weaknessIndex = userMatchingWeaknesses.locations.randomElement() {
            rotatingCardAnimation(index: weaknessIndex)
            if let targetIndex = userMatchingWeaknesses.index {
                rotatingCardAnimation(index: targetIndex)
                opponentCardAction(actionIndex: weaknessIndex, cardIndex: cardIndex, targetIndex: targetIndex)
            }
        } else {
            if let location = randomLocation {
                rotatingCardAnimation(index: location)
                opponentCardAction(actionIndex: location, cardIndex: cardIndex, targetIndex: nil)
            }
        }
    }
}
