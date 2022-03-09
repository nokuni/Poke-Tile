//
//  CardSummonAnimationView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 03/03/2022.
//

import SwiftUI

struct CardSummonAnimationView: View {
    private let grid = [GridItem](repeating: .init(.flexible()), count: 4)
    @StateObject var cardAnimationVM = CardAnimationViewModel()
    var cards: [Card]
    var previousCardCollection: [Card]
    var size: CGSize
    @Binding var selectedBooster: Booster?
    var isCardInDeck: ((Card) -> Bool)?
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                Spacer()
                LazyVGrid(columns: grid, spacing: 0) {
                    ForEach(cardAnimationVM.cardPlaceholders.indices) { index in
                        CardGestureView(isRotating: $cardAnimationVM.rotatingCardPlaceholders[index], size: size, card: cardAnimationVM.cardPlaceholders[index], index: index, isCardInDeck: isCardInDeck)
                            .allowsHitTesting(false)
                            .overlay(
                                CardSummonedOverlayView(isRotating: cardAnimationVM.rotatingCardPlaceholders[index], card: cardAnimationVM.cardPlaceholders[index], previousCardCollection: previousCardCollection, size: size)
                            )
                            .shadow(color: cards[index].isDuplicate(from: previousCardCollection) ? .clear : .yellow, radius: 5)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    selectedBooster = nil
                }) {
                    LongButtonView(text: "Close", textColor: .white, textSize: 0.05, backgroundColor: !cardAnimationVM.isAnimationFinished ? .gray : .steelBlue, borderColor: .black)
                }
                .disabled(!cardAnimationVM.isAnimationFinished)
            }
            .padding()
        }
        .onAppear {
            cardAnimationVM.cardsSummoned = cards
            cardAnimationVM.startSummonAnimation()
        }
    }
}

struct CardSummonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CardSummonAnimationView(cards: Card.pokemons, previousCardCollection: [], size: CGSize.screen, selectedBooster: .constant(nil))
    }
}
