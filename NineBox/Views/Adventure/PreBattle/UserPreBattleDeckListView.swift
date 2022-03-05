//
//  UserPreBattleDeckListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 05/03/2022.
//

import SwiftUI

struct UserPreBattleDeckListView: View {
    private let grid = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 4)
    var decks: [Deck]
    @Binding var selectedDeckIndex: Int
    var size: CGSize
    var isCardInDeck: ((Card) -> Bool)?
    var body: some View {
        TabView(selection: $selectedDeckIndex) {
            ForEach(decks.indices) { deckIndex in
                VStack {
                    UserDeckRowView(deck: decks[deckIndex], size: size)
                        .tag(deckIndex)
                    LazyVGrid(columns: grid, spacing: 0) {
                        ForEach(decks[deckIndex].cards.indices) { index in
                            CardView(card: decks[deckIndex].cards[index], size: size, amount: 4, isCardInDeck: isCardInDeck)
                        }
                    }
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

struct UserPreBattleDeckListView_Previews: PreviewProvider {
    static var previews: some View {
        UserPreBattleDeckListView(decks: [], selectedDeckIndex: .constant(0), size: CGSize.screen)
    }
}
