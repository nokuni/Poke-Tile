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
    var isCardInDeck: ((Card) -> Bool)?
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                LazyVGrid(columns: grid, spacing: 0) {
                    ForEach(cardAnimation.cards.indices) { index in
                        CardGestureView(isRotating: $cardAnimation.rotatings[index], size: size, card: cardAnimation.cards[index], index: index, isCardInDeck: isCardInDeck)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    selectedBooster = nil
                }) {
                    LongButtonView(text: "Close", textColor: .white, textSize: 0.05, backgroundColor: !cardAnimation.isAnimationFinished ? .gray : .steelBlue, borderColor: .black)
                }
                .disabled(!cardAnimation.isAnimationFinished)
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
