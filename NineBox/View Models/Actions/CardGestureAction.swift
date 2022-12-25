//
//  CardGestureAction.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 20/12/22.
//

import SwiftUI

class CardGestureAction {
    
    func cardAction(match: Int, index: Int, buff: ((Int, Card) -> Void)?) {
        buff?(index, GameViewModel.shared.game.board[match])
        GameViewModel.shared.typeCardAction.trigger(of: index, on: match, card: GameViewModel.shared.game.userCards[index])
        GameViewModel.shared.cardConversion.convertAdjacents(from: match, with: index)
        GameViewModel.shared.game.board[match] = GameViewModel.shared.game.userCards[index]
        GameViewModel.shared.game.userCards[index].isActivated = false
        GameViewModel.shared.game.turn = .opponent
        GameViewModel.shared.animation.start(duration: 1, startAction: nil, whileAction: nil) {
            if !GameViewModel.shared.game.isGameOver {
                GameViewModel.shared.isShowingTurnAnimation.toggle()
            } else {
                GameViewModel.shared.isShowingGameEnding.toggle()
            }
        }
    }
    
    func dropCard(match: Int, index: Int, card: Card, turn: Turn) {
        switch GameViewModel.shared.game.board[match].category {
        case .pokemon: return
        case .debuff:
            cardAction(match: match, index: index, buff: buffUserCard)
        case .empty:
            cardAction(match: match, index: index, buff: nil)
        }
    }
    func cardDropped(location: CGPoint, index: Int, card: Card) {
        if let match = GameViewModel.shared.game.boardFrames.firstIndex(where: { $0.contains(location) }) {
            dropCard(match: match, index: index, card: card, turn: .opponent)
        }
    }
    
    func buffUserCard(index: Int, debuff: Card) {
        let count = debuff.debuffs.count
        let buffAmount = GameViewModel.shared.game.userCards[index].type == debuff.type ? count : -count
        let invertedBuffAmount = GameViewModel.shared.game.userCards[index].type != debuff.type ? count : -count
        if GameViewModel.shared.game.userCards[index].type == .ghost {
            GameViewModel.shared.game.userCards[index].stats.top += invertedBuffAmount
            GameViewModel.shared.game.userCards[index].stats.trailing += invertedBuffAmount
            GameViewModel.shared.game.userCards[index].stats.bottom += invertedBuffAmount
            GameViewModel.shared.game.userCards[index].stats.leading += invertedBuffAmount
        } else {
            GameViewModel.shared.game.userCards[index].stats.top += buffAmount
            GameViewModel.shared.game.userCards[index].stats.trailing += buffAmount
            GameViewModel.shared.game.userCards[index].stats.bottom += buffAmount
            GameViewModel.shared.game.userCards[index].stats.leading += buffAmount
        }
    }
    
    func buffTrainerCard(index: Int, debuff: Card) {
        let count = debuff.debuffs.count
        let buffAmount = GameViewModel.shared.game.trainerCards[index].type == debuff.type ? count : -count
        GameViewModel.shared.game.trainerCards[index].stats.top += buffAmount
        GameViewModel.shared.game.trainerCards[index].stats.trailing += buffAmount
        GameViewModel.shared.game.trainerCards[index].stats.bottom += buffAmount
        GameViewModel.shared.game.trainerCards[index].stats.leading += buffAmount
    }
}
