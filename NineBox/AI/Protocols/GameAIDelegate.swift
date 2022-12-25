//
//  GameAIDelegate.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 20/12/22.
//

import Foundation

protocol GameAIDelegate {
    
    func compareCardsStats(firstCard: Card, secondCard: Card) -> ((top: Bool, location: Int), (trailing: Bool, location: Int), (bottom: Bool, location: Int), (leading: Bool, location: Int))
    
    func convertingMatches(of firstCardIndex: Int, with secondCard: Card) -> [Int]
    
    func rotatingCardAnimation(index: Int, isRotatingCard: [Bool])
    
    func opponentCardAction(actionIndex: Int, cardIndex: Int, targetIndex: Int?)
    
    func userMatchingWeaknesses(with card: Card) -> (locations: [Int], index: Int?)
    
    func getBestLocation(with card: Card) -> Int?
    
    func opponentPlays()
}
