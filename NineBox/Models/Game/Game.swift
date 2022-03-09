//
//  Game.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 17/02/2022.
//

import SwiftUI

struct Game {
    var trainer: Trainer? = nil
    var trainerCards = [Card]()
    var deck: Deck? = nil
    var userCards = [Card]()
    var board = [Card]()
    var boardFrames = [CGRect](repeating: .zero, count: 16)
    var turn: Turn? = nil
    
    var userPoints: Int {
        let userCards = board.filter { $0.side == .user }
        return userCards.count
    }
    var opponentPoints: Int {
        let opponentCards = board.filter { $0.side == .opponent }
        return opponentCards.count
    }
    var boardIndices: [Int] {
        return board.indices.map { $0 }
    }
    var userCardsIndicesOnBoard: [Int] {
        return board.indices.filter { board[$0].side == .user }
    }
    
    var trainerCardsIndicesOnBoard: [Int] {
        return board.indices.filter { board[$0].side == .opponent }
    }
    
    func getAdjacentCardIndex(from index: Int) -> (top: Int?, trailing: Int?, bottom: Int?, leading: Int?) {
        let topIndex: Int? = !board.edgeLineIndices(.top, 4, 4).contains(index) ? index - 4 : nil
        let trailingIndex: Int? = !board.edgeLineIndices(.trailing, 4, 4).contains(index) ? index + 1 : nil
        let bottomIndex: Int? = !board.edgeLineIndices(.bottom, 4, 4).contains(index) ? index + 4 : nil
        let leadingIndex: Int? = !board.edgeLineIndices(.leading, 4, 4).contains(index) ? index - 1 : nil
        return (topIndex, trailingIndex, bottomIndex, leadingIndex)
    }
    
    var isGameWon: Bool { userPoints > opponentPoints }
    
    var isGameOver: Bool { board.allSatisfy { $0.category == .pokemon } }
}
