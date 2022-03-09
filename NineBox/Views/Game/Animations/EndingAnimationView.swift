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
                        userVM.user.boosters.append(trainer.booster)
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

struct EndingMenuView: View {
    @ObservedObject var gameVM: GameViewModel
    var dismiss: DismissAction?
    var booster: Booster
    @Binding var isShowingStart: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .stroke(Color.black, lineWidth: 3)
            .background(Color.white)
            .overlay(
                VStack {
                    if gameVM.game.isGameWon {
                        Text("You obtained a booster !")
                            .foregroundColor(.black)
                            .font(.system(size: CGSize.screen.width * 0.05, weight: .bold, design: .rounded))
                        CardBoosterView(booster: booster, size: CGSize.screen)
                            .frame(height: CGSize.screen.height * 0.1)
                    }
                    
                    Text(gameVM.game.isGameWon ? "WIN" : "GAME OVER")
                        .foregroundColor(.black)
                        .font(.system(size: CGSize.screen.width * 0.1, weight: .bold, design: .rounded))
                    
                    if !gameVM.game.isGameWon {
                        Button(action: {
                            gameVM.loadGame()
                            isShowingStart.toggle()
                        }) {
                            ActionButtonView(text: "RETRY", textColor: .white, color: .steelBlue, size: CGSize.screen)
                            //LongButtonView(text: "RETRY", textColor: .white, textSize: 0.05, backgroundColor: .crimson, borderColor: .black)
                        }
                    }
                    
                    Button(action: {
                        gameVM.resetGame()
                        dismiss?()
                    }) {
                        ActionButtonView(text: gameVM.game.isGameWon ? "OK" : "QUIT", textColor: .white, color: .crimson, size: CGSize.screen)
                        //LongButtonView(text: gameVM.game.isGameWon ? "OK" : "QUIT", textColor: .black, textSize: 0.05, backgroundColor: .paleGoldenRod, borderColor: .black)
                    }
                }
                    .padding(.horizontal)
            )
            .padding()
    }
}
