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
    @State var cards = [Card]()
    @State var selectedCard: Card? = nil
    var deck: Deck
    var size: CGSize
    var isPossessing: ((Card) -> Bool)?
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading) {
                
                NavigationTitleView(size: size, navigationTitle: NavigationTitleModel(image: "decks", title: deck.name, color: deck.cards.first?.borderColor ?? .gray))
                
                LazyVGrid(columns: grid, spacing: 0) {
                    ForEach(cards) { card in
                        CardView(card: card, size: size, amount: 4, isPossessing: isPossessing)
                            .onTapGesture {
                                selectedCard = card
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(selectedCard?.name == card.name ? Color.blue.opacity(0.5) : .clear)
                            )
                    }
                }
                if let selectedCard = selectedCard {
                    UserCardInformationView(card: selectedCard, size: size, isPossessing: isPossessing)
                }
                
                Spacer()
                BackButtonView(size: size, dismiss: dismiss)
            }
            .padding()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear { cards = deck.cards }
    }
}

struct UserDeckDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDeckDetailView(deck: Deck.all[0], size: CGSize.screen)
    }
}
