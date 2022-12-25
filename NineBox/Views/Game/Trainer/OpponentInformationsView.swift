//
//  OpponentInformationsView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

struct OpponentInformationsView: View {
    @EnvironmentObject var gameVM: GameViewModel
    var size: CGSize
    var body: some View {
        HStack(spacing: 25) {
            OpponentCardListView(size: size)
                .frame(width: size.width * 0.4, height: size.height * 0.1)
            PlayerPointsView(size: UIDevice.isOnPad ? size.signReduce(*, by: 0.7) : size, points: gameVM.game.opponentPoints, isUser: false)
        }
        .frame(width: size.width * 0.9, alignment: .trailing)
        .padding(.trailing)
    }
}
struct OpponentInformationsView_Previews: PreviewProvider {
    static var previews: some View {
        OpponentInformationsView(size: CGSize.screen)
    }
}
