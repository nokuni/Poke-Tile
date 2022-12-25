//
//  GameAI.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 20/12/22.
//

import SwiftUI

class GameAI: GameAIDelegate {
    
    func compareCardsStats(firstCard: Card, secondCard: Card) -> ((top: Bool, location: Int), (trailing: Bool, location: Int), (bottom: Bool, location: Int), (leading: Bool, location: Int)) {
        
        guard let firstCardIndex = GameViewModel.shared.game.board.firstIndex(where: { $0.id == firstCard.id }) else { return ((top: false, location: -1), (trailing: false, location: -1), (bottom: false, location: -1), (leading: false, location: -1)) }
        
        let adjacentCardIndex = GameViewModel.shared.game.getAdjacentCardIndex(from: firstCardIndex)
        
        var result: ((top: Bool, location: Int), (trailing: Bool, location: Int), (bottom: Bool, location: Int), (leading: Bool, location: Int)) = ((top: false, location: -1), (trailing: false, location: -1), (bottom: false, location: -1), (leading: false, location: -1))
        
        
        if let topIndex = adjacentCardIndex.top {
            let buffedTop = secondCard.buffed(with: GameViewModel.shared.game.board[topIndex])
            result.0.top = buffedTop.stats.bottom > firstCard.stats.top
            result.0.location = topIndex
        }
        
        if let trailingIndex = adjacentCardIndex.trailing {
            let buffedTrailing = secondCard.buffed(with: GameViewModel.shared.game.board[trailingIndex])
            result.1.trailing = buffedTrailing.stats.leading > firstCard.stats.trailing
            result.1.location = trailingIndex
        }
        
        if let bottomIndex = adjacentCardIndex.bottom {
            let buffedBottom = secondCard.buffed(with: GameViewModel.shared.game.board[bottomIndex])
            result.2.bottom = buffedBottom.stats.top > firstCard.stats.bottom
            result.2.location = bottomIndex
        }
        
        if let leadingIndex = adjacentCardIndex.leading {
            let buffedLeading = secondCard.buffed(with: GameViewModel.shared.game.board[leadingIndex])
            result.3.leading = buffedLeading.stats.trailing > firstCard.stats.leading
            result.3.location = leadingIndex
        }
        
        return result
    }
    
    func convertingMatches(of firstCardIndex: Int, with secondCard: Card) -> [Int] {
        
        let cardsComparison = compareCardsStats(firstCard: GameViewModel.shared.game.board[firstCardIndex], secondCard: secondCard)
        
        var result = [Int]()
        
        if cardsComparison.0.top { result.append(cardsComparison.0.location) }
        if cardsComparison.1.trailing { result.append(cardsComparison.1.location) }
        if cardsComparison.2.bottom { result.append(cardsComparison.2.location) }
        if cardsComparison.3.leading { result.append(cardsComparison.3.location) }
        
        return result
    }
    
    func rotatingCardAnimation(index: Int, isRotatingCard: [Bool]) {
        withAnimation(.spring()) {
            GameViewModel.shared.isRotatingCard[index].toggle()
        }
    }
    
    func opponentCardAction(actionIndex: Int, cardIndex: Int, targetIndex: Int?) {
        
        print("Opponent card action")
        
        if let targetIndex = targetIndex {
            GameViewModel.shared.isRotatingCard[targetIndex].toggle()
        }
        
        GameViewModel.shared.isRotatingCard[actionIndex].toggle()
        
        withAnimation {
            GameViewModel.shared.cardGestureAction.buffTrainerCard(index: cardIndex, debuff: GameViewModel.shared.game.board[actionIndex])
            GameViewModel.shared.typeCardAction.trigger(of: cardIndex, on: actionIndex, card: GameViewModel.shared.game.trainerCards[cardIndex])
            GameViewModel.shared.game.board[actionIndex] = GameViewModel.shared.game.trainerCards[cardIndex]
            if let targetIndex = targetIndex {
                GameViewModel.shared.game.board[targetIndex].side = .opponent
            }
            GameViewModel.shared.game.trainerCards[cardIndex].isActivated = false
            GameViewModel.shared.cardConversion.endOfTurnConvertAdjacents()
        }
        
        GameViewModel.shared.animation.start(duration: 1, startAction: nil, whileAction: nil) {
            if !GameViewModel.shared.game.isGameOver {
                GameViewModel.shared.game.turn = .user
                GameViewModel.shared.isShowingTurnAnimation.toggle()
            } else {
                GameViewModel.shared.isShowingGameEnding.toggle()
            }
        }
        
    }
    
    func userMatchingWeaknesses(with card: Card) -> (locations: [Int], index: Int?) {
        var weaknessLocations = [Int]()
        var userCardIndex: Int? = nil
        let userCardsSortedByCostIndices = GameViewModel.shared.game.userCardsIndicesOnBoard.sorted(by: { GameViewModel.shared.game.board[$0].cost > GameViewModel.shared.game.board[$1].cost })
        for index in userCardsSortedByCostIndices {
            let indices = convertingMatches(of: index, with: card).filter { GameViewModel.shared.game.board[$0].category != .pokemon }
            if !indices.isEmpty {
                weaknessLocations = indices
                userCardIndex = index
                break
            }
        }
        return (weaknessLocations, userCardIndex)
    }
    
    func getBestLocation(with card: Card) -> Int? {
        let availableLocations = GameViewModel.shared.game.boardIndices.filter { GameViewModel.shared.game.board[$0].category != .pokemon }
        let debuffLocations = availableLocations.filter { GameViewModel.shared.game.board[$0].debuffs.contains(card.type.rawValue) }
        let bestLocationsForCard = debuffLocations.sorted(by: { GameViewModel.shared.game.board[$0].debuffs.count > GameViewModel.shared.game.board[$1].debuffs.count })
        if bestLocationsForCard.isEmpty {
            return availableLocations.randomElement()
        } else {
            return bestLocationsForCard.first
        }
    }
    
    func opponentPlays() {
        let availableCards = GameViewModel.shared.game.trainerCards.filter { $0.isActivated }
        let sortedAvailableCards = availableCards.sorted(by: { $0.cost < $1.cost })
        
        guard let firstPlayableCard =  sortedAvailableCards.first else { return }
        guard let firstPlayableCardIndex = GameViewModel.shared.game.trainerCards.firstIndex(of: firstPlayableCard) else { return }
        
        if let chosenCard = sortedAvailableCards.first(where: { userMatchingWeaknesses(with: $0).index != nil && !userMatchingWeaknesses(with: $0).locations.isEmpty }),
           let cardIndex = GameViewModel.shared.game.trainerCards.firstIndex(of: chosenCard) {
            let matchingWeaknesses = userMatchingWeaknesses(with: chosenCard)
            if let weaknessIndex = matchingWeaknesses.locations.randomElement() {
                rotatingCardAnimation(index: weaknessIndex, isRotatingCard: GameViewModel.shared.isRotatingCard)
                if let targetIndex = matchingWeaknesses.index {
                    rotatingCardAnimation(index: targetIndex, isRotatingCard: GameViewModel.shared.isRotatingCard)
                    opponentCardAction(actionIndex: weaknessIndex, cardIndex: cardIndex, targetIndex: targetIndex)
                }
            }
        } else {
            print("No target")
            if let location = getBestLocation(with: firstPlayableCard) {
                rotatingCardAnimation(index: location, isRotatingCard: GameViewModel.shared.isRotatingCard)
                opponentCardAction(actionIndex: location, cardIndex: firstPlayableCardIndex, targetIndex: nil)
            }
        }
    }
}
