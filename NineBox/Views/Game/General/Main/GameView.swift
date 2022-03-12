//
//  ContentView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 16/02/2022.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var gameVM: GameViewModel
    @EnvironmentObject var adventureVM: AdventureViewModel
    @EnvironmentObject var missionVM: MissionViewModel
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
                    UserInformations(userVM: userVM, gameVM: gameVM, size: geo.size)
                    Button(action: {
                        isShowingSurrenderModal.toggle()
                    }) {
                        ActionButtonView(text: "SURRENDER", textColor: .white, color: gameVM.game.turn == .opponent && !gameVM.isShowingTurnAnimation ? .gray : .crimson, size: geo.size)
                    }
                    .disabled(gameVM.game.turn == .opponent && !gameVM.isShowingTurnAnimation)
                    //ModalButtonView(isPresented: $isShowingSurrenderModal, borderColor: .black, backgroundColor: .crimson, textColor: .white, textContent: "SURRENDER", size: geo.size)
                }
            }
            .padding(30)
            
            if gameVM.isShowingTurnAnimation {
                if let trainer = gameVM.game.trainer {
                    TurnAnimationView(isPresented: $gameVM.isShowingTurnAnimation, user: userVM.user, trainer: trainer, turn: gameVM.game.turn, opponentPlays: gameVM.opponentPlays)
                        .ignoresSafeArea()
                }
            }
            
            if gameVM.isShowingGameEnding {
                if let trainer = gameVM.game.trainer {
                    EndingAnimationView(card: try! Card.getPokemon(name: trainer.reward), isPresented: $gameVM.isShowingGameEnding, isShowingStart: $isShowingStart, userVM: userVM, gameVM: gameVM, adventureVM: adventureVM, missionVM: missionVM)
                }
            }
            
            if isShowingStart {
                if let trainer = gameVM.game.trainer {
                    GameStartAnimationView(isPresented: $isShowingStart, user: userVM.user, trainer: trainer)
                }
            }
            
            if isShowingSurrenderModal {
                SurrenderModalView(gameVM: gameVM, isShowingGameEnding: $gameVM.isShowingGameEnding, isShowingSurrenderModal: $isShowingSurrenderModal)
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
