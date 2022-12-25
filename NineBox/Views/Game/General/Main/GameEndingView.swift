//
//  GameEndingView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 28/02/2022.
//

import SwiftUI

struct GameEndingView: View {
    @EnvironmentObject var gameVM: GameViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            Button(action: {
                gameVM.resetGame()
                gameVM.isShowingGameEnding.toggle()
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Quit")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
            }
        }
    }
}

struct GameEndingView_Previews: PreviewProvider {
    static var previews: some View {
        GameEndingView()
    }
}
