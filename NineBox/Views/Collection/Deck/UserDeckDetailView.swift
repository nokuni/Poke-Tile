//
//  UserDeckDetailView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 04/03/2022.
//

import SwiftUI

struct UserDeckDetailView: View {
    @Environment(\.dismiss) private var dismiss
    private let grid = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 4)
    var cardCollection: [Card]
    var deck: Deck
    var size: CGSize
    @State var selectedCard: Card? = nil
    var isCardInDeck: ((Card) -> Bool)?
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading) {
                NavigationTitleView(size: size, navigationTitle: NavigationTitleModel(image: "decks", title: deck.name, color: deck.cards.first?.borderColor ?? .gray))
                LazyVGrid(columns: grid, spacing: 0) {
                    ForEach(deck.cards.indices) { index in
                        Button(action: {
                            selectedCard = deck.cards[index]
                        }) {
                            CardView(card: deck.cards[index], size: size, amount: 4, isCardInDeck: isCardInDeck)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(selectedCard?.name == deck.cards[index].name ? Color.blue.opacity(0.5) : .clear)
                        )
                    }
                }
                if let selectedCard = selectedCard {
                    UserCardInformationView(card: selectedCard, size: size, isCardInDeck: isCardInDeck)
                }
                Spacer()
                BackButtonView(size: size, dismiss: dismiss)
            }
            .padding()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct UserDeckDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDeckDetailView(cardCollection: [], deck: Deck.all[0], size: CGSize.screen)
    }
}
