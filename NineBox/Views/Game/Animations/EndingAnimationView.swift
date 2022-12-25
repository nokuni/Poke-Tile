//
//  LooseAnimationView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 01/03/2022.
//

import SwiftUI

struct EndingAnimationView: View {
    @State private var isAnimating = false
    @State private var isShowingMenu = false
    var cards: [Card]
    @Binding var isPresented: Bool
    @Binding var isShowingStart: Bool
    @EnvironmentObject var gameVM: GameViewModel
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack {
                if isAnimating {
                    ZStack {
                        Image(gameVM.game.isGameWon ? "win" : "loose")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(gameVM.game.isGameWon ? 0.7 : 1)
                    }
                    .transition(.move(edge: .top))
                }
                EndingMenuView(cards: cards, isShowingStart: $isShowingStart)
            }
        }
        .onAppear {
            withAnimation(.spring()) {
                if gameVM.game.isGameWon {
                    gameVM.adventure.worldTrainerEndBattleActions(gameVM.game.trainer, addCards: gameVM.user.addCardsToCollection)
                    gameVM.adventure.tutorialTrainerEndBattleActions(gameVM.game.trainer, addCards: gameVM.user.addCardsToCollection)
                    gameVM.adventure.checkAdventureMissions(&gameVM.mission.missions)
                }
                isAnimating.toggle()
            }
        }
    }
}

struct EndingAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        EndingAnimationView(cards: Card.pokemons, isPresented: .constant(false), isShowingStart: .constant(false))
    }
}
