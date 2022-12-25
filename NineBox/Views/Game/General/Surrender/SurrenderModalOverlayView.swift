//
//  SurrenderModalOverlayView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

struct SurrenderModalOverlayView: View {
    @EnvironmentObject var gameVM: GameViewModel
    @Binding var isShowingSurrenderModal: Bool
    @Binding var isShowingGameEnding: Bool
    var body: some View {
        VStack {
            Text("Do you really want to surrender this battle ?")
                .foregroundColor(.steelBlue)
                .font(.system(size: CGSize.screen.width * 0.07, weight: .semibold, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.vertical)
            HStack(spacing: 20) {
                Button(action: {
                    isShowingSurrenderModal.toggle()
                }) {
                    ActionButtonView(text: "NO", textColor: .white, textSize: 0.025, textStrokeColor: .brownApp, buttonColor: .lightBlueApp, buttonStrokeColor: .steelBlue)
                }
                Button(action: {
                    gameVM.game.boardIndices.forEach {
                        gameVM.game.board[$0].side = .opponent
                    }
                    isShowingSurrenderModal.toggle()
                    isShowingGameEnding.toggle()
                }) {
                    ActionButtonView(text: "YES", textColor: .white, textSize: 0.025, textStrokeColor: .brownApp, buttonColor: .orangeApp, buttonStrokeColor: .steelBlue)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct SurrenderModalOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        SurrenderModalOverlayView(isShowingSurrenderModal: .constant(false), isShowingGameEnding: .constant(false))
    }
}
