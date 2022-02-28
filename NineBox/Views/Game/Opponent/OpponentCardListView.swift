//
//  OpponentCardListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct OpponentCardListView: View {
    private let grid = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 4)
    var size: CGSize
    @ObservedObject var gameVM: GameViewModel
    var body: some View {
        LazyVGrid(columns: grid, alignment: .center, spacing: 0) {
            if let trainer = gameVM.game.trainer {
                ForEach(trainer.cards.indices, id: \.self) { index in
                    CardView(card: Card.empty, size: size, amount: 10)
                        .brightness(trainer.cards[index].isActivated ? 0 : -0.5)
                }
            }
        }
    }
}

struct OpponentCardListView_Previews: PreviewProvider {
    static var previews: some View {
        OpponentCardListView(size: CGSize.screen, gameVM: GameViewModel())
    }
}
