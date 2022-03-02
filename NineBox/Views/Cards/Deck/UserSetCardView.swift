//
//  UserSetCardView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import SwiftUI

struct UserSetCardView: View {
    @Binding var selectedCard: Card?
    @Binding var cards: [Card]
    @Binding var selectedIndex: Int
    var card: Card
    var size: CGSize
    var body: some View {
        Button(action: {
            selectedCard = card
            cards[selectedIndex] = card
            if selectedIndex < cards.count - 1 {
                selectedIndex += 1
            }
        }) {
            CardView(card: card, size: size, amount: 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.black)
                        .opacity(
                            cards.contains(card) ? 0.5 : 0
                        )
                )
        }
        .disabled(cards.contains(card))
    }
}

struct UserSetCardView_Previews: PreviewProvider {
    static var previews: some View {
        UserSetCardView(selectedCard: .constant(Card.empty), cards: .constant([]), selectedIndex: .constant(0), card: Card.empty, size: CGSize.screen)
    }
}
