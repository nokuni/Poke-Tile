//
//  UserPreBattleDeckListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 05/03/2022.
//

import SwiftUI

struct UserPreBattleDeckListView: View {
    private let grid = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 4)
    @ObservedObject var userVM: UserViewModel
    @Binding var selectedDeckIndex: Int
    var size: CGSize
    var isCardInDeck: ((Card) -> Bool)?
    var body: some View {
        TabView(selection: $selectedDeckIndex) {
            ForEach(userVM.filteredDecks(filter: .playable)) { deck in
                VStack {
                    UserDeckRowView(deck: deck, size: size)
                        .tag(userVM.user.decks.firstIndex(where: { $0.name == deck.name }))
                    LazyVGrid(columns: grid, spacing: 0) {
                        ForEach(deck.cards) { card in
                            CardView(card: card, size: size, amount: 4, isCardInDeck: isCardInDeck)
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
        UserPreBattleDeckListView(userVM: UserViewModel(), selectedDeckIndex: .constant(0), size: CGSize.screen)
    }
}
