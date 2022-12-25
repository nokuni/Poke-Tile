//
//  LegendaryCardAction.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 20/12/22.
//

import SwiftUI

class LegendaryCardAction {
    func grass(name: String, edgeIndex: Int, match: Int) {
        var grassDebuff = try! Card.getDebuff(type: .grass)
        
        switch name {
        case "Venusaur":
            GameViewModel.shared.cardConversion.fillBoard(with: grassDebuff)
        case "Vileplume":
            GameViewModel.shared.cardConversion.fillLines(with: grassDebuff, on: match)
        case "Torterra":
            grassDebuff.debuffs = Array(repeating: "grass", count: 2)
            if GameViewModel.shared.game.board[edgeIndex].isAvailable {
                withAnimation { GameViewModel.shared.game.board[edgeIndex] = grassDebuff }
            }
        case "Serperior":
            GameViewModel.shared.cardConversion.convertAll(debuff: grassDebuff)
        case "Tsareena":
            ()
        case "Appletun":
            ()
        default: ()
        }
    }
    func fire(name: String, edgeIndex: Int, match: Int) {
        let fireDebuff = try! Card.getDebuff(type: .fire)
        switch name {
        case "Charizard":
            for index in GameViewModel.shared.game.boardIndices {
                if GameViewModel.shared.game.board[index].isDebuff && GameViewModel.shared.game.board[index].type != .fire {
                    GameViewModel.shared.game.board[index] = fireDebuff
                }
            }
        default: ()
        }
    }
    func water(name: String, edgeIndex: Int, match: Int, card: Card) {
        switch name {
        case "Blastoise":
            for index in GameViewModel.shared.game.boardIndices { GameViewModel.shared.cardConversion.resetCardStats(index: index, on: match, card: card) }
        default: ()
        }
    }
}
