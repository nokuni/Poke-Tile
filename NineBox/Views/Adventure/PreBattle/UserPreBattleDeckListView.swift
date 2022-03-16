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
        HStack {
            Button(action: {
                if selectedDeckIndex > 0 {
                    selectedDeckIndex -= 1
                }
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.steelBlue)
                    .font(.system(size: size.width * 0.08, weight: .bold, design: .rounded))
            }
            .accessibilityLabel("Previous Card Deck")
            
            TabView(selection: $selectedDeckIndex) {
                ForEach(decks) { deck in
                    VStack {
                        UserDeckRowView(deck: deck, size: size)
                        LazyVGrid(columns: grid, spacing: 0) {
                            ForEach(deck.cards) { card in
                                CardView(card: card, size: size, amount: 5, isPossessing: isPossessing)
                            }
                        }
                    }
                    .scaleEffect(0.9)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Button(action: {
                if selectedDeckIndex < (decks.count - 1) {
                    selectedDeckIndex += 1
                }
            }) {
                Image(systemName: "chevron.right")
                    .foregroundColor(.steelBlue)
                    .font(.system(size: size.width * 0.08, weight: .bold, design: .rounded))
            }
            .accessibilityLabel("Next Card Deck")
        }
    }
}

struct UserPreBattleDeckListView_Previews: PreviewProvider {
    static var previews: some View {
        UserPreBattleDeckListView(decks: [], selectedDeckIndex: .constant(0), size: CGSize.screen)
    }
}
