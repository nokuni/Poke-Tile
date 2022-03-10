//
//  EndingMenuView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 09/03/2022.
//

import SwiftUI

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
                    Text(gameVM.game.isGameWon ? "Congratulation!" : "Defeat")
                        .foregroundColor(.black)
                        .font(.system(size: gameVM.game.isGameWon ? CGSize.screen.width * 0.1 : CGSize.screen.width * 0.15, weight: .bold, design: .rounded))
                    
                    if gameVM.game.isGameWon {
                        CardSummonAnimationView(cards: booster.cards, size: CGSize.screen)
                        Text("New cards !")
                            .foregroundColor(.black)
                            .font(.system(size: CGSize.screen.width * 0.04, weight: .bold, design: .rounded))
                    }
                    
                    if !gameVM.game.isGameWon {
                        Button(action: {
                            gameVM.loadGame()
                            isShowingStart.toggle()
                        }) {
                            ActionButtonView(text: "RETRY", textColor: .white, color: .steelBlue, size: CGSize.screen)
                        }
                    }
                    
                    Button(action: {
                        gameVM.resetGame()
                        dismiss?()
                    }) {
                        ActionButtonView(text: gameVM.game.isGameWon ? "OK" : "QUIT", textColor: .white, color: .crimson, size: CGSize.screen)
                    }
                }
                    .padding(.horizontal)
            )
            .padding()
    }
}

struct EndingMenuView_Previews: PreviewProvider {
    static var previews: some View {
        EndingMenuView(gameVM: GameViewModel(), dismiss: nil, booster: Booster.all[0], isShowingStart: .constant(false))
    }
}
