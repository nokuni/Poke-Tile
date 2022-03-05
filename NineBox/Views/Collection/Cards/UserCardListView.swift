//
//  UserCardList.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 23/02/2022.
//

import SwiftUI

struct UserCardListView: View {
    var size: CGSize
    @ObservedObject var gameVM: GameViewModel
    private let grid = [GridItem](repeating: .init(.flexible(), spacing: 25), count: 4)
    
    var sortedCards: [Card] {
        gameVM.user.cards.sorted(by: { $0.image < $1.image })
    }
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: grid, spacing: 0) {
                ForEach(sortedCards) { card in
                    CardView(card: card, size: size, amount: 4)
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [.powderBlue, .white, .powderBlue]), startPoint: .top, endPoint: .bottom)
                .cornerRadius(10)
                .opacity(0.5)
        )
    }
}

struct UserCardListView_Previews: PreviewProvider {
    static var previews: some View {
        UserCardListView(size: CGSize.screen, gameVM: GameViewModel())
    }
}
