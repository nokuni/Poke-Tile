//
//  CardConversion.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 20/12/22.
//

import SwiftUI

class CardConversion: ObservableObject {
    
    func fillBoard(with debuff: Card) {
        for index in GameViewModel.shared.game.boardIndices {
            if GameViewModel.shared.game.board[index].isAvailable {
                withAnimation { GameViewModel.shared.game.board[index] = debuff }
            }
        }
    }
    
    func fillLines(with debuff: Card, on match: Int) {
        let debuffLocations = Array(GameViewModel.shared.game.board.indices).getAdjacentLinesIndices(from: match)
        for location in debuffLocations {
            if GameViewModel.shared.game.board[location].isAvailable {
                withAnimation { GameViewModel.shared.game.board[location] = debuff }
            }
        }
    }
    
    func resetCardStats(index: Int, on match: Int, card: Card) {
        guard let dataIndex = Card.pokemons.firstIndex(where: { $0.name == GameViewModel.shared.game.board[index].name }) else { return }
        
        if card.side == .user {
            if GameViewModel.shared.game.board[index].isPokemon && GameViewModel.shared.game.board[index].side == .user {
                if GameViewModel.shared.game.board[index].stats.top < 0 { GameViewModel.shared.game.board[index].stats.top = abs(GameViewModel.shared.game.board[index].stats.top) }
                if GameViewModel.shared.game.board[index].stats.trailing < 0 { GameViewModel.shared.game.board[index].stats.trailing = abs(GameViewModel.shared.game.board[index].stats.trailing) }
                if GameViewModel.shared.game.board[index].stats.bottom < 0 { GameViewModel.shared.game.board[index].stats.bottom = abs(GameViewModel.shared.game.board[index].stats.bottom) }
                if GameViewModel.shared.game.board[index].stats.leading < 0 { GameViewModel.shared.game.board[index].stats.leading = abs(GameViewModel.shared.game.board[index].stats.leading) }
            }
            if GameViewModel.shared.game.board[index].isPokemon && GameViewModel.shared.game.board[index].side == .opponent {
                if GameViewModel.shared.game.board[index].stats.top > Card.pokemons[dataIndex].stats.top { GameViewModel.shared.game.board[index].stats.top = Card.pokemons[dataIndex].stats.top }
                if GameViewModel.shared.game.board[index].stats.trailing > Card.pokemons[dataIndex].stats.trailing { GameViewModel.shared.game.board[index].stats.trailing = Card.pokemons[dataIndex].stats.trailing }
                if GameViewModel.shared.game.board[index].stats.bottom > Card.pokemons[dataIndex].stats.bottom { GameViewModel.shared.game.board[index].stats.bottom = Card.pokemons[dataIndex].stats.bottom }
                if GameViewModel.shared.game.board[index].stats.leading > Card.pokemons[dataIndex].stats.leading { GameViewModel.shared.game.board[index].stats.leading = Card.pokemons[dataIndex].stats.leading }
            }
        }
        if card.side == .opponent {
            if GameViewModel.shared.game.board[index].isPokemon && GameViewModel.shared.game.board[index].side == .opponent {
                if GameViewModel.shared.game.board[index].stats.top < 0 { GameViewModel.shared.game.board[index].stats.top = abs(GameViewModel.shared.game.board[index].stats.top) }
                if GameViewModel.shared.game.board[index].stats.trailing < 0 { GameViewModel.shared.game.board[index].stats.trailing = abs(GameViewModel.shared.game.board[index].stats.trailing) }
                if GameViewModel.shared.game.board[index].stats.bottom < 0 { GameViewModel.shared.game.board[index].stats.bottom = abs(GameViewModel.shared.game.board[index].stats.bottom) }
                if GameViewModel.shared.game.board[index].stats.leading < 0 { GameViewModel.shared.game.board[index].stats.leading = abs(GameViewModel.shared.game.board[index].stats.leading) }
            }
            if GameViewModel.shared.game.board[index].isPokemon && GameViewModel.shared.game.board[index].side == .user {
                if GameViewModel.shared.game.board[index].stats.top > Card.pokemons[dataIndex].stats.top { GameViewModel.shared.game.board[index].stats.top = Card.pokemons[dataIndex].stats.top }
                if GameViewModel.shared.game.board[index].stats.trailing > Card.pokemons[dataIndex].stats.trailing { GameViewModel.shared.game.board[index].stats.trailing = Card.pokemons[dataIndex].stats.trailing }
                if GameViewModel.shared.game.board[index].stats.bottom > Card.pokemons[dataIndex].stats.bottom { GameViewModel.shared.game.board[index].stats.bottom = Card.pokemons[dataIndex].stats.bottom }
                if GameViewModel.shared.game.board[index].stats.leading > Card.pokemons[dataIndex].stats.leading { GameViewModel.shared.game.board[index].stats.leading = Card.pokemons[dataIndex].stats.leading }
            }
        }
    }
    
    func buffOnEmptyCard(of index: Int, on match: Int, card: Card) {
        let isEmptyDebuff = GameViewModel.shared.game.board[match].isDebuff && GameViewModel.shared.game.board[match].debuffs.isEmpty
        if GameViewModel.shared.game.board[match].isAvailable || isEmptyDebuff {
            if card.side == .user {
                GameViewModel.shared.game.userCards[index].stats.top += 1
                GameViewModel.shared.game.userCards[index].stats.trailing += 1
                GameViewModel.shared.game.userCards[index].stats.bottom += 1
                GameViewModel.shared.game.userCards[index].stats.leading += 1
            } else if card.side == .opponent {
                GameViewModel.shared.game.trainerCards[index].stats.top += 1
                GameViewModel.shared.game.trainerCards[index].stats.trailing += 1
                GameViewModel.shared.game.trainerCards[index].stats.bottom += 1
                GameViewModel.shared.game.trainerCards[index].stats.leading += 1
            }
        }
    }
    
    func convertAll(debuff: Card) {
        for index in GameViewModel.shared.game.boardIndices {
            if GameViewModel.shared.game.board[index].isDebuff {
                GameViewModel.shared.game.board[index] = debuff
            }
        }
    }
    
    func actionOnAdjacents(on match: Int, card: Card) {
        let adjacentIndex = GameViewModel.shared.game.getAdjacentCardIndex(from: match)
        
        if let topIndex = adjacentIndex.top {
            GameViewModel.shared.typeCardAction.grass(edgeIndex: topIndex, on: match, card: card)
            GameViewModel.shared.typeCardAction.fire(edgeIndex: topIndex, on: match, card: card)
            GameViewModel.shared.typeCardAction.water(edgeIndex: topIndex, on: match, card: card)
        }
        if let trailingIndex = adjacentIndex.trailing {
            GameViewModel.shared.typeCardAction.grass(edgeIndex: trailingIndex, on: match, card: card)
            GameViewModel.shared.typeCardAction.fire(edgeIndex: trailingIndex, on: match, card: card)
            GameViewModel.shared.typeCardAction.water(edgeIndex: trailingIndex, on: match, card: card)
        }
        if let bottomIndex = adjacentIndex.bottom {
            GameViewModel.shared.typeCardAction.grass(edgeIndex: bottomIndex, on: match, card: card)
            GameViewModel.shared.typeCardAction.fire(edgeIndex: bottomIndex, on: match, card: card)
            GameViewModel.shared.typeCardAction.water(edgeIndex: bottomIndex, on: match, card: card)
        }
        if let leadingIndex = adjacentIndex.leading {
            GameViewModel.shared.typeCardAction.grass(edgeIndex: leadingIndex, on: match, card: card)
            GameViewModel.shared.typeCardAction.fire(edgeIndex: leadingIndex, on: match, card: card)
            GameViewModel.shared.typeCardAction.water(edgeIndex: leadingIndex, on: match, card: card)
        }
    }
    
    func convertAdjacents(from match: Int, with cardIndex: Int) {
        let adjacentIndex = GameViewModel.shared.game.getAdjacentCardIndex(from: match)
        
        if let topIndex = adjacentIndex.top {
            if GameViewModel.shared.game.userCards[cardIndex].stats.top > GameViewModel.shared.game.board[topIndex].stats.bottom {
                if GameViewModel.shared.game.board[topIndex].isPokemon && !GameViewModel.shared.game.board[topIndex].isUserSide {
                    simpleSuccess()
                    GameViewModel.shared.gameAI.rotatingCardAnimation(index: topIndex, isRotatingCard: GameViewModel.shared.isRotatingCard)
                    GameViewModel.shared.game.board[topIndex].side = .user
                    GameViewModel.shared.typeCardAction.fighting(edgeIndex: topIndex, with: cardIndex)
                    //GameViewModel.shared.animation.start(duration: 1, startAction: nil, whileAction: nil) {
                        GameViewModel.shared.isRotatingCard[topIndex].toggle()
                    //}
                }
            }
        }
        
        if let trailingIndex = adjacentIndex.trailing {
            if GameViewModel.shared.game.userCards[cardIndex].stats.trailing > GameViewModel.shared.game.board[trailingIndex].stats.leading {
                if GameViewModel.shared.game.board[trailingIndex].isPokemon && !GameViewModel.shared.game.board[trailingIndex].isUserSide {
                    simpleSuccess()
                    GameViewModel.shared.gameAI.rotatingCardAnimation(index: trailingIndex, isRotatingCard: GameViewModel.shared.isRotatingCard)
                    GameViewModel.shared.game.board[trailingIndex].side = .user
                    GameViewModel.shared.typeCardAction.fighting(edgeIndex: trailingIndex, with: cardIndex)
                    //GameViewModel.shared.animation.start(duration: 1, startAction: nil, whileAction: nil) {
                        GameViewModel.shared.isRotatingCard[trailingIndex].toggle()
                    //}
                }
            }
        }
        
        if let bottomIndex = adjacentIndex.bottom {
            if GameViewModel.shared.game.userCards[cardIndex].stats.bottom > GameViewModel.shared.game.board[bottomIndex].stats.top {
                if GameViewModel.shared.game.board[bottomIndex].isPokemon && !GameViewModel.shared.game.board[bottomIndex].isUserSide {
                    simpleSuccess()
                    GameViewModel.shared.gameAI.rotatingCardAnimation(index: bottomIndex, isRotatingCard: GameViewModel.shared.isRotatingCard)
                    GameViewModel.shared.game.board[bottomIndex].side = .user
                    GameViewModel.shared.typeCardAction.fighting(edgeIndex: bottomIndex, with: cardIndex)
                    //GameViewModel.shared.animation.start(duration: 1, startAction: nil, whileAction: nil) {
                        GameViewModel.shared.isRotatingCard[bottomIndex].toggle()
                    //}
                }
            }
        }
        
        if let leadingIndex = adjacentIndex.leading {
            if GameViewModel.shared.game.userCards[cardIndex].stats.leading > GameViewModel.shared.game.board[leadingIndex].stats.trailing {
                if GameViewModel.shared.game.board[leadingIndex].isPokemon && !GameViewModel.shared.game.board[leadingIndex].isUserSide {
                    simpleSuccess()
                    GameViewModel.shared.gameAI.rotatingCardAnimation(index: leadingIndex, isRotatingCard: GameViewModel.shared.isRotatingCard)
                    GameViewModel.shared.game.board[leadingIndex].side = .user
                    GameViewModel.shared.typeCardAction.fighting(edgeIndex: leadingIndex, with: cardIndex)
                    //GameViewModel.shared.animation.start(duration: 1, startAction: nil, whileAction: nil) {
                        GameViewModel.shared.isRotatingCard[leadingIndex].toggle()
                    //}
                }
            }
        }
    }
    
    func convertAdjacentsForOpponent(from match: Int, with cardIndex: Int) {
        let adjacentIndex = GameViewModel.shared.game.getAdjacentCardIndex(from: match)
        
        if let topIndex = adjacentIndex.top {
            if GameViewModel.shared.game.trainerCards[cardIndex].stats.top > GameViewModel.shared.game.board[topIndex].stats.bottom {
                if GameViewModel.shared.game.board[topIndex].isPokemon && GameViewModel.shared.game.board[topIndex].isUserSide {
                    GameViewModel.shared.gameAI.rotatingCardAnimation(index: topIndex, isRotatingCard: GameViewModel.shared.isRotatingCard)
                    GameViewModel.shared.game.board[topIndex].side = .opponent
                    GameViewModel.shared.typeCardAction.fightingForOpponent(edgeIndex: topIndex, with: cardIndex)
                    GameViewModel.shared.animation.start(duration: 0.1, startAction: nil, whileAction: nil) {
                        GameViewModel.shared.isRotatingCard[topIndex].toggle()
                    }
                }
            }
        }
        
        if let trailingIndex = adjacentIndex.trailing {
            if GameViewModel.shared.game.trainerCards[cardIndex].stats.trailing > GameViewModel.shared.game.board[trailingIndex].stats.leading {
                if GameViewModel.shared.game.board[trailingIndex].isPokemon && GameViewModel.shared.game.board[trailingIndex].isUserSide {
                    GameViewModel.shared.gameAI.rotatingCardAnimation(index: trailingIndex, isRotatingCard: GameViewModel.shared.isRotatingCard)
                    GameViewModel.shared.game.board[trailingIndex].side = .opponent
                    GameViewModel.shared.typeCardAction.fightingForOpponent(edgeIndex: trailingIndex, with: cardIndex)
                    GameViewModel.shared.animation.start(duration: 0.1, startAction: nil, whileAction: nil) {
                        GameViewModel.shared.isRotatingCard[trailingIndex].toggle()
                    }
                }
            }
        }
        
        if let bottomIndex = adjacentIndex.bottom {
            if GameViewModel.shared.game.trainerCards[cardIndex].stats.bottom > GameViewModel.shared.game.board[bottomIndex].stats.top {
                if GameViewModel.shared.game.board[bottomIndex].isPokemon && GameViewModel.shared.game.board[bottomIndex].isUserSide {
                    GameViewModel.shared.gameAI.rotatingCardAnimation(index: bottomIndex, isRotatingCard: GameViewModel.shared.isRotatingCard)
                    GameViewModel.shared.game.board[bottomIndex].side = .opponent
                    GameViewModel.shared.typeCardAction.fightingForOpponent(edgeIndex: bottomIndex, with: cardIndex)
                    GameViewModel.shared.animation.start(duration: 0.1, startAction: nil, whileAction: nil) {
                        GameViewModel.shared.isRotatingCard[bottomIndex].toggle()
                    }
                }
            }
        }
        
        if let leadingIndex = adjacentIndex.leading {
            if GameViewModel.shared.game.trainerCards[cardIndex].stats.leading > GameViewModel.shared.game.board[leadingIndex].stats.trailing {
                if GameViewModel.shared.game.board[leadingIndex].isPokemon && GameViewModel.shared.game.board[leadingIndex].isUserSide {
                    GameViewModel.shared.gameAI.rotatingCardAnimation(index: leadingIndex, isRotatingCard: GameViewModel.shared.isRotatingCard)
                    GameViewModel.shared.game.board[leadingIndex].side = .opponent
                    GameViewModel.shared.typeCardAction.fightingForOpponent(edgeIndex: leadingIndex, with: cardIndex)
                    GameViewModel.shared.animation.start(duration: 0.1, startAction: nil, whileAction: nil) {
                        GameViewModel.shared.isRotatingCard[leadingIndex].toggle()
                    }
                }
            }
        }
    }
    
    func endOfTurnConvertAdjacents() {
        if let cardLocationOnBoard = GameViewModel.shared.game.boardIndices.first(where: { GameViewModel.shared.game.board[$0].name == "Victreebel" && GameViewModel.shared.game.board[$0].side == .user }),
           let cardLocationOnHand = GameViewModel.shared.game.userCards.firstIndex(where: { $0.name == "Victreebel" }) {
            convertAdjacents(from: cardLocationOnBoard, with: cardLocationOnHand)
        }
        
        if let cardLocationOnBoard = GameViewModel.shared.game.boardIndices.first(where: { GameViewModel.shared.game.board[$0].name == "Victreebel" && GameViewModel.shared.game.board[$0].side == .opponent }),
           let cardLocationOnHand = GameViewModel.shared.game.trainerCards.firstIndex(where: { $0.name == "Victreebel" }) {
            convertAdjacentsForOpponent(from: cardLocationOnBoard, with: cardLocationOnHand)
        }
    }
}
