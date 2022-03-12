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
    var card: Card
    var size: CGSize
    var isCardInDeck: ((Card) -> Bool)?
    var body: some View {
        CardGestureView(isRotating: $cardAnimationVM.rotatingCardPlaceholder, size: size, card: cardAnimationVM.cardPlaceholder, index: 0, amount: 3, isCardInDeck: isCardInDeck)
            .allowsHitTesting(false)
        
            .onAppear {
                cardAnimationVM.cardSummoned = card
                cardAnimationVM.startSummonAnimation()
            }
    }
}

struct CardSummonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CardSummonAnimationView(cardAnimationVM: CardAnimationViewModel(), card: Card.pokemons[0], size: CGSize.screen)
    }
}
