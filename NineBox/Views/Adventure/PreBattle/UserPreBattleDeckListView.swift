//
//  UserPreBattleDeckListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 05/03/2022.
//

import SwiftUI

struct UserPreBattleDeckListView: View {
    private let animation = ChainAnimation()
    private let grid = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 4)
    var decks = [Deck]()
    @Binding var selectedDeckIndex: Int
    var size: CGSize
    var isPossessing: ((Card) -> Bool)?
    @State private var isShowingDeckCards: Bool = false
    @State private var canPressButton: Bool = true
    var body: some View {
        VStack {
            HStack {
                TabView(selection: $selectedDeckIndex) {
                    ForEach(decks.indices, id: \.self) { index in
                        LazyVStack {
                            LazyVGrid(columns: grid, spacing: 0) {
                                ForEach(decks[index].cards) { card in
                                    CardView(card: card, size: size, amount: 4, isPossessing: isPossessing)
                                }
                            }
                            UserDeckRowView(deck: decks[index], size: size)
                        }
                        .tag(index)
                    }
                }
                .allowsHitTesting(false)
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            PagingButtonsView(collection: decks, canPressButton: $canPressButton, index: $selectedDeckIndex)
        }
    }
}

struct UserPreBattleDeckListView_Previews: PreviewProvider {
    static var previews: some View {
        UserPreBattleDeckListView(decks: Deck.all, selectedDeckIndex: .constant(0), size: CGSize.screen)
    }
}
