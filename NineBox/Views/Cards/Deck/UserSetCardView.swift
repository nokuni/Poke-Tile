//
//  UserSetCardView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import SwiftUI

struct UserSetCardView: View {
    @Binding var selectedCard: Card?
    @Binding var deck: Deck
    var card: Card
    var index: Int
    var size: CGSize
    var body: some View {
        Button(action: {
            selectedCard = card
            deck.cards[index] = card
        }) {
            CardView(card: card, size: size, amount: 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.black)
                        .opacity(
                            deck.cards.contains(card) ? 0.5 : 0
                        )
                )
        }
        .disabled(deck.cards.contains(card))
    }
}

struct UserSetCardView_Previews: PreviewProvider {
    static var previews: some View {
        UserSetCardView(selectedCard: .constant(Card.empty), deck: .constant(Deck()), card: Card.empty, index: 0, size: CGSize.screen)
    }
}
