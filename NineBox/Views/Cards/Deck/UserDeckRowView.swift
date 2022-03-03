//
//  UserDeckRowView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 03/03/2022.
//

import SwiftUI

struct UserDeckRowView: View {
    private let grid = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 4)
    @ObservedObject var gameVM: GameViewModel
    var deck: Deck
    var size: CGSize
    var body: some View {
        VStack {
            LazyVGrid(columns: grid, spacing: 0) {
                ForEach(deck.cards.indices) { index in
                    CardView(card: deck.cards[index], size: size, amount: 4)
                        .overlay(
                            ZStack {
                                if !gameVM.user.cards.contains(where: { $0.name == deck.cards[index].name }) {
                                    Color.black
                                        .cornerRadius(5)
                                        .opacity(0.5)
                                }
                            }
                        )
                }
            }
            .padding(.top, 25)
            .padding(5)
            .background(
                UserDeckBackgroundView(deck: deck, size: size)
            )
        }
    }
}

struct UserDeckRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserDeckRowView(gameVM: GameViewModel(), deck: Deck.empty, size: CGSize.screen)
    }
}
