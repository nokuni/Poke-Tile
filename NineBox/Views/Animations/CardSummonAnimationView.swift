//
//  CardSummonAnimationView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 03/03/2022.
//

import SwiftUI

struct CardSummonAnimationView: View {
    private let grid = [GridItem](repeating: .init(.flexible()), count: 4)
    @StateObject var cardAnimation = CardSummonAnimation()
    var cards: [Card]
    var size: CGSize
    @Binding var selectedBooster: Booster?
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                LazyVGrid(columns: grid, spacing: 0) {
                    ForEach(cardAnimation.cards.indices) { index in
                        CardGestureView(isRotating: $cardAnimation.rotatings[index], size: size, card: cardAnimation.cards[index], index: index)
                    }
                }
                Spacer()
                Button(action: {
                    selectedBooster = nil
                }) {
                    LongButtonView(text: "Close", textColor: .white, textSize: 0.05, backgroundColor: .steelBlue, borderColor: .black)
                }
            }
            .padding()
        }
        .onAppear {
            cardAnimation.randomCards = cards
            cardAnimation.startAnimation()
        }
    }
}

struct CardSummonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CardSummonAnimationView(cards: Card.pokemons, size: CGSize.screen, selectedBooster: .constant(nil))
    }
}

class CardSummonAnimation: ObservableObject {
    @Published var rotatings = Array(repeating: true, count: 8)
    @Published var cards: [Card] = Array(repeating: Card.empty, count: 8)
    @Published var randomCards = [Card]()
    @Published var index = 0
    var timer: Timer?
    
    func startAnimation() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: animateCard)
    }
    
    func animateCard(timer: Timer) {
        if index < cards.count {
            withAnimation(.linear.repeatCount(2, autoreverses: false)) {
                rotatings[index].toggle()
                cards[index] = randomCards[index]
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
}
