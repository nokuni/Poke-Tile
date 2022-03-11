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
    var booster: Booster
    @Binding var isPresented: Bool
    @Binding var isShowingStart: Bool
    @ObservedObject var userVM: UserViewModel
    @ObservedObject var gameVM: GameViewModel
    @ObservedObject var adventureVM: AdventureViewModel
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(gameVM.game.isGameWon ? .blue : .crimson)
                .opacity(0.7)
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
                EndingMenuView(gameVM: gameVM, dismiss: dismiss, booster: booster, isShowingStart: $isShowingStart)
            }
        }
        .onAppear {
            withAnimation(.spring()) {
                if gameVM.game.isGameWon {
                    if let trainer = gameVM.game.trainer {
                        adventureVM.unlockNextTrainer(from: trainer)
                        if !trainer.hasBeenCleared {
                            userVM.addCardsToCollection(trainer.booster.cards)
                        }
                    }
                }
                isAnimating.toggle()
            }
        }
    }
}

struct EndingAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        EndingAnimationView(booster: Booster.all[0], isPresented: .constant(false), isShowingStart: .constant(false), userVM: UserViewModel(), gameVM: GameViewModel(), adventureVM: AdventureViewModel())
    }
}
