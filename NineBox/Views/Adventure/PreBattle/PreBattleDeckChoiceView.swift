//
//  PreBattleDeckChoiceView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

struct PreBattleDeckChoiceView: View {
    var decks: [Deck]
    var trainer: Trainer
    var size: CGSize
    @Binding var selectedDeckIndex: Int
    @EnvironmentObject var gameVM: GameViewModel
    var body: some View {
        if !gameVM.user.filteredDecks(filter: .playable).isEmpty {
            UserPreBattleDeckListView(decks: decks, selectedDeckIndex: $selectedDeckIndex, size: size, isPossessing: gameVM.user.isPossessing)
        }
        else {
            Text("You have no playable decks right now")
                .foregroundColor(.gray)
                .font(.system(size: size.width * 0.08, weight: .bold, design: .rounded))
                .frame(width: size.width, height: size.height * 0.2, alignment: .center)
        }
    }
}

struct PreBattleDeckChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        PreBattleDeckChoiceView(decks: [], trainer: Trainer.tutorialTrainers[0], size: CGSize.screen, selectedDeckIndex: .constant(0))
    }
}
