//
//  UserDeckCreationView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 02/03/2022.
//

import SwiftUI

struct UserDeckCreationView: View {
    private let grid = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 4)
    @ObservedObject var gameVM: GameViewModel
    @Binding var selectedIndex: Int
    @Binding var selectedDeckIndex: Int
    var size: CGSize
    var body: some View {
        TabView(selection: $selectedDeckIndex) {
            ForEach(gameVM.user.decks.indices) { deckIndex in
                LazyVGrid(columns: grid, spacing: 0) {
                    ForEach(gameVM.user.decks[deckIndex].cards.indices) { index in
                        UserDeckSlotView(selectedIndex: $selectedIndex, card: gameVM.user.decks[deckIndex].cards[index], index: index, size: size)
                    }
                }
                .tag(deckIndex)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(width: size.width, height: size.height * 0.25)
    }
}

struct UserDeckCreationView_Previews: PreviewProvider {
    static var previews: some View {
        UserDeckCreationView(gameVM: GameViewModel(), selectedIndex: .constant(0), selectedDeckIndex: .constant(0), size: CGSize.screen)
    }
}
