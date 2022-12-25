//
//  EndingMenuView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 09/03/2022.
//

import SwiftUI

struct EndingMenuView: View {
    @StateObject var cardAnimationVM = CardAnimationViewModel()
    @EnvironmentObject var gameVM: GameViewModel
    @Environment(\.presentationMode) var presentationMode
    var cards: [Card]
    @Binding var isShowingStart: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .foregroundColor(.white)
            .overlay(
                VStack {
                    Text(gameVM.game.isGameWon ? "Congratulation!" : "Defeat...")
                        .foregroundColor(.steelBlue)
                        .font(.system(size: gameVM.game.isGameWon ? CGSize.screen.width * 0.1 : CGSize.screen.width * 0.15, weight: .bold, design: .rounded))
                    
                    if gameVM.game.isGameWon {
                        if let trainer = gameVM.game.trainer {
                            if !trainer.hasBeenCleared {
                                CardSummonAnimationView(cardAnimationVM: cardAnimationVM, cards: cards, size: CGSize.screen)
                                Text("New cards!")
                                    .foregroundColor(.steelBlue)
                                    .font(.system(size: CGSize.screen.width * 0.04, weight: .bold, design: .rounded))
                            } else {
                                Text("You already obtained this reward")
                                    .foregroundColor(.gray)
                                    .font(.system(size: CGSize.screen.width * 0.06, weight: .bold, design: .rounded))
                                    .multilineTextAlignment(.center)
                            }
                        }
                        Button(action: {
                            gameVM.resetGame()
                            gameVM.isShowingGameEnding.toggle()
                            if gameVM.adventure.tutorialTrainers.allSatisfy({ $0.hasBeenCleared }) && gameVM.home.isShowingEndingTutorial {
                                gameVM.adventure.tutorialTrainerState = .inEndingTutorial
                            } else {
                                gameVM.adventure.tutorialTrainerState = .inSelection
                                gameVM.adventure.worldTrainerState = .inSelection
                            }
                        }) {
                            ActionButtonView(text: "OK", textColor: .white, textSize: 0.025, textStrokeColor: .brownApp, buttonColor: cardAnimationVM.isAnimationFinished(isCleared: gameVM.game.trainer?.hasBeenCleared) ? .orangeApp : .gray, buttonStrokeColor: .steelBlue)
                        }
                        .disabled(!cardAnimationVM.isAnimationFinished(isCleared: gameVM.game.trainer?.hasBeenCleared))
                    }
                    
                    if !gameVM.game.isGameWon {
                        Button(action: {
                            gameVM.loadGame()
                            isShowingStart.toggle()
                        }) {
                            ActionButtonView(text: "RETRY", textColor: .white, textSize: 0.025, textStrokeColor: .steelBlue, buttonColor: .lightBlueApp, buttonStrokeColor: .steelBlue)
                        }
                        
                        Button(action: {
                            gameVM.adventure.tutorialTrainerState = .inSelection
                            gameVM.adventure.worldTrainerState = .inSelection
                            gameVM.resetGame()
                            gameVM.isShowingGameEnding.toggle()
                        }) {
                            ActionButtonView(text: "QUIT", textColor: .white, textSize: 0.025, textStrokeColor: .brownApp, buttonColor: .orangeApp, buttonStrokeColor: .steelBlue)
                        }
                    }
                }
                    .padding(.horizontal)
            )
            .padding()
    }
}

struct EndingMenuView_Previews: PreviewProvider {
    static var previews: some View {
        EndingMenuView(cards: Card.pokemons, isShowingStart: .constant(false))
    }
}
