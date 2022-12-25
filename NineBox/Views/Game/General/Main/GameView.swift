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
                    OpponentHandView(size: geo.size)
                    GameGridView(size: geo.size, isRotating: $gameVM.isRotatingCard)
                    UserHandView(size: geo.size)
                    UserInformationsView(size: geo.size)
                    Button(action: {
                        isShowingSurrenderModal.toggle()
                    }) {
                        ActionButtonView(text: "SURRENDER", textColor: .white, textSize: 0.025, textStrokeColor: .maroon, buttonColor: gameVM.game.turn == .opponent && !gameVM.isShowingTurnAnimation ? .gray : .crimson, buttonStrokeColor: .maroon)
                    }
                    .disabled(gameVM.game.turn == .opponent && !gameVM.isShowingTurnAnimation)
                    //ModalButtonView(isPresented: $isShowingSurrenderModal, borderColor: .black, backgroundColor: .crimson, textColor: .white, textContent: "SURRENDER", size: geo.size)
                }
            }
            .padding(30)
            
            switch true {
            case gameVM.isShowingTurnAnimation:
                if let trainer = gameVM.game.trainer {
                    TurnAnimationView(isPresented: $gameVM.isShowingTurnAnimation, user: gameVM.user.user, trainer: trainer, turn: gameVM.game.turn, opponentPlays: gameVM.gameAI.opponentPlays)
                        .ignoresSafeArea()
                }
            case gameVM.isShowingGameEnding:
                if let trainer = gameVM.game.trainer {
                    EndingAnimationView(cards: trainer.reward.map { try! Card.getPokemon(name: $0) }, isPresented: $gameVM.isShowingGameEnding, isShowingStart: $isShowingStart)
                }
            case isShowingStart:
                if let trainer = gameVM.game.trainer {
                    GameStartAnimationView(isPresented: $isShowingStart, user: gameVM.user.user, trainer: trainer)
                }
            case isShowingSurrenderModal:
                SurrenderModalView(isShowingGameEnding: $gameVM.isShowingGameEnding, isShowingSurrenderModal: $isShowingSurrenderModal)
            default:
                EmptyView()
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
