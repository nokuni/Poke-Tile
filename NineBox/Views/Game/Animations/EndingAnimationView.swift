//
//  LooseAnimationView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 01/03/2022.
//

import SwiftUI

struct EndingAnimationView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isAnimating = false
    @State private var isShowingMenu = false
    var cards: [Card]
    @Binding var isPresented: Bool
    @Binding var isShowingStart: Bool
    @ObservedObject var userVM: UserViewModel
    @ObservedObject var gameVM: GameViewModel
    @ObservedObject var adventureVM: AdventureViewModel
    @ObservedObject var missionVM: MissionViewModel
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
                EndingMenuView(gameVM: gameVM, dismiss: dismiss, cards: cards, isShowingStart: $isShowingStart)
            }
        }
        .onAppear {
            withAnimation(.spring()) {
                if gameVM.game.isGameWon {
                    adventureVM.worldTrainerEndBattleActions(gameVM.game.trainer, addCards: userVM.addCardsToCollection)
                    adventureVM.tutorialTrainerEndBattleActions(gameVM.game.trainer, addCards: userVM.addCardsToCollection)
                    adventureVM.checkAdventureMissions(&missionVM.missions)
                }
                isAnimating.toggle()
            }
        }
    }
}

struct EndingAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        EndingAnimationView(cards: Card.pokemons, isPresented: .constant(false), isShowingStart: .constant(false), userVM: UserViewModel(), gameVM: GameViewModel(), adventureVM: AdventureViewModel(), missionVM: MissionViewModel())
    }
}
