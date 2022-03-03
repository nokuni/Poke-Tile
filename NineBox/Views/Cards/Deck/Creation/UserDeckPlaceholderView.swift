//
//  UserDeckPlaceholderView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 03/03/22.
//

import SwiftUI

struct UserDeckPlaceholderView: View {
    private let grid = [GridItem](repeating: .init(.flexible()), count: 4)
    @Binding var cards: [Card]
    @Binding var selectedIndex: Int
    var body: some View {
        LazyVGrid(columns: grid, spacing: 0) {
            ForEach(cards.indices) { index in
                UserDeckSlotView(selectedIndex: $selectedIndex, card: cards[index], index: index, size: CGSize.screen)
            }
        }
    }
}

struct UserDeckPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        UserDeckPlaceholderView(cards: .constant([]), selectedIndex: .constant(0))
    }
}
