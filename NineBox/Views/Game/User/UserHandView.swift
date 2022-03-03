//
//  PlayerCardListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 17/02/2022.
//

import SwiftUI

struct UserHandView: View {
    private let grid = [GridItem](repeating: .init(.flexible()), count: 4)
    var size: CGSize
    @ObservedObject var gameVM: GameViewModel
    var body: some View {
        VStack {
            LazyVGrid(columns: grid, spacing: 0) {
                ForEach(gameVM.game.userCards.indices, id: \.self) { index in
                    CardGestureView(isRotating: .constant(false), size: size, card: gameVM.game.userCards[index], index: index, cardDropped: gameVM.cardDropped)
                        .brightness(gameVM.game.userCards[index].isActivated ? 0 : -0.5)
                        .disabled(gameVM.game.turn == .opponent && !gameVM.isShowingTurnAnimation)
                }
            }
        }
    }
}

struct UserHandView_Previews: PreviewProvider {
    static var previews: some View {
        UserHandView(size: CGSize.screen, gameVM: GameViewModel())
    }
}
