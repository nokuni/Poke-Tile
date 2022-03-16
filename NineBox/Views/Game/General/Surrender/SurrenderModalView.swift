//
//  SurrenderModalView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 01/03/2022.
//

import SwiftUI

struct SurrenderModalView: View {
    @ObservedObject var gameVM: GameViewModel
    @Binding var isShowingGameEnding: Bool
    @Binding var isShowingSurrenderModal: Bool
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.black
                    .opacity(0.5)
                    .ignoresSafeArea()
                LazyVStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.white)
                        .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.4)
                        .overlay(
                            SurrenderModalOverlayView(gameVM: gameVM, isShowingSurrenderModal: $isShowingSurrenderModal, isShowingGameEnding: $isShowingGameEnding)
                        )
                    Spacer()
                }
                .padding(.top)
            }
        }
    }
}

struct SurrenderModalView_Previews: PreviewProvider {
    static var previews: some View {
        SurrenderModalView(gameVM: GameViewModel(), isShowingGameEnding: .constant(false), isShowingSurrenderModal: .constant(false))
    }
}

struct SurrenderModalOverlayView: View {
    @ObservedObject var gameVM: GameViewModel
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
                    ActionButtonView(text: "NO", textColor: .white, color: .steelBlue, shadowColor: .black, size: CGSize.screen)
                }
                Button(action: {
                    gameVM.game.boardIndices.forEach {
                        gameVM.game.board[$0].side = .opponent
                    }
                    isShowingSurrenderModal.toggle()
                    isShowingGameEnding.toggle()
                }) {
                    ActionButtonView(text: "YES", textColor: .white, color: .crimson, shadowColor: .black, size: CGSize.screen)
                }
            }
            .padding(.horizontal)
        }
    }
}
