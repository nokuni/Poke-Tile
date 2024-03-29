//
//  OpponentCardListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct OpponentCardListView: View {
    private let grid = [GridItem](repeating: .init(UIDevice.isOnPad ? .fixed(UIScreen.main.bounds.width * 0.07) : .flexible(), spacing: 0), count: 4)
    var size: CGSize
    @EnvironmentObject var gameVM: GameViewModel
    var body: some View {
        LazyVGrid(columns: grid, alignment: .center, spacing: 0) {
            ForEach(gameVM.game.trainerCards) { card in
                CardView(card: Card.empty, size: size, amount: UIDevice.isOnPad ? 15 : 10)
                    .brightness(card.isActivated ? 0 : -0.5)
            }
        }
    }
}

struct OpponentCardListView_Previews: PreviewProvider {
    static var previews: some View {
        OpponentCardListView(size: CGSize.screen)
    }
}
