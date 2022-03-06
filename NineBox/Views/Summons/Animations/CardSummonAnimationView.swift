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
    var previousCardCollection: [Card]
    var size: CGSize
    @Binding var selectedBooster: Booster?
    var isCardInDeck: ((Card) -> Bool)?
    var isCardDuplicate: ((Card, [Card]) -> Bool)?
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                Spacer()
                
                LazyVGrid(columns: grid, spacing: 0) {
                    ForEach(cardAnimation.cards.indices) { index in
                        CardGestureView(isRotating: $cardAnimation.rotatings[index], size: size, card: cardAnimation.cards[index], index: index, isCardInDeck: isCardInDeck)
                            .overlay(
                                CardSummonedOverlayView(isRotating: cardAnimation.rotatings[index], card: cardAnimation.cards[index], previousCardCollection: previousCardCollection, size: size, isCardDuplicate: isCardDuplicate)
                            )
                            .shadow(color: isCardDuplicate!(cardAnimation.cards[index], previousCardCollection) ? .clear : .yellow, radius: 5)
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
        CardSummonAnimationView(cards: Card.pokemons, previousCardCollection: [], size: CGSize.screen, selectedBooster: .constant(nil))
    }
}

struct CardSummonedOverlayView: View {
    var isRotating: Bool
    var card: Card
    var previousCardCollection: [Card]
    var size: CGSize
    var isCardDuplicate: ((Card, [Card]) -> Bool)?
    var body: some View {
        ZStack {
            if isRotating == false {
                Text(isCardDuplicate!(card, previousCardCollection) ? "Duplicate" : "New card")
                    .foregroundColor(isCardDuplicate!(card, previousCardCollection) ? .white : .yellow)
                    .font(.system(size: size.width * 0.03, weight: .bold, design: .rounded))
                    .frame(width: size.width * 0.2, height: size.height * 0.05, alignment: .bottom)
                    .shadow(color: .black, radius: 0, x: 1, y: 1)
            }
        }
    }
}
