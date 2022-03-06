//
//  UserDeckListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import SwiftUI

struct UserDeckListView: View {
    private let grid = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 4)
    var decks: [Deck]
    var size: CGSize
    var isCardInDeck: ((Card) -> Bool)?
    var isDeckPlayable: ((Deck) -> Bool)?
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(decks) { deck in
                NavigationLink(destination: UserDeckDetailView(deck: deck, size: size, isCardInDeck: isCardInDeck)) {
                    UserDeckRowView(deck: deck, size: size)
                        .overlay(
                            ZStack {
                                if let isDeckPlayable = isDeckPlayable?(deck) {
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(isDeckPlayable ? .clear : .black.opacity(0.5))
                                }
                            }
                        )
                }
            }
        }
    }
}

struct UserDeckListView_Previews: PreviewProvider {
    static var previews: some View {
        UserDeckListView(decks: [], size: CGSize.screen)
    }
}
