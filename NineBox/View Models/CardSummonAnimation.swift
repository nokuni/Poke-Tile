//
//  CardSummonAnimation.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 05/03/2022.
//

import SwiftUI

// Manage the card summon animation

class CardAnimationViewModel: ObservableObject {
    
    @Published var rotatingCardPlaceholder = true
    //@Published var rotatingBoardCards = Array(repeating: true, count: 16)
    
    @Published var cardPlaceholder: Card = Card.empty
    //@Published var boardCardPlaceholders = Card.emptyBoard
    
    @Published var cardSummoned: Card? = nil
    
    @Published var index = 0
    var timer: Timer?
    
    func startSummonAnimation() {
        //rotatingCardPlaceholders = Array(repeating: true, count: cardsSummoned.count)
        //cardPlaceholders = Array(repeating: Card.empty, count: cardsSummoned.count)
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: animateCard)
    }
    
    /*func startBoardAnimation() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: animateBoardCard)
    }*/
    
    func animateCard(timer: Timer) {
        withAnimation(.linear.repeatCount(1, autoreverses: false)) {
            cardPlaceholder = cardSummoned ?? Card.empty
            rotatingCardPlaceholder.toggle()
            timer.invalidate()
        }
    }
    
    /*func animateBoardCard(timer: Timer) {
        if index < boardCardPlaceholders.count {
            withAnimation(.linear.repeatCount(1, autoreverses: false)) {
                boardCardPlaceholders[index] = cardsSummoned[index]
                
                rotatingBoardCards[index].toggle()
                index += 1
            }
        } else {
            timer.invalidate()
        }
    }*/
    
    func stopAnimation() {
        timer?.invalidate()
//        rotatingCardPlaceholders.indices.forEach {
//            rotatingCardPlaceholders[$0] = false
//        }
//        cardPlaceholders = cardsSummoned
    }
    
    func isAnimationFinished(isCleared: Bool?) -> Bool {
        return !rotatingCardPlaceholder
    }
}
