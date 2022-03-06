//
//  ContentView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 16/02/2022.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var gameVM: GameViewModel
    @State private var isShowingStart = false
    @State private var isShowingSurrenderModal = false
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack {
                    OpponentHandView(size: geo.size, gameVM: gameVM)
                    GameGridView(size: geo.size, gameVM: gameVM, isRotating: $gameVM.isRotatingCard)
                    UserHandView(size: geo.size, gameVM: gameVM)
                    UserInformations(gameVM: gameVM, size: geo.size)
                    ModalButtonView(isPresented: $isShowingSurrenderModal, borderColor: .black, backgroundColor: .crimson, textColor: .white, textContent: "SURRENDER", size: geo.size)
                }
            }
            .padding(30)
            
            if gameVM.isShowingTurnAnimation {
                if let trainer = gameVM.game.trainer {
                    TurnAnimationView(isPresented: $gameVM.isShowingTurnAnimation, user: gameVM.user, trainer: trainer, turn: gameVM.game.turn, opponentPlays: gameVM.opponentPlays)
                        .ignoresSafeArea()
                }
            }
            
            if gameVM.isShowingGameEnding {
                if let trainer = gameVM.game.trainer {
                    EndingAnimationView(booster: trainer.booster, isPresented: $gameVM.isShowingGameEnding, isShowingStart: $isShowingStart, resetGame: gameVM.resetGame, loadGame: gameVM.loadGame, isGameWon: gameVM.game.isGameWon())
                }
            }
            
            if isShowingStart {
                if let trainer = gameVM.game.trainer {
                    GameStartAnimationView(isPresented: $isShowingStart, user: gameVM.user, trainer: trainer)
                }
            }
            
            if isShowingSurrenderModal {
                SurrenderModalView(isShowingGameEnding: $gameVM.isShowingGameEnding, isShowingSurrenderModal: $isShowingSurrenderModal)
            }
        }
        .onAppear { isShowingStart.toggle() }
        .navigationBarHidden(true)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(GameViewModel())
    }
}
