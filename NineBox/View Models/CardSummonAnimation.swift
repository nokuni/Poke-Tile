//
//  CardSummonAnimation.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 05/03/2022.
//

import SwiftUI

// Manage the card summon animation

class CardAnimationViewModel: ObservableObject {
    
    @Published var rotatingCardPlaceholders = Array(repeating: true, count: 8)
    @Published var rotatingBoardCards = Array(repeating: true, count: 16)
    
    @Published var cardPlaceholders = Card.placeholders
    @Published var boardCardPlaceholders = Card.emptyBoard
    
    @Published var cardsSummoned = [Card]()
    
    @Published var index = 0
    var timer: Timer?
    
    func startSummonAnimation() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: animateCard)
    }
    
    func startBoardAnimation() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: animateBoardCard)
    }
    
    func animateCard(timer: Timer) {
        if index < cardPlaceholders.count {
            withAnimation(.linear.repeatCount(1, autoreverses: false)) {
                cardPlaceholders[index] = cardsSummoned[index]
                
                rotatingCardPlaceholders[index].toggle()
                index += 1
            }
        } else {
            timer.invalidate()
        }
    }
    
    func animateBoardCard(timer: Timer) {
        if index < boardCardPlaceholders.count {
            withAnimation(.linear.repeatCount(1, autoreverses: false)) {
                boardCardPlaceholders[index] = cardsSummoned[index]
                
                rotatingBoardCards[index].toggle()
                index += 1
            }
        } else {
            timer.invalidate()
        }
    }
    
    func stopAnimation() {
        timer?.invalidate()
        rotatingCardPlaceholders.indices.forEach {
            rotatingCardPlaceholders[$0] = false
        }
        cardPlaceholders = cardsSummoned
    }
    
    var isAnimationFinished: Bool {
        rotatingCardPlaceholders.allSatisfy({ $0 == false })
    }
}
