//
//  CardSummonAnimation.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 05/03/2022.
//

import SwiftUI

// Manage the card summon animation

class CardSummonAnimation: ObservableObject {
    @Published var rotatings = Array(repeating: true, count: 8)
    @Published var cards: [Card] = Array(repeating: Card.empty, count: 8)
    @Published var randomCards = [Card]()
    @Published var index = 0
    var timer: Timer?
    
    func startAnimation() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: animateCard)
    }
    
    func animateCard(timer: Timer) {
        if index < cards.count {
            withAnimation(.linear.repeatCount(1, autoreverses: false)) {
                cards[index] = randomCards[index]
                
                rotatings[index].toggle()
                index += 1
            }
        } else {
            timer.invalidate()
        }
    }
    
    func stopAnimation() {
        timer?.invalidate()
        rotatings.indices.forEach {
            rotatings[$0] = false
        }
        cards = randomCards
    }
    
    var isAnimationFinished: Bool {
        rotatings.allSatisfy({ $0 == false })
    }
}
