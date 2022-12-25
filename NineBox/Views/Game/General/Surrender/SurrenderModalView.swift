//
//  SurrenderModalView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 01/03/2022.
//

import SwiftUI

struct SurrenderModalView: View {
    @EnvironmentObject var gameVM: GameViewModel
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
                            SurrenderModalOverlayView(isShowingSurrenderModal: $isShowingSurrenderModal, isShowingGameEnding: $isShowingGameEnding)
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
        SurrenderModalView(isShowingGameEnding: .constant(false), isShowingSurrenderModal: .constant(false))
    }
}
