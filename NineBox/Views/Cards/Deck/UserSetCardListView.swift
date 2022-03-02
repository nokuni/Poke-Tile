//
//  UserSetCardListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import SwiftUI

struct UserSetCardListView: View {
    private let grid = [GridItem](repeating: .init(.flexible(), spacing: 25), count: 4)
    var size: CGSize
    @Binding var selectedIndex: Int
    @Binding var selectedCard: Card?
    @Binding var selectedDeck: Deck
    @ObservedObject var gameVM: GameViewModel
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: grid, spacing: 0) {
                ForEach(gameVM.user.cards) { card in
//                    UserSetCardView(selectedCard: $selectedCard, cards: $selectedDeck, selectedIndex: $selectedIndex, card: card, size: size)
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [.powderBlue, .white, .powderBlue]), startPoint: .top, endPoint: .bottom)
                .cornerRadius(5)
                .opacity(0.5)
        )
    }
}

struct UserSetCardListView_Previews: PreviewProvider {
    static var previews: some View {
        UserSetCardListView(size: CGSize.screen, selectedIndex: .constant(0), selectedCard: .constant(Card.empty), selectedDeck: .constant(Deck.all[0]), gameVM: GameViewModel())
    }
}
