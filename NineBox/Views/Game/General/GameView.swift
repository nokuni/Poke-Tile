//
//  ContentView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 16/02/2022.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var gameVM: GameViewModel
    var body: some View {
        ZStack {
            GeometryReader { geo in
                VStack {
                    OpponentHandView(size: geo.size, gameVM: gameVM)
                    GameGridView(size: geo.size, gameVM: gameVM, isShowing: $gameVM.isShowingCard)
                    UserHandView(size: geo.size, gameVM: gameVM, isShowing: $gameVM.isShowingHand)
                    UserInformations(gameVM: gameVM, size: geo.size)
                }
            }
            .padding(30)
            
            if gameVM.isShowingTurnAnimation {
                if let trainer = gameVM.game.trainer {
                    TurnAnimationView(isPresented: $gameVM.isShowingTurnAnimation, trainer: trainer, turn: gameVM.game.turn, opponentPlays: gameVM.opponentPlays)
                        .ignoresSafeArea()
                }
            }
        }
        .navigationBarHidden(true)
        //.ignoresSafeArea()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(GameViewModel())
    }
}
