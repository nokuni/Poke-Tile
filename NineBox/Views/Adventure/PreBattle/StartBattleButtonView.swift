//
//  StartBattleButtonView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 05/03/2022.
//

import SwiftUI

struct StartBattleButtonView: View {
    @ObservedObject var gameVM: GameViewModel
    @ObservedObject var deckVM: DeckViewModel
    var trainer: Trainer
    var size: CGSize
    var body: some View {
        //NavigationLink(destination: GameView()) {
            Text("START BATTLE")
                .foregroundColor(.white)
                .font(.system(size: size.width * 0.05, weight: .bold, design: .rounded))
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.crimson)
                        .cornerRadius(5)
                        .shadow(color: .black, radius: 0, x: 3, y: 3)
                )
        //}
//        .padding(.vertical)
//        .simultaneousGesture(
//            TapGesture().onEnded { _ in
//                gameVM.createNewGame(trainer: trainer, deck: gameVM.filteredDecks(filter: .playable)[deckVM.selectedDeckIndex])
//            }
//        )
    }
}

struct StartBattleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StartBattleButtonView(gameVM: GameViewModel(), deckVM: DeckViewModel(), trainer: Trainer.trainers[0], size: CGSize.screen)
    }
}
