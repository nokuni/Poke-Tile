//
//  GameViewModel.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 17/02/2022.
//

import SwiftUI

class GameViewModel: ObservableObject {
    @Published var user = User(profile: Profile(name: "Nokuni", image: "blaine"))
    @Published var game = Game()
    
    @Published var isShowingTurnAnimation = false
    @Published var isShowingCard = [Bool](repeating: false, count: 16)
    @Published var isShowingHand = [Bool](repeating: false, count: 8)
    
    static var shared = GameViewModel()
    
    init() {
        //createNewGame(trainer: game.trainer)
    }
    
    func createNewGame(trainer: Trainer) {
        game.trainer = trainer
        loadBoard(bonus: addDebuffs)
        loadPlayerHand()
        loadOpponentHand()
        print("Game created")
    }
    
    func cardDropped(location: CGPoint, index: Int, card: Card) {
        if let match = game.boardFrames.firstIndex(where: { $0.contains(location) }) {
            dropCard(match: match, index: index, card: card, turn: .opponent)
            print("User drop card")
        }
    }
    
    func endTurn(toStart turn: Turn) {
        game.turn = turn
        isShowingTurnAnimation.toggle()
        if game.isGameOver() {
            
        }
    }
    
    func cardAction(match: Int, index: Int, buff: ((Int, Card) -> Void)?) {
        guard let deck = game.deck else { return }
        buff?(index, game.board[match])
        game.board[match] = deck.cards[index]
        game.deck?.cards[index].isActivated = false
        endTurn(toStart: .opponent)
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
        game.deck?.cards[index].stats.top += buffAmount
        game.deck?.cards[index].stats.trailing += buffAmount
        game.deck?.cards[index].stats.bottom += buffAmount
        game.deck?.cards[index].stats.leading += buffAmount
        print("\(deck.cards[index].name) got buffed")
    }
    
    func buffTrainerCard(index: Int, debuff: Card) {
        guard let debuffAmount = debuff.debuffAmount else { return }
        let buffAmount = game.trainerCards[index].type == debuff.type ? debuffAmount : -debuffAmount
        game.trainerCards[index].stats.top += buffAmount
        game.trainerCards[index].stats.trailing += buffAmount
        game.trainerCards[index].stats.bottom += buffAmount
        game.trainerCards[index].stats.leading += buffAmount
        print("\(game.trainerCards[index].name) got buffed")
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
    
    // TEMPORARY
    func loadPlayerHand() {
        game.deck?.cards.indices.forEach { game.deck?.cards[$0].side = .user }
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
    
    func isDeckReady(index: Int) -> Bool {
        user.decks[index].cards.allSatisfy({ $0.category == .pokemon })
    }
    
    // MARK: - OPPONENT AI
    
    // Problem with AI ignoring buffs on user cards on board
    // Problem with AI replacing pokemon cards directly.
    
    
    func compareCardsStats(userCard: Card, opponentCard: Card) -> ((top: Bool, location: Int), (trailing: Bool, location: Int), (bottom: Bool, location: Int), (leading: Bool, location: Int)) {
        guard let firstCardIndex = game.board.firstIndex(where: { $0.id == userCard.id }) else { return ((top: false, location: -1), (trailing: false, location: -1), (bottom: false, location: -1), (leading: false, location: -1)) }
        
        let adjacentCardIndex = game.getAdjacentCardIndex(from: firstCardIndex)
        
        var result: ((top: Bool, location: Int), (trailing: Bool, location: Int), (bottom: Bool, location: Int), (leading: Bool, location: Int)) = ((top: false, location: -1), (trailing: false, location: -1), (bottom: false, location: -1), (leading: false, location: -1))
        
    
        if let topIndex = adjacentCardIndex.top {
            let buffedTop = buffedCard(card: opponentCard, debuff: game.board[topIndex])
            result.0.top = buffedTop.stats.bottom > userCard.stats.top
            result.0.location = topIndex
        }
        
        if let trailingIndex = adjacentCardIndex.trailing {
            let buffedTrailing = buffedCard(card: opponentCard, debuff: game.board[trailingIndex])
            result.1.trailing = buffedTrailing.stats.leading > userCard.stats.trailing
            result.1.location = trailingIndex
        }
        
        if let bottomIndex = adjacentCardIndex.bottom {
            let buffedBottom = buffedCard(card: opponentCard, debuff: game.board[bottomIndex])
            result.2.bottom = buffedBottom.stats.top > userCard.stats.bottom
            result.2.location = bottomIndex
        }
        
        if let leadingIndex = adjacentCardIndex.leading {
            let buffedLeading = buffedCard(card: opponentCard, debuff: game.board[leadingIndex])
            result.3.leading = buffedLeading.stats.trailing > userCard.stats.leading
            result.3.location = leadingIndex
        }
        
        return result
    }

    func convertingMatches(of userCardIndex: Int, with opponentCard: Card) -> [Int] {
        let cardsComparison = compareCardsStats(userCard: game.board[userCardIndex], opponentCard: opponentCard)
        
        var result = [Int]()
        
        if cardsComparison.0.top { result.append(cardsComparison.0.location) }
        if cardsComparison.1.trailing { result.append(cardsComparison.1.location) }
        if cardsComparison.2.bottom { result.append(cardsComparison.2.location) }
        if cardsComparison.3.leading { result.append(cardsComparison.3.location) }
        
        return result
    }
    
    func rotatingCardAnimation(index: Int) {
        withAnimation(.linear.repeatCount(2, autoreverses: false)) {
            isShowingCard[index].toggle()
        }
    }
    
    func opponentCardAction(actionIndex: Int, cardIndex: Int, targetIndex: Int?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let targetIndex = targetIndex {
                self.isShowingCard[targetIndex].toggle()
            }
            self.isShowingCard[actionIndex].toggle()
            withAnimation {
                self.buffTrainerCard(index: cardIndex, debuff: self.game.board[actionIndex])
                //self.buffCard(from: &self.game.trainer.cards, index: cardIndex, debuff: self.game.board[actionIndex])
                self.game.board[actionIndex] = self.game.trainerCards[cardIndex]
                if let targetIndex = targetIndex {
                    self.game.board[targetIndex].side = .opponent
                }
                self.game.trainerCards[cardIndex].isActivated = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    self.endTurn(toStart: .user)
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
        print("Weakness Location: \(weaknessLocations) \n user target index: \(userCardIndex ?? -1)")
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
                print("Got a target")
                rotatingCardAnimation(index: targetIndex)
                opponentCardAction(actionIndex: weaknessIndex, cardIndex: cardIndex, targetIndex: targetIndex)
            }
        } else {
            if let location = randomLocation {
                print("No Target")
                rotatingCardAnimation(index: location)
                opponentCardAction(actionIndex: location, cardIndex: cardIndex, targetIndex: nil)
            }
        }
    }
}
