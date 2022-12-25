//
//  OpponentHandView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 19/02/2022.
//

import SwiftUI

struct OpponentHandView: View {
    var size: CGSize
    @EnvironmentObject var gameVM: GameViewModel
    var body: some View {
        if let trainer = gameVM.game.trainer {
            Image(trainer.background)
                .resizable()
                .centerCropped(radius: 5, alignment: .center)
                .frame(width: size.width, height: size.height * 0.1)
                .overlay(
                    TrainerImageView(size: size, height: 0.1, image: trainer.image, isUnlocked: true, hasBeenCleared: false)
                )
                .overlay(
                    OpponentInformationsView(size: size)
                )
        }
    }
}

struct OpponentHandView_Previews: PreviewProvider {
    static var previews: some View {
        OpponentHandView(size: CGSize.screen)
    }
}
