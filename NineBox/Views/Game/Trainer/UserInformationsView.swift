//
//  UserInformationsView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

struct UserInformationsView: View {
    @EnvironmentObject var gameVM: GameViewModel
    var size: CGSize
    var body: some View {
        ImageCroppedView(image: gameVM.game.trainer?.background ?? "forest.background")
            .frame(width: size.width, height: size.height * 0.1)
            .overlay(
                TrainerImageView(size: size, height: 0.1, image: gameVM.user.user.profile.image, isUnlocked: true, hasBeenCleared: false)
            )
            .overlay(
                PlayerPointsView(size: UIDevice.isOnPad ? size.signReduce(*, by: 0.7) : size, points: gameVM.game.userPoints, isUser: true)
                    .frame(width: size.width * 0.9, alignment: .trailing)
                    .padding(.trailing)
            )
            .zIndex(-1)
    }
}

struct UserInformationsView_Previews: PreviewProvider {
    static var previews: some View {
        UserInformationsView(size: CGSize.screen)
    }
}
