//
//  TypeCardAction.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 20/12/22.
//

import SwiftUI

class TypeCardAction {
    
    func normal(of index: Int, on match: Int, card: Card) {
        guard card.type == .normal else { return }
        GameViewModel.shared.cardConversion.buffOnEmptyCard(of: index, on: match, card: card)
    }
    
    func grass(edgeIndex: Int, on match: Int, card: Card) {
        guard card.type == .grass else { return }
        let grassDebuff = try! Card.getDebuff(type: .grass)
        GameViewModel.shared.legendaryCardAction.grass(name: card.name, edgeIndex: edgeIndex, match: match)
        if GameViewModel.shared.game.board[edgeIndex].isAvailable {
            withAnimation { GameViewModel.shared.game.board[edgeIndex] = grassDebuff }
        } else if GameViewModel.shared.game.board[edgeIndex].isDebuff && GameViewModel.shared.game.board[edgeIndex].type == .grass {
            if GameViewModel.shared.game.board[edgeIndex].debuffs.count < 4 {
                withAnimation { GameViewModel.shared.game.board[edgeIndex].debuffs.append("grass") }
            }
        }
    }
    
    func fire(edgeIndex: Int, on match: Int, card: Card) {
        guard card.type == .fire else { return }
        let fireDebuff = try! Card.getDebuff(type: .fire)
        GameViewModel.shared.legendaryCardAction.fire(name: card.name, edgeIndex: edgeIndex, match: match)
        if GameViewModel.shared.game.board[edgeIndex].isDebuff && GameViewModel.shared.game.board[edgeIndex].type != .fire {
            GameViewModel.shared.game.board[edgeIndex] = fireDebuff
        }
    }
    
    func water(edgeIndex: Int, on match: Int, card: Card) {
        guard card.type == .water else { return }
        GameViewModel.shared.legendaryCardAction.water(name: card.name, edgeIndex: edgeIndex, match: match, card: card)
        GameViewModel.shared.cardConversion.resetCardStats(index: edgeIndex, on: match, card: card)
    }
    
    func fighting(edgeIndex: Int, with cardIndex: Int) {
        if GameViewModel.shared.game.userCards[cardIndex].type == .fighting {
            GameViewModel.shared.game.board[edgeIndex].stats.top += 1
            GameViewModel.shared.game.board[edgeIndex].stats.trailing += 1
            GameViewModel.shared.game.board[edgeIndex].stats.bottom += 1
            GameViewModel.shared.game.board[edgeIndex].stats.leading += 1
        }
    }
    
    func fightingForOpponent(edgeIndex: Int, with cardIndex: Int) {
        if GameViewModel.shared.game.trainerCards[cardIndex].type == .fighting {
            GameViewModel.shared.game.board[edgeIndex].stats.top += 1
            GameViewModel.shared.game.board[edgeIndex].stats.trailing += 1
            GameViewModel.shared.game.board[edgeIndex].stats.bottom += 1
            GameViewModel.shared.game.board[edgeIndex].stats.leading += 1
        }
    }
    
    func trigger(of index: Int, on match: Int, card: Card) {
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
            GameViewModel.shared.cardConversion.actionOnAdjacents(on: match, card: card)
        case .flying:
            ()
        case .ghost:
            ()
        case .grass:
            GameViewModel.shared.cardConversion.actionOnAdjacents(on: match, card: card)
        case .ground:
            ()
        case .ice:
            ()
        case .normal:
            normal(of: index, on: match, card: card)
        case .poison:
            ()
        case .psychic:
            ()
        case .rock:
            ()
        case .steel:
            ()
        case .water:
            GameViewModel.shared.cardConversion.actionOnAdjacents(on: match, card: card)
        }
    }
}
