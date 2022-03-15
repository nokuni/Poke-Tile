//
//  CardSummonAnimationView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 03/03/2022.
//

import SwiftUI

struct CardSummonAnimationView: View {
    private let grid = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 4)
    @ObservedObject var cardAnimationVM: CardAnimationViewModel
    var cards: [Card]
    var size: CGSize
    var isCardInDeck: ((Card) -> Bool)?
    var body: some View {
        LazyVGrid(columns: grid) {
            ForEach(cardAnimationVM.cardPlaceholders.indices, id: \.self) { index in
                CardGestureView(isRotating: $cardAnimationVM.rotatingCardPlaceholders[index], size: size, card: cardAnimationVM.cardPlaceholders[index], index: index, amount: 5, isCardInDeck: isCardInDeck)
                    .allowsHitTesting(false)
            }
        }
        .onAppear {
            cardAnimationVM.cardsSummoned = cards
            cardAnimationVM.startSummonAnimation()
        }
    }
}

struct CardSummonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CardSummonAnimationView(cardAnimationVM: CardAnimationViewModel(), cards: Card.pokemons, size: CGSize.screen)
    }
}
