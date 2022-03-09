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

class GameViewModel: ObservableObject, Powers {
    @Published var game = Game()
    
    @Published var isShowingTurnAnimation = false
    @Published var isShowingGameEnding = false
    @Published var isRotatingCard = [Bool](repeating: false, count: 16)
    
    static let shared = GameViewModel()
    
    init() { }
    
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
    
    // Apply the type action of a card
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
            ()
        }
    }
    
    func normalAction(of index: Int, on match: Int, card: Card) {
        guard card.type == .normal else { return }
        if game.board[match].isAvailable {
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
    func grassAction(edgeIndex: Int, card: Card) {
        guard card.type == .grass else { return }
        var grassDebuff = try! Card.getDebuff(type: .grass)
        grassDebuff.debuffs.append("grass")
        if game.board[edgeIndex].isAvailable {
            withAnimation { game.board[edgeIndex] = grassDebuff }
        } else if game.board[edgeIndex].isDebuff && game.board[edgeIndex].type == .grass {
            if game.board[edgeIndex].debuffs.count < 4 {
                withAnimation { game.board[edgeIndex].debuffs.append("grass") }
            }
        }
    }
    func fireAction(edgeIndex: Int, card: Card) {
        guard card.type == .fire else { return }
        if game.board[edgeIndex].isDebuff && game.board[edgeIndex].type != .fire {
            game.board[edgeIndex] = Card.empty
        }
    }
    
    func actionOnAdjacents(on match: Int, card: Card) {
        let adjacentIndex = game.getAdjacentCardIndex(from: match)
        
        if let topIndex = adjacentIndex.top {
            grassAction(edgeIndex: topIndex, card: card)
            fireAction(edgeIndex: topIndex, card: card)
        }
        if let trailingIndex = adjacentIndex.trailing {
            grassAction(edgeIndex: trailingIndex, card: card)
            fireAction(edgeIndex: trailingIndex, card: card)
        }
        if let bottomIndex = adjacentIndex.bottom {
            grassAction(edgeIndex: bottomIndex, card: card)
            fireAction(edgeIndex: bottomIndex, card: card)
        }
        if let leadingIndex = adjacentIndex.leading {
            grassAction(edgeIndex: leadingIndex, card: card)
            fireAction(edgeIndex: leadingIndex, card: card)
        }
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
        if !self.game.isGameOver { game.turn = turn }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if !self.game.isGameOver {
                self.isShowingTurnAnimation.toggle()
            } else {
                
                self.isShowingGameEnding.toggle()
            }
        }
    }
    
    func convertAdjacents(from match: Int, with cardIndex: Int) {
        let adjacentIndex = game.getAdjacentCardIndex(from: match)
        
        if let topIndex = adjacentIndex.top {
            if game.userCards[cardIndex].stats.top > game.board[topIndex].stats.bottom {
                if game.board[topIndex].isPokemon && !game.board[topIndex].isUserSide {
                    rotatingCardAnimation(index: topIndex)
                    game.board[topIndex].side = .user
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isRotatingCard[topIndex].toggle()
                    }
                }
            }
        }
        
        if let trailingIndex = adjacentIndex.trailing {
            if game.userCards[cardIndex].stats.trailing > game.board[trailingIndex].stats.leading {
                if game.board[trailingIndex].isPokemon && !game.board[trailingIndex].isUserSide {
                    rotatingCardAnimation(index: trailingIndex)
                    game.board[trailingIndex].side = .user
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isRotatingCard[trailingIndex].toggle()
                    }
                }
            }
        }
        
        if let bottomIndex = adjacentIndex.bottom {
            if game.userCards[cardIndex].stats.bottom > game.board[bottomIndex].stats.top {
                if game.board[bottomIndex].isPokemon && !game.board[bottomIndex].isUserSide {
                    rotatingCardAnimation(index: bottomIndex)
                    game.board[bottomIndex].side = .user
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isRotatingCard[bottomIndex].toggle()
                    }
                }
            }
        }
        
        if let leadingIndex = adjacentIndex.leading {
            if game.userCards[cardIndex].stats.leading > game.board[leadingIndex].stats.trailing {
                if game.board[leadingIndex].isPokemon && !game.board[leadingIndex].isUserSide {
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
        let count = debuff.debuffs.count
        let buffAmount = game.userCards[index].type == debuff.type ? count : -count
        game.userCards[index].stats.top += buffAmount
        game.userCards[index].stats.trailing += buffAmount
        game.userCards[index].stats.bottom += buffAmount
        game.userCards[index].stats.leading += buffAmount
    }
    
    func buffTrainerCard(index: Int, debuff: Card) {
        let count = debuff.debuffs.count
        let buffAmount = game.trainerCards[index].type == debuff.type ? count : -count
        game.trainerCards[index].stats.top += buffAmount
        game.trainerCards[index].stats.trailing += buffAmount
        game.trainerCards[index].stats.bottom += buffAmount
        game.trainerCards[index].stats.leading += buffAmount
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
    
    // Futur changes of making it not random
    func addDebuffs(trainer: Trainer?) {
        guard let trainer = trainer else { return }
        let types = Set(trainer.cards.map { $0.type })
        let randomIndices = game.boardIndices.differentRandomElements(amount: trainer.bonusAmount)
        for index in randomIndices {
            guard let randomType = types.randomElement() else { return }
            let randomCard = try! Card.getDebuff(type: randomType)
            game.board[index] = randomCard
            let randomNumber = Int.random(in: 1...3)
            for _ in 0..<randomNumber {
                game.board[index].debuffs.append(randomType.rawValue)
            }
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
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        if !self.game.isGameOver {
                            self.game.turn = .user
                            self.isShowingTurnAnimation.toggle()
                        } else {
                            if self.game.isGameWon {
                                if let trainer = self.game.trainer {
                                    UserViewModel.shared.user.boosters.append(trainer.booster)
                                }
                            }
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

protocol Powers {
    func normalAction(of index: Int, on match: Int, card: Card)
    func grassAction(edgeIndex: Int, card: Card)
    func fireAction(edgeIndex: Int, card: Card)
}
