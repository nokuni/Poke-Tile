//
//  UserPreBattleDeckListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 05/03/2022.
//

import SwiftUI

struct UserPreBattleDeckListView: View {
    private let grid = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 4)
    var decks = [Deck]()
    @Binding var selectedDeckIndex: Int
    var size: CGSize
    var isPossessing: ((Card) -> Bool)?
    var body: some View {
        TabView(selection: $selectedDeckIndex) {
            ForEach(decks) { deck in
                VStack {
                    UserDeckRowView(deck: deck, size: size)
                        //.tag(decks.firstIndex(where: { $0.name == deck.name }))
                    LazyVGrid(columns: grid, spacing: 0) {
                        ForEach(deck.cards) { card in
                            CardView(card: card, size: size, amount: 4, isPossessing: isPossessing)
                        }
                    }
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct UserPreBattleDeckListView_Previews: PreviewProvider {
    static var previews: some View {
        UserPreBattleDeckListView(decks: [], selectedDeckIndex: .constant(0), size: CGSize.screen)
    }
}
